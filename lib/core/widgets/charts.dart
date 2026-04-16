import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:attackshield/core/theme/theme.dart';

/// Coverage breakdown donut chart.
/// Pass the breakdown map from riskCoverageBreakdownProvider.
/// { 'covered': N, 'partiallyCovered': N, 'notCovered': N, 'unknown': N }
class CoverageDonutChart extends StatefulWidget {
  final Map<String, int> breakdown;
  final double? size;

  const CoverageDonutChart({
    super.key,
    required this.breakdown,
    this.size,
  });

  @override
  State<CoverageDonutChart> createState() => _CoverageDonutChartState();
}

class _CoverageDonutChartState extends State<CoverageDonutChart> {
  int _touchedIndex = -1;

  static const _labels = {
    'covered': 'Covered',
    'partiallyCovered': 'Partial',
    'notCovered': 'Not Covered',
    'unknown': 'Unknown',
  };

  static const _colors = {
    'covered': AppTheme.successColor,
    'partiallyCovered': AppTheme.warningColor,
    'notCovered': AppTheme.dangerColor,
    'unknown': Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    final total = widget.breakdown.values
        .fold(0, (sum, v) => sum + v);

    if (total == 0) {
      return _emptyState(context);
    }

    final sections = widget.breakdown.entries
        .where((e) => e.value > 0)
        .toList()
        .asMap()
        .entries
        .map((entry) {
      final i = entry.key;
      final e = entry.value;
      final isTouched = i == _touchedIndex;
      final pct = (e.value / total * 100).toStringAsFixed(1);
      return PieChartSectionData(
        value: e.value.toDouble(),
        title: isTouched ? '$pct%' : '${e.value}',
        color: _colors[e.key] ?? Colors.grey,
        radius: isTouched ? 64 : 55,
        titleStyle: TextStyle(
          fontSize: isTouched ? 13 : 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    final chartSize = widget.size ?? 200.0;

    return Column(
      children: [
        SizedBox(
          width: chartSize,
          height: chartSize,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      _touchedIndex = -1;
                      return;
                    }
                    _touchedIndex =
                        response.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: sections,
              centerSpaceRadius: chartSize * 0.22,
              sectionsSpace: 3,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Legend
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: widget.breakdown.entries
              .where((e) => e.value > 0)
              .map(
                (e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _colors[e.key] ?? Colors.grey,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${_labels[e.key] ?? e.key} (${e.value})',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _emptyState(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.size ?? 200,
          height: widget.size ?? 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryColor.withValues(alpha: 0.05),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_outlined,
                  color: AppTheme.primaryColor, size: 36),
              const SizedBox(height: 8),
              Text(
                'No coverage\ndata yet',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Mark techniques as covered in the library',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}