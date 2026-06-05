import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:intl/intl.dart';

/// Line chart showing both coverage % and overall risk score trend.
/// Pass allReports from allReportsProvider (sorted newest-first).
/// Chart shows oldest-to-newest left-to-right.
class RiskTrendLineChart extends StatelessWidget {
  final List<ReportSummary> reports;

  const RiskTrendLineChart({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    if (reports.length < 2) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coverage Trend',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.show_chart,
                      color: AppTheme.primaryColor,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Generate at least 2 reports to see trends',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    }

    // Oldest first for the chart
    final ordered = [...reports]
      ..sort((a, b) => a.generatedAt.compareTo(b.generatedAt));

    final coverageSpots = ordered.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.coveragePercent);
    }).toList();
    final riskSpots = ordered.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.orgRiskScore);
    }).toList();

    // Date labels
    final dateLabels = ordered
        .map((r) => DateFormat('MMM d').format(r.generatedAt))
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coverage & Risk Trend',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Saved report history across ${ordered.length} snapshots',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: Colors.grey.withValues(alpha: 0.15),
                      strokeWidth: 1,
                    ),
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        interval: 25,
                        getTitlesWidget: (v, _) => Text(
                          '${v.toInt()}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        getTitlesWidget: (v, _) {
                          final i = v.toInt();
                          if (i < 0 || i >= dateLabels.length) {
                            return const SizedBox.shrink();
                          }
                          // Only show first, middle, last
                          if (i != 0 &&
                              i != dateLabels.length - 1 &&
                              i != dateLabels.length ~/ 2) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            dateLabels[i],
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 34,
                        interval: 25,
                        getTitlesWidget: (v, _) => Text(
                          '${v.toInt()}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((s) {
                          final isCoverage = s.barIndex == 0;
                          return LineTooltipItem(
                            '${isCoverage ? 'Coverage' : 'Risk'} ${s.y.toStringAsFixed(1)}',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: coverageSpots,
                      isCurved: true,
                      curveSmoothness: 0.3,
                      color: AppTheme.primaryColor,
                      barWidth: 2.5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        getDotPainter: (spot, xPercentage, barData, index) =>
                            FlDotCirclePainter(
                              radius: 4,
                              color: AppTheme.primaryColor,
                              strokeWidth: 2,
                              strokeColor: AppTheme.backgroundColor,
                            ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppTheme.primaryColor.withValues(alpha: 0.08),
                      ),
                    ),
                    LineChartBarData(
                      spots: riskSpots,
                      isCurved: true,
                      curveSmoothness: 0.25,
                      color: AppTheme.accentColor,
                      barWidth: 2.5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        getDotPainter: (spot, xPercentage, barData, index) =>
                            FlDotCirclePainter(
                              radius: 3.5,
                              color: AppTheme.accentColor,
                              strokeWidth: 2,
                              strokeColor: AppTheme.backgroundColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(label: 'Coverage', color: AppTheme.primaryColor),
                SizedBox(width: 16),
                _LegendItem(label: 'Risk', color: AppTheme.accentColor),
              ],
            ),
            const SizedBox(height: 12),
            // Summary: first vs last
            if (ordered.length >= 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TrendBadge(
                    label: 'First',
                    value:
                        '${ordered.first.coveragePercent.toStringAsFixed(1)}%',
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  _TrendBadge(
                    label: 'Latest',
                    value:
                        '${ordered.last.coveragePercent.toStringAsFixed(1)}%',
                    color:
                        ordered.last.coveragePercent >=
                            ordered.first.coveragePercent
                        ? AppTheme.successColor
                        : AppTheme.dangerColor,
                  ),
                  const SizedBox(width: 12),
                  _DeltaBadge(
                    delta:
                        ordered.last.coveragePercent -
                        ordered.first.coveragePercent,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _TrendBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _DeltaBadge extends StatelessWidget {
  final double delta;
  const _DeltaBadge({required this.delta});

  @override
  Widget build(BuildContext context) {
    final isPositive = delta >= 0;
    final color = isPositive ? AppTheme.successColor : AppTheme.dangerColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            '${isPositive ? '+' : ''}${delta.toStringAsFixed(1)}%',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
