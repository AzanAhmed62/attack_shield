import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:attackshield/core/services/asset_technique_mapper.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(allAssetsProvider);
    final countByTypeAsync = ref.watch(assetCountByTypeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Security Assets')),
      body: assetsAsync.when(
        data: (assets) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(allAssetsProvider),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Summary cards ────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        label: 'Total Assets',
                        value: '${assets.length}',
                        icon: Icons.layers,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SummaryCard(
                        label: 'Critical',
                        value:
                            '${assets.where((a) => a.criticality == AssetCriticality.critical).length}',
                        icon: Icons.warning_amber,
                        color: AppTheme.dangerColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Type distribution chart ──────────────────────────
                countByTypeAsync.when(
                  data: (counts) => counts.isNotEmpty
                      ? _AssetTypeChart(counts: counts)
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),

                // ── Asset list ───────────────────────────────────────
                const SectionHeader(title: 'All Assets'),
                const SizedBox(height: 12),
                assets.isEmpty
                    ? EmptyStateWidget(
                        title: 'No Assets Yet',
                        subtitle:
                            'Add your organization\'s security assets to improve coverage mapping.',
                        icon: Icons.layers_outlined,
                        actionLabel: 'Add Asset',
                        onActionPressed: () => _showCreateSheet(context, ref),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: assets.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (_, i) => _AssetCard(
                          asset: assets[i],
                          onEdit: () => _showEditSheet(context, ref, assets[i]),
                          onDelete: () async {
                            await ref.read(
                              deleteAssetProvider(assets[i].id).future,
                            );
                          },
                          onViewTechniques: () => _showRelatedTechniquesSheet(
                            context,
                            ref,
                            assets[i],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        loading: () => const LoadingWidget(message: 'Loading assets…'),
        error: (e, _) => EmptyStateWidget(
          title: 'Error',
          subtitle: e.toString(),
          icon: Icons.error_outline,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateSheet(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Asset'),
      ),
    );
  }

  void _showCreateSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AssetFormSheet(ref: ref),
    );
  }

  void _showEditSheet(
    BuildContext context,
    WidgetRef ref,
    SecurityAsset asset,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AssetFormSheet(ref: ref, existing: asset),
    );
  }

  Future<void> _showRelatedTechniquesSheet(
    BuildContext context,
    WidgetRef ref,
    SecurityAsset asset,
  ) async {
    final techniques = await ref.read(allTechniquesProvider.future);
    final related = AssetTechniqueMapper.relatedTechniques(asset, techniques);

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AssetTechniqueSheet(asset: asset, techniques: related),
    );
  }
}

// ─── Summary card ─────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(label, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Asset type pie chart ─────────────────────────────────────────────────────

class _AssetTypeChart extends StatelessWidget {
  final Map<String, int> counts;

  const _AssetTypeChart({required this.counts});

  static const _typeColors = {
    'Network': AppTheme.primaryColor,
    'Server': AppTheme.dangerColor,
    'Workstation': AppTheme.warningColor,
    'Application': AppTheme.successColor,
    'Cloud': AppTheme.accentColor,
  };

  @override
  Widget build(BuildContext context) {
    final sections = counts.entries.map((e) {
      final color = _typeColors[e.key] ?? Colors.grey;
      return PieChartSectionData(
        value: e.value.toDouble(),
        title: '${e.value}',
        color: color,
        radius: 55,
        titleStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Asset Distribution',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        centerSpaceRadius: 36,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: counts.entries
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: _typeColors[e.key] ?? Colors.grey,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${e.key} (${e.value})',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Asset card ───────────────────────────────────────────────────────────────

class _AssetCard extends StatelessWidget {
  final SecurityAsset asset;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onViewTechniques;

  const _AssetCard({
    required this.asset,
    required this.onEdit,
    required this.onDelete,
    required this.onViewTechniques,
  });

  IconData get _typeIcon {
    switch (asset.type) {
      case 'Network':
        return Icons.router;
      case 'Server':
        return Icons.dns;
      case 'Workstation':
        return Icons.computer;
      case 'Application':
        return Icons.apps;
      case 'Cloud':
        return Icons.cloud;
      default:
        return Icons.device_hub;
    }
  }

  Color get _critColor {
    switch (asset.criticality) {
      case AssetCriticality.critical:
        return AppTheme.dangerColor;
      case AssetCriticality.high:
        return AppTheme.accentColor;
      case AssetCriticality.medium:
        return AppTheme.warningColor;
      case AssetCriticality.low:
        return AppTheme.successColor;
    }
  }

  String get _critLabel {
    switch (asset.criticality) {
      case AssetCriticality.critical:
        return 'Critical';
      case AssetCriticality.high:
        return 'High';
      case AssetCriticality.medium:
        return 'Medium';
      case AssetCriticality.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tactics = AssetTechniqueMapper.recommendedTactics(asset);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _typeIcon,
                    color: AppTheme.primaryColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        asset.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        asset.type,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                // Criticality badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _critColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _critLabel,
                    style: TextStyle(
                      color: _critColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (asset.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                asset.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (asset.platforms.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: asset.platforms
                    .map(
                      (p) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          p,
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            if (tactics.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: tactics
                    .take(3)
                    .map(
                      (tactic) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _critColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          tactic,
                          style: TextStyle(
                            color: _critColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.edit, size: 14),
                  label: const Text('Edit'),
                  onPressed: onEdit,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                ),
                const SizedBox(width: 16),
                TextButton.icon(
                  icon: const Icon(Icons.library_books, size: 14),
                  label: const Text('View Techniques'),
                  onPressed: onViewTechniques,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.grey,
                  ),
                  onPressed: () => _confirmDelete(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Asset?'),
        content: Text('Delete "${asset.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppTheme.dangerColor),
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _AssetTechniqueSheet extends StatelessWidget {
  final SecurityAsset asset;
  final List<dynamic> techniques;

  const _AssetTechniqueSheet({required this.asset, required this.techniques});

  @override
  Widget build(BuildContext context) {
    final recommendedTactics = AssetTechniqueMapper.recommendedTactics(asset);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) => Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          controller: controller,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(asset.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            Text(
              'Recommended ATT&CK focus based on asset type, platforms, and risk relevance.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (recommendedTactics.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: recommendedTactics
                    .map((tactic) => Chip(label: Text(tactic)))
                    .toList(),
              ),
            ],
            const SizedBox(height: 16),
            if (techniques.isEmpty)
              const EmptyStateWidget(
                title: 'No Related Techniques',
                subtitle:
                    'This asset does not currently map to any ATT&CK techniques with the active logic.',
                icon: Icons.library_books_outlined,
              )
            else
              ...techniques.map(
                (technique) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/technique/${technique.id}');
                    },
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor.withValues(
                        alpha: 0.12,
                      ),
                      child: Text(
                        technique.id.replaceFirst('T', ''),
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    title: Text(technique.name),
                    subtitle: Text(
                      technique.tactics.join(' · '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      technique.riskScore.toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Asset form sheet (Create / Edit) ────────────────────────────────────────

class _AssetFormSheet extends StatefulWidget {
  final WidgetRef ref;
  final SecurityAsset? existing;

  const _AssetFormSheet({required this.ref, this.existing});

  @override
  State<_AssetFormSheet> createState() => _AssetFormSheetState();
}

class _AssetFormSheetState extends State<_AssetFormSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  String _type = 'Server';
  AssetCriticality _criticality = AssetCriticality.medium;
  final List<String> _platforms = [];
  final _platCtrl = TextEditingController();

  static const _types = [
    'Network',
    'Server',
    'Workstation',
    'Application',
    'Cloud',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existing?.name ?? '');
    _descCtrl = TextEditingController(text: widget.existing?.description ?? '');
    if (widget.existing != null) {
      _type = widget.existing!.type.isEmpty ? 'Server' : widget.existing!.type;
      _criticality = widget.existing!.criticality;
      _platforms.addAll(widget.existing!.platforms);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _platCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isEdit ? 'Edit Asset' : 'Add Asset',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Asset Name *',
                prefixIcon: Icon(Icons.label),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),

            // Type dropdown
            Text('Asset Type', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(),
              items: _types
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _type = v ?? 'Server'),
            ),
            const SizedBox(height: 10),

            // Criticality
            Text('Criticality', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 6),
            Row(
              children: AssetCriticality.values.map((c) {
                final isSelected = _criticality == c;
                final color = _critColor(c);
                final label = c.name[0].toUpperCase() + c.name.substring(1);
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _criticality = c),
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? color.withValues(alpha: 0.2)
                            : color.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? color
                              : color.withValues(alpha: 0.3),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // Platforms
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _platCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Platform',
                      hintText: 'e.g. Windows',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    final p = _platCtrl.text.trim();
                    if (p.isNotEmpty && !_platforms.contains(p)) {
                      setState(() => _platforms.add(p));
                      _platCtrl.clear();
                    }
                  },
                ),
              ],
            ),
            if (_platforms.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                children: _platforms
                    .map(
                      (p) => Chip(
                        label: Text(p),
                        onDeleted: () => setState(() => _platforms.remove(p)),
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(isEdit ? Icons.save : Icons.add),
                label: Text(isEdit ? 'Save Changes' : 'Add Asset'),
                onPressed: () async {
                  if (_nameCtrl.text.trim().isEmpty) return;
                  final asset = SecurityAsset(
                    id: widget.existing?.id ?? const Uuid().v4(),
                    name: _nameCtrl.text.trim(),
                    description: _descCtrl.text.trim(),
                    type: _type,
                    criticality: _criticality,
                    platforms: List.from(_platforms),
                    discoveredAt:
                        widget.existing?.discoveredAt ?? DateTime.now(),
                    lastScanned: DateTime.now(),
                  );
                  if (isEdit) {
                    await widget.ref.read(updateAssetProvider(asset).future);
                  } else {
                    await widget.ref.read(createAssetProvider(asset).future);
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isEdit ? 'Asset updated' : 'Asset added'),
                        backgroundColor: AppTheme.successColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _critColor(AssetCriticality c) {
    switch (c) {
      case AssetCriticality.critical:
        return AppTheme.dangerColor;
      case AssetCriticality.high:
        return AppTheme.accentColor;
      case AssetCriticality.medium:
        return AppTheme.warningColor;
      case AssetCriticality.low:
        return AppTheme.successColor;
    }
  }
}
