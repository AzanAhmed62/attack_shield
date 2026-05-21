// lib/shared/widgets/main_scaffold.dart
// FULL REPLACEMENT — correct bottom nav destinations with proper labels,
// icons, and routes. No wrong navigation paths.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  final String location;
  const MainScaffold({super.key, required this.child, required this.location});

  static const _destinations = [
    _Dest(
      route: '/dashboard',
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard_rounded,
      label: 'Dashboard',
    ),
    _Dest(
      route: '/library',
      icon: Icons.dataset_outlined,
      activeIcon: Icons.dataset_rounded,
      label: 'Library',
    ),
    _Dest(
      route: '/coverage',
      icon: Icons.map_outlined,
      activeIcon: Icons.map_rounded,
      label: 'Coverage',
    ),
    _Dest(
      route: '/simulations',
      icon: Icons.science_outlined,
      activeIcon: Icons.science_rounded,
      label: 'Simulate',
    ),
    _Dest(
      route: '/alerts',
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications_rounded,
      label: 'Alerts',
    ),
  ];

  int get _selectedIndex {
    for (int i = 0; i < _destinations.length; i++) {
      if (location.startsWith(_destinations[i].route)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final idx = _selectedIndex;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (i) {
          if (i != idx) context.go(_destinations[i].route);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: _destinations.asMap().entries.map((e) {
          final dest = e.value;
          return NavigationDestination(
            icon: Icon(dest.icon),
            selectedIcon: Icon(dest.activeIcon, color: cs.primary),
            label: dest.label,
          );
        }).toList(),
      ),
    );
  }
}

class _Dest {
  final String route, label;
  final IconData icon, activeIcon;
  const _Dest({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
