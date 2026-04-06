import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAlertsAsync = ref.watch(filteredAlertsProvider);
    final criticalCountAsync = ref.watch(criticalAlertCountProvider);
    final selectedPriority = ref.watch(selectedAlertPriorityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Alerts'),
        actions: [
          criticalCountAsync.when(
            data: (n) => n > 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Badge(
                      label: Text('$n'),
                      child: const Icon(Icons.notifications_active),
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SearchField(
              hintText: 'Search alerts…',
              onChanged: (v) =>
                  ref.read(alertSearchQueryProvider.notifier).update(v),
            ),
          ),

          // ── Priority filter chips ─────────────────────────────────────
          SizedBox(
            height: 44,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              scrollDirection: Axis.horizontal,
              children: [
                _PriorityChip(
                  label: 'All',
                  selected: selectedPriority == null,
                  color: AppTheme.primaryColor,
                  onTap: () =>
                      ref.read(selectedAlertPriorityProvider.notifier).clear(),
                ),
                const SizedBox(width: 8),
                _PriorityChip(
                  label: 'Critical',
                  selected: selectedPriority == AlertPriority.critical,
                  color: AppTheme.dangerColor,
                  onTap: () => ref
                      .read(selectedAlertPriorityProvider.notifier)
                      .select(AlertPriority.critical),
                ),
                const SizedBox(width: 8),
                _PriorityChip(
                  label: 'High',
                  selected: selectedPriority == AlertPriority.high,
                  color: AppTheme.accentColor,
                  onTap: () => ref
                      .read(selectedAlertPriorityProvider.notifier)
                      .select(AlertPriority.high),
                ),
                const SizedBox(width: 8),
                _PriorityChip(
                  label: 'Medium',
                  selected: selectedPriority == AlertPriority.medium,
                  color: AppTheme.warningColor,
                  onTap: () => ref
                      .read(selectedAlertPriorityProvider.notifier)
                      .select(AlertPriority.medium),
                ),
                const SizedBox(width: 8),
                _PriorityChip(
                  label: 'Low',
                  selected: selectedPriority == AlertPriority.low,
                  color: AppTheme.successColor,
                  onTap: () => ref
                      .read(selectedAlertPriorityProvider.notifier)
                      .select(AlertPriority.low),
                ),
              ],
            ),
          ),

          // ── Status tabs ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children:
                  AlertStatus.values.map((s) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _StatusTab(
                          label: _statusLabel(s),
                          selected:
                              ref.watch(selectedAlertStatusProvider) == s.name,
                          onTap: () => ref
                              .read(selectedAlertStatusProvider.notifier)
                              .select(s.name),
                        ),
                      ),
                    );
                  }).toList()..insert(
                    0,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _StatusTab(
                          label: 'All',
                          selected:
                              ref.watch(selectedAlertStatusProvider) == '',
                          onTap: () => ref
                              .read(selectedAlertStatusProvider.notifier)
                              .clear(),
                        ),
                      ),
                    ),
                  ),
            ),
          ),

          // ── Alert list ────────────────────────────────────────────────
          Expanded(
            child: filteredAlertsAsync.when(
              data: (alerts) => alerts.isEmpty
                  ? EmptyStateWidget(
                      title: 'No Alerts',
                      subtitle: 'Your security feed is clear',
                      icon: Icons.notifications_none,
                      actionLabel: 'Create Alert',
                      onActionPressed: () => _showCreateSheet(context, ref),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: alerts.length,
                      itemBuilder: (_, i) => _AlertCard(
                        alert: alerts[i],
                        onTap: () => _showDetail(context, ref, alerts[i]),
                        onStatusChanged: (s) =>
                            _updateStatus(ref, alerts[i], s),
                      ),
                    ),
              loading: () => const LoadingWidget(message: 'Loading alerts…'),
              error: (e, _) => EmptyStateWidget(
                title: 'Error',
                subtitle: e.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateSheet(context, ref),
        icon: const Icon(Icons.add_alert),
        label: const Text('New Alert'),
      ),
    );
  }

  String _statusLabel(AlertStatus s) {
    switch (s) {
      case AlertStatus.open:
        return 'Open';
      case AlertStatus.acknowledged:
        return 'Ack\'d';
      case AlertStatus.resolved:
        return 'Resolved';
    }
  }

  void _updateStatus(WidgetRef ref, AlertItem alert, AlertStatus newStatus) {
    final updated = alert.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );
    ref.read(updateAlertProvider(updated));
  }

  void _showDetail(BuildContext context, WidgetRef ref, AlertItem alert) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AlertDetailSheet(alert: alert, ref: ref),
    );
  }

  void _showCreateSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _CreateAlertSheet(ref: ref),
    );
  }
}

// ─── Alert card ───────────────────────────────────────────────────────────────

class _AlertCard extends StatelessWidget {
  final AlertItem alert;
  final VoidCallback onTap;
  final Function(AlertStatus) onStatusChanged;

  const _AlertCard({
    required this.alert,
    required this.onTap,
    required this.onStatusChanged,
  });

  Color get _priorityColor {
    switch (alert.priority) {
      case AlertPriority.critical:
        return AppTheme.dangerColor;
      case AlertPriority.high:
        return AppTheme.accentColor;
      case AlertPriority.medium:
        return AppTheme.warningColor;
      case AlertPriority.low:
        return AppTheme.successColor;
    }
  }

  String get _priorityLabel {
    switch (alert.priority) {
      case AlertPriority.critical:
        return 'CRITICAL';
      case AlertPriority.high:
        return 'HIGH';
      case AlertPriority.medium:
        return 'MEDIUM';
      case AlertPriority.low:
        return 'LOW';
    }
  }

  Color get _statusColor {
    switch (alert.status) {
      case AlertStatus.open:
        return AppTheme.dangerColor;
      case AlertStatus.acknowledged:
        return AppTheme.warningColor;
      case AlertStatus.resolved:
        return AppTheme.successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pc = _priorityColor;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Priority bar
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: pc,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: pc.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _priorityLabel,
                            style: TextStyle(
                              color: pc,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (alert.relatedTechniqueId != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              alert.relatedTechniqueId!,
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        const Spacer(),
                        Text(
                          DateFormat('MMM d').format(alert.createdAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      alert.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      alert.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  alert.status.name,
                  style: TextStyle(
                    color: _statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Alert detail sheet ───────────────────────────────────────────────────────

class _AlertDetailSheet extends StatelessWidget {
  final AlertItem alert;
  final WidgetRef ref;

  const _AlertDetailSheet({required this.alert, required this.ref});

  Color get _priorityColor {
    switch (alert.priority) {
      case AlertPriority.critical:
        return AppTheme.dangerColor;
      case AlertPriority.high:
        return AppTheme.accentColor;
      case AlertPriority.medium:
        return AppTheme.warningColor;
      case AlertPriority.low:
        return AppTheme.successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
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

            // Priority badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _priorityColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    alert.priority.name.toUpperCase(),
                    style: TextStyle(
                      color: _priorityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    alert.status.name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(alert.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Source: ${alert.source}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Created: ${DateFormat('MMM d, yyyy – HH:mm').format(alert.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text('Description', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              alert.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            // ATT&CK link
            if (alert.relatedTechniqueId != null) ...[
              const SizedBox(height: 16),
              Text(
                'Related ATT&CK Technique',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.push('/technique/${alert.relatedTechniqueId}');
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.open_in_new,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'View ${alert.relatedTechniqueId} →',
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            if (alert.notes != null && alert.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Notes', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(alert.notes!, style: Theme.of(context).textTheme.bodyMedium),
            ],

            const SizedBox(height: 20),
            Text(
              'Update Status',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: AlertStatus.values.map((s) {
                final c = _statusColor(s);
                final isCurrent = alert.status == s;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: c,
                        side: BorderSide(
                          color: isCurrent ? c : c.withValues(alpha: 0.4),
                        ),
                        backgroundColor: isCurrent
                            ? c.withValues(alpha: 0.12)
                            : null,
                      ),
                      onPressed: isCurrent
                          ? null
                          : () {
                              final updated = alert.copyWith(
                                status: s,
                                updatedAt: DateTime.now(),
                              );
                              ref.read(updateAlertProvider(updated));
                              Navigator.pop(context);
                            },
                      child: Text(s.name, style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(AlertStatus s) {
    switch (s) {
      case AlertStatus.open:
        return AppTheme.dangerColor;
      case AlertStatus.acknowledged:
        return AppTheme.warningColor;
      case AlertStatus.resolved:
        return AppTheme.successColor;
    }
  }
}

// ─── Create alert sheet ───────────────────────────────────────────────────────

class _CreateAlertSheet extends StatefulWidget {
  final WidgetRef ref;
  const _CreateAlertSheet({required this.ref});

  @override
  State<_CreateAlertSheet> createState() => _CreateAlertSheetState();
}

class _CreateAlertSheetState extends State<_CreateAlertSheet> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _sourceCtrl = TextEditingController();
  final _techCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  AlertPriority _priority = AlertPriority.medium;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _sourceCtrl.dispose();
    _techCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  static const _priorityColors = {
    AlertPriority.critical: AppTheme.dangerColor,
    AlertPriority.high: AppTheme.accentColor,
    AlertPriority.medium: AppTheme.warningColor,
    AlertPriority.low: AppTheme.successColor,
  };

  @override
  Widget build(BuildContext context) {
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
              'Create Security Alert',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Alert Title *',
                prefixIcon: Icon(Icons.warning_amber),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sourceCtrl,
              decoration: const InputDecoration(
                labelText: 'Source',
                hintText: 'e.g. SIEM, SOC, External',
                prefixIcon: Icon(Icons.source),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _techCtrl,
              decoration: const InputDecoration(
                labelText: 'Related ATT&CK Technique ID',
                hintText: 'e.g. T1566',
                prefixIcon: Icon(Icons.link),
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'Notes',
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            Text('Priority', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Row(
              children: AlertPriority.values.map((p) {
                final isSelected = _priority == p;
                final c = _priorityColors[p]!;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _priority = p),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? c.withValues(alpha: 0.2)
                            : c.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? c : c.withValues(alpha: 0.3),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        p.name[0].toUpperCase() + p.name.substring(1),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: c,
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
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_alert),
                label: const Text('Create Alert'),
                onPressed: () async {
                  if (_titleCtrl.text.trim().isEmpty) return;
                  final alert = AlertItem(
                    id: const Uuid().v4(),
                    title: _titleCtrl.text.trim(),
                    description: _descCtrl.text.trim(),
                    priority: _priority,
                    status: AlertStatus.open,
                    source: _sourceCtrl.text.trim().isEmpty
                        ? 'Manual Entry'
                        : _sourceCtrl.text.trim(),
                    relatedTechniqueId: _techCtrl.text.trim().isEmpty
                        ? null
                        : _techCtrl.text.trim().toUpperCase(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    notes: _notesCtrl.text.trim().isEmpty
                        ? null
                        : _notesCtrl.text.trim(),
                  );
                  await widget.ref.read(createAlertProvider(alert).future);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Alert "${alert.title}" created'),
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
}

// ─── Filter chips ─────────────────────────────────────────────────────────────

class _PriorityChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _PriorityChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.2)
              : color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.4),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _StatusTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _StatusTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? AppTheme.primaryColor
                : Colors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? AppTheme.primaryColor : Colors.grey,
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
