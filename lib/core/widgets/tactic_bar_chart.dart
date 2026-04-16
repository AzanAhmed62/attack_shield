import 'package:flutter/material.dart';
import 'package:attackshield/core/theme/theme.dart';

/// Horizontal bar chart showing the exposed risk score per ATT&CK tactic.
/// Pass tacticRiskMap from tacticRiskMapProvider.
/// { tacticName → riskScore 0–10 }
class TacticBarChart extends StatelessWidget {
  final Map<String, double> tacticRisks;
  final int maxBars;

  const TacticBarChart({
    super.key,
    required this.tacticRisks,
    this.maxBars = 10,
  });

  Color _barColor(double risk) {
    if (risk >= 7.0) return AppTheme.dangerColor;
    if (risk >= 5.0) return AppTheme.accentColor;
    if (risk >= 3.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  @override
  Widget build(BuildContext context) {
    if (tacticRisks.isEmpty) {
      return const SizedBox.shrink();
    }

    // Sort by risk descending, take top N
    final sorted = tacticRisks.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final displayed = sorted.take(maxBars).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Risk by Tactic',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Exposed risk score per ATT&CK kill-chain phase (0–10)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            // Build manual bar chart (cleaner than fl_chart BarChart for horizontal)
            ...displayed.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text(
                            e.key,
                            style:
                                Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              // Background track
                              Container(
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              // Filled bar
                              FractionallySizedBox(
                                widthFactor: (e.value / 10.0).clamp(0.0, 1.0),
                                child: Container(
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: _barColor(e.value),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 30,
                          child: Text(
                            e.value.toStringAsFixed(1),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: _barColor(e.value),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Legend
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendDot('Critical (7+)', AppTheme.dangerColor),
                SizedBox(width: 12),
                _LegendDot('High (5+)', AppTheme.accentColor),
                SizedBox(width: 12),
                _LegendDot('Medium (3+)', AppTheme.warningColor),
                SizedBox(width: 12),
                _LegendDot('Low', AppTheme.successColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendDot(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 10)),
      ],
    );
  }
}
