// lib/core/widgets/main_scaffold.dart
// Correct location: lib/core/widgets/ — imported by app_router.dart as
// '../../core/widgets/main_scaffold.dart'

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  final String location;
  const MainScaffold({super.key, required this.child, required this.location});

  static const _destinations = [
    _Dest(
      '/dashboard',
      Icons.dashboard_outlined,
      Icons.dashboard_rounded,
      'Dashboard',
    ),
    _Dest('/library', Icons.dataset_outlined, Icons.dataset_rounded, 'Library'),
    _Dest('/coverage', Icons.map_outlined, Icons.map_rounded, 'Coverage'),
    _Dest(
      '/simulations',
      Icons.science_outlined,
      Icons.science_rounded,
      'Simulate',
    ),
    _Dest(
      '/alerts',
      Icons.notifications_outlined,
      Icons.notifications_rounded,
      'Alerts',
    ),
    _Dest(
      '/settings',
      Icons.settings_outlined,
      Icons.settings_rounded,
      'Settings',
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
          final d = e.value;
          return NavigationDestination(
            icon: Icon(d.icon),
            selectedIcon: Icon(d.activeIcon, color: cs.primary),
            label: d.label,
          );
        }).toList(),
      ),
    );
  }
}

class _Dest {
  final String route, label;
  final IconData icon, activeIcon;
  const _Dest(this.route, this.icon, this.activeIcon, this.label);
}
