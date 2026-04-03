import 'package:flutter/material.dart';

/// Dashboard chart widget placeholder
class DashboardChartWidget extends StatelessWidget {
  const DashboardChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
      ),
      child: const Center(child: Text('Chart Placeholder')),
    );
  }
}
