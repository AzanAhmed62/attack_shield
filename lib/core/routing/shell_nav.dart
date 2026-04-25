import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/providers/providers.dart';

/// Shell widget that hosts the persistent bottom navigation bar.
/// Wraps all top-level screens so nav is available everywhere.
class ShellScaffold extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final criticalAsync = ref.watch(criticalAlertCountProvider);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            // Return to first tab's root when re-tapping current tab
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          const NavigationDestination(
            icon: Icon(Icons.library_books_outlined),
            selectedIcon: Icon(Icons.library_books),
            label: 'Library',
          ),
          const NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield),
            label: 'Coverage',
          ),
          // Alerts tab with badge when criticals exist
          NavigationDestination(
            icon: criticalAsync.when(
              data: (n) => n > 0
                  ? Badge(
                      label: Text('$n', style: const TextStyle(fontSize: 10)),
                      child: const Icon(Icons.notifications_outlined),
                    )
                  : const Icon(Icons.notifications_outlined),
              loading: () => const Icon(Icons.notifications_outlined),
              error: (_, _) => const Icon(Icons.notifications_outlined),
            ),
            selectedIcon: criticalAsync.when(
              data: (n) => n > 0
                  ? Badge(
                      label: Text('$n', style: const TextStyle(fontSize: 10)),
                      child: const Icon(Icons.notifications),
                    )
                  : const Icon(Icons.notifications),
              loading: () => const Icon(Icons.notifications),
              error: (_, _) => const Icon(Icons.notifications),
            ),
            label: 'Alerts',
          ),
          const NavigationDestination(
            icon: Icon(Icons.more_horiz_outlined),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

/// "More" screen — secondary nav to Simulations, Reports, Bookmarks,
/// Assets, and Settings. Accessible from the 5th bottom nav tab.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MoreTile(
            icon: Icons.science_outlined,
            label: 'Simulations',
            subtitle: 'Readiness tests & scenarios',
            color: AppTheme.warningColor,
            onTap: () => context.push('/more/simulations'),
          ),
          _MoreTile(
            icon: Icons.assessment_outlined,
            label: 'Reports',
            subtitle: 'Security posture reports & PDF export',
            color: AppTheme.accentColor,
            onTap: () => context.push('/more/reports'),
          ),
          _MoreTile(
            icon: Icons.bookmark_border,
            label: 'Bookmarks',
            subtitle: 'Saved ATT&CK techniques',
            color: AppTheme.primaryColor,
            onTap: () => context.push('/more/bookmarks'),
          ),
          _MoreTile(
            icon: Icons.layers_outlined,
            label: 'Assets',
            subtitle: 'Manage your security assets',
            color: AppTheme.successColor,
            onTap: () => context.push('/more/assets'),
          ),
          _MoreTile(
            icon: Icons.document_scanner_outlined,
            label: 'Threat Intel Mapper',
            subtitle:
                'Paste text → AI maps to ATT&CK techniques + creates alert',
            color: AppTheme.primaryColor,
            onTap: () => context.push('/threat-intel'),
          ),
          _MoreTile(
            icon: Icons.settings_outlined,
            label: 'Settings',
            subtitle: 'Preferences, org profile & data management',
            color: Colors.grey,
            onTap: () => context.push('/more/settings'),
          ),
        ],
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MoreTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(label, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
