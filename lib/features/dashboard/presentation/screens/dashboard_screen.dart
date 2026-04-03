import 'package:attackshield/core/widgets/common_widgets.dart';
import 'package:attackshield/core/widgets/custom_widgets.dart';
import 'package:attackshield/shared/providers/coverage_providers.dart';
import 'package:attackshield/shared/providers/technique_providers.dart';
import 'package:attackshield/shared/providers/alert_providers.dart';
import 'package:attackshield/shared/providers/asset_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coveragePercentageAsync = ref.watch(coveragePercentageProvider);
    final allTechniqueAsync = ref.watch(allTechniquesProvider);
    final alertCountAsync = ref.watch(alertCountProvider);
    final criticalAlertsAsync = ref.watch(criticalAlertCountProvider);
    final allAssetsAsync = ref.watch(allAssetsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ATT&CK Defender'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coverage Summary
            SectionHeader(
              title: 'Coverage Summary',
              showViewAll: true,
              onViewAllPressed: () => context.push('/coverage'),
            ),
            const SizedBox(height: 16),
            coveragePercentageAsync.when(
              data: (percentage) => MetricCard(
                label: 'Coverage Score',
                value: '${percentage.toStringAsFixed(1)}%',
                subtitle: 'Techniques covered by controls',
                icon: Icons.shield,
              ),
              loading: () => const LoadingWidget(),
              error: (err, st) => MetricCard(
                label: 'Coverage Score',
                value: 'Error',
                subtitle: 'Failed to load coverage',
              ),
            ),
            const SizedBox(height: 24),

            // Techniques Overview
            SectionHeader(
              title: 'Techniques Overview',
              showViewAll: true,
              onViewAllPressed: () => context.push('/library'),
            ),
            const SizedBox(height: 16),
            allTechniqueAsync.when(
              data: (techniques) => MetricCard(
                label: 'Total Techniques',
                value: techniques.length.toString(),
                subtitle: 'Across all tactics',
                icon: Icons.category,
              ),
              loading: () => const LoadingWidget(),
              error: (err, st) => MetricCard(
                label: 'Total Techniques',
                value: 'Error',
                subtitle: 'Failed to load',
              ),
            ),
            const SizedBox(height: 24),

            // Security Metrics
            SectionHeader(
              title: 'Security Metrics',
              showViewAll: true,
              onViewAllPressed: () => context.push('/alerts'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: alertCountAsync.when(
                    data: (count) => MetricCard(
                      label: 'Open Alerts',
                      value: count.toString(),
                      subtitle: 'Active security alerts',
                      icon: Icons.warning,
                    ),
                    loading: () => const LoadingWidget(),
                    error: (err, st) => MetricCard(
                      label: 'Open Alerts',
                      value: 'Error',
                      subtitle: 'Failed to load',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: criticalAlertsAsync.when(
                    data: (count) => MetricCard(
                      label: 'Critical',
                      value: count.toString(),
                      valueColor: Colors.red,
                      subtitle: 'Highest priority alerts',
                      icon: Icons.error,
                    ),
                    loading: () => const LoadingWidget(),
                    error: (err, st) => MetricCard(
                      label: 'Critical',
                      value: 'Error',
                      subtitle: 'Failed to load',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            allAssetsAsync.when(
              data: (assets) => MetricCard(
                label: 'Total Assets',
                value: assets.length.toString(),
                subtitle: 'Monitored security assets',
                icon: Icons.layers,
              ),
              loading: () => const LoadingWidget(),
              error: (err, st) => MetricCard(
                label: 'Total Assets',
                value: 'Error',
                subtitle: 'Failed to load',
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Quick Actions'),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              children: [
                _QuickActionCard(
                  label: 'Technique Library',
                  icon: Icons.library_books,
                  onTap: () => context.push('/library'),
                ),
                _QuickActionCard(
                  label: 'Coverage Mapping',
                  icon: Icons.map,
                  onTap: () => context.push('/coverage'),
                ),
                _QuickActionCard(
                  label: 'Simulations',
                  icon: Icons.play_arrow,
                  onTap: () => context.push('/simulations'),
                ),
                _QuickActionCard(
                  label: 'Reports',
                  icon: Icons.assessment,
                  onTap: () => context.push('/reports'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    label: 'Alerts',
                    icon: Icons.notifications,
                    onTap: () => context.push('/alerts'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _QuickActionCard(
                    label: 'Settings',
                    icon: Icons.settings,
                    onTap: () => context.push('/settings'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
