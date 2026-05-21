import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:attackshield/shared/providers/providers.dart';

class CoverageEditorCard extends ConsumerStatefulWidget {
  final String techniqueId;
  final double riskScore;
  final String title;
  final String? subtitle;

  const CoverageEditorCard({
    super.key,
    required this.techniqueId,
    required this.riskScore,
    this.title = 'Defensive Coverage',
    this.subtitle,
  });

  @override
  ConsumerState<CoverageEditorCard> createState() => _CoverageEditorCardState();
}

class _CoverageEditorCardState extends ConsumerState<CoverageEditorCard> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _controlController = TextEditingController();

  CoverageLevel _selectedLevel = CoverageLevel.notCovered;
  List<String> _relatedControls = <String>[];
  String _hydrationKey = '';
  bool _saving = false;

  @override
  void dispose() {
    _notesController.dispose();
    _controlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coverageAsync = ref.watch(
      techniqueCoverageStatusProvider(widget.techniqueId),
    );

    return coverageAsync.when(
      data: (coverage) {
        _hydrateFromCoverage(coverage);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.security, color: AppTheme.primaryColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (widget.subtitle != null)
                            Text(
                              widget.subtitle!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    ),
                    _StatusBadge(
                      level: _selectedLevel,
                      color: _levelColor(_selectedLevel),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: CoverageLevel.values.map((level) {
                    final isSelected = _selectedLevel == level;
                    final color = _levelColor(level);
                    return ChoiceChip(
                      label: Text(_levelLabel(level)),
                      selected: isSelected,
                      selectedColor: color.withValues(alpha: 0.18),
                      labelStyle: TextStyle(
                        color: color,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? color
                            : color.withValues(alpha: 0.4),
                      ),
                      onSelected: (_) async {
                        setState(() => _selectedLevel = level);
                        await _save(context);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Risk Engine: ${widget.riskScore.toStringAsFixed(1)} x '
                    '${_coverageMultiplier(_selectedLevel).toStringAsFixed(1)} = '
                    '${(widget.riskScore * _coverageMultiplier(_selectedLevel)).toStringAsFixed(2)} / 10',
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Coverage Notes',
                    hintText: 'Document detections, gaps, or analyst notes',
                    prefixIcon: Icon(Icons.note_alt_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Related Controls',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controlController,
                        decoration: const InputDecoration(
                          hintText: 'e.g. EDR, SIEM rule, MFA',
                        ),
                        onSubmitted: (_) => _addControl(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _addControl,
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                if (_relatedControls.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _relatedControls
                        .map(
                          (control) => InputChip(
                            label: Text(control),
                            onDeleted: () {
                              setState(() => _relatedControls.remove(control));
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saving ? null : () => _save(context),
                    icon: Icon(_saving ? Icons.sync : Icons.save_outlined),
                    label: Text(
                      _saving ? 'Saving...' : 'Save Notes & Controls',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Failed to load coverage: $error'),
        ),
      ),
    );
  }

  void _hydrateFromCoverage(CoverageStatus? coverage) {
    final nextKey =
        '${coverage?.level.name}|${coverage?.notes}|${coverage?.relatedControls.join('|')}';
    if (_hydrationKey == nextKey) return;
    _hydrationKey = nextKey;
    _selectedLevel = coverage?.level ?? CoverageLevel.notCovered;
    _notesController.text = coverage?.notes ?? '';
    _relatedControls = List<String>.from(coverage?.relatedControls ?? const []);
  }

  void _addControl() {
    final control = _controlController.text.trim();
    if (control.isEmpty || _relatedControls.contains(control)) return;
    setState(() {
      _relatedControls = [..._relatedControls, control];
      _controlController.clear();
    });
  }

  Future<void> _save(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);
    try {
      final status = CoverageStatus(
        techniqueId: widget.techniqueId,
        level: _selectedLevel,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        relatedControls: List<String>.from(_relatedControls),
        lastUpdated: DateTime.now(),
      );
      // Save directly to the coverage repository via provider
      await ref.read(coverageRepositoryProvider).updateCoverageStatus(status);
      ref.invalidate(allCoverageStatusesProvider);
      _hydrationKey = '';
      if (mounted) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Coverage updated'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Color _levelColor(CoverageLevel level) {
    switch (level) {
      case CoverageLevel.covered:
        return AppTheme.successColor;
      case CoverageLevel.partiallyCovered:
        return AppTheme.warningColor;
      case CoverageLevel.unknown:
        return Colors.grey;
      case CoverageLevel.notCovered:
        return AppTheme.dangerColor;
    }
  }

  String _levelLabel(CoverageLevel level) {
    switch (level) {
      case CoverageLevel.covered:
        return 'Covered';
      case CoverageLevel.partiallyCovered:
        return 'Partial';
      case CoverageLevel.unknown:
        return 'Unknown';
      case CoverageLevel.notCovered:
        return 'Not Covered';
    }
  }

  double _coverageMultiplier(CoverageLevel level) {
    switch (level) {
      case CoverageLevel.covered:
        return 0.0;
      case CoverageLevel.partiallyCovered:
        return 0.5;
      case CoverageLevel.unknown:
        return 0.7;
      case CoverageLevel.notCovered:
        return 1.0;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final CoverageLevel level;
  final Color color;

  const _StatusBadge({required this.level, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        level.name,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
