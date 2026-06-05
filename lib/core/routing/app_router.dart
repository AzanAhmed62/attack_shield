// lib/core/routing/app_router.dart
// FULL REPLACEMENT — correct import paths matching actual repo structure.
// Keeps /technique/:id as a redirect for backward compatibility with any
// old context.push('/technique/$id') calls in unchanged screens.

import 'package:attackshield/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_storage/get_storage.dart';

// ── Screens — use actual paths from repo directory structure ──────────────────
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/attack_library/presentation/screens/attack_library_screen.dart';
import '../../features/technique_detail/presentation/screens/technique_detail_screen.dart';
import '../../features/threat_mapping/presentation/screens/threat_mapping_screen.dart';
import '../../features/alerts/presentation/screens/alerts_screen.dart';
import '../../features/alerts/presentation/screens/create_alert_screen.dart';
import '../../features/simulations/presentation/screens/simulations_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../core/widgets/main_scaffold.dart';

part 'app_router.g.dart';

// ─── Route path constants ─────────────────────────────────────────────────────
class AppRoutes {
  static const onboarding = '/onboarding';
  static const dashboard = '/dashboard';
  static const library = '/library';
  static const libraryDetail = '/library/:id';
  static const technique = '/technique/:id'; // legacy compat alias
  static const coverage = '/coverage';
  static const alerts = '/alerts';
  static const createAlert = '/alerts/create';
  static const simulations = '/simulations';
  static const reports = '/reports';
  static const settings = '/settings';
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    debugLogDiagnostics: false,

    // ── Onboarding guard ──────────────────────────────────────────────────
    redirect: (context, state) {
      final storage = GetStorage();
      final hasOnboarded =
          storage.read<bool>(AppConstants.storageKeyOnboardingComplete) ??
          false;
      final loc = state.matchedLocation;
      final isSetup = loc == AppRoutes.onboarding;

      if (!hasOnboarded && !isSetup) return AppRoutes.onboarding;
      return null;
    },

    routes: [
      // ── Root route redirect ───────────────────────────────────────────
      GoRoute(
        path: '/',
        name: 'root',
        redirect: (_, __) => AppRoutes.dashboard,
      ),

      // ── Onboarding (outside shell) ────────────────────────────────────
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),

      // ── Main shell (bottom nav) ───────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) =>
            MainScaffold(child: child, location: state.matchedLocation),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),

          GoRoute(
            path: AppRoutes.library,
            name: 'library',
            builder: (_, __) => const AttackLibraryScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'libraryDetail',
                builder: (_, state) => TechniqueDetailScreen(
                  techniqueId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          // ── Legacy /technique/:id → redirect to /library/:id ────────
          GoRoute(
            path: '/technique/:id',
            name: 'techniqueCompat',
            redirect: (_, state) => '/library/${state.pathParameters['id']}',
          ),

          GoRoute(
            path: AppRoutes.coverage,
            name: 'coverage',
            builder: (_, __) => const ThreatMappingScreen(),
          ),

          GoRoute(
            path: AppRoutes.alerts,
            name: 'alerts',
            builder: (_, __) => const AlertsScreen(),
            routes: [
              GoRoute(
                path: 'create',
                name: 'createAlert',
                builder: (_, __) => const CreateAlertScreen(),
              ),
            ],
          ),

          GoRoute(
            path: AppRoutes.simulations,
            name: 'simulations',
            builder: (_, __) => const SimulationsScreen(),
          ),

          GoRoute(
            path: AppRoutes.reports,
            name: 'reports',
            builder: (_, __) => const ReportsScreen(),
          ),

          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.broken_image_outlined, size: 48),
            const SizedBox(height: 12),
            Text('Page not found: ${state.uri}'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
}
