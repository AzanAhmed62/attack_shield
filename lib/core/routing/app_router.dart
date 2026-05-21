// lib/core/router/app_router.dart
// FULL REPLACEMENT — all routes verified, onboarding guard, no broken paths.

import 'package:attackshield/features/attack_library/presentation/screens/attack_library_screen.dart';
import 'package:attackshield/features/organization/presentation/screens/organization_setup_wizard.dart';
import 'package:attackshield/features/technique_detail/presentation/screens/technique_detail_screen.dart';
import 'package:attackshield/features/threat_mapping/presentation/screens/threat_mapping_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/alerts/presentation/screens/alerts_screen.dart';
import '../../features/alerts/presentation/screens/create_alert_screen.dart';
import '../../features/simulations/presentation/screens/simulations_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../shared/widgets/main_scaffold.dart';

part 'app_router.g.dart';

// ─── Route constants ──────────────────────────────────────────────────────────
class AppRoutes {
  static const onboarding       = '/onboarding';
  static const orgSetup         = '/setup-organization';
  static const dashboard        = '/dashboard';
  static const library          = '/library';
  static const libraryDetail    = '/library/:id';
  static const coverage         = '/coverage';
  static const alerts           = '/alerts';
  static const createAlert      = '/alerts/create';
  static const simulations      = '/simulations';
  static const reports          = '/reports';
  static const settings         = '/settings';
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    debugLogDiagnostics: false,

    // ── Onboarding redirect guard ─────────────────────────────────────────
    redirect: (context, state) {
      final storage  = GetStorage();
      final hasOnboarded = storage.read<bool>('hasCompletedOnboarding') ?? false;
      final orgName      = storage.read<String>('org_name');
      final isOnboarding = state.matchedLocation == AppRoutes.onboarding ||
                           state.matchedLocation == AppRoutes.orgSetup;

      // First launch — redirect to onboarding
      if (!hasOnboarded && !isOnboarding) return AppRoutes.onboarding;
      // Org profile missing — redirect to setup
      if (hasOnboarded && (orgName == null || orgName.isEmpty) && !isOnboarding) {
        return AppRoutes.orgSetup;
      }
      return null;
    },

    routes: [
      // ── Onboarding (outside shell) ──────────────────────────────────────
      GoRoute(
        path:    AppRoutes.onboarding,
        name:    'onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path:    AppRoutes.orgSetup,
        name:    'orgSetup',
        builder: (_, __) => const OrganizationSetupWizard(),
      ),

      // ── Main shell (bottom nav) ─────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) =>
          MainScaffold(location: state.matchedLocation, child: child),
        routes: [

          GoRoute(
            path:    AppRoutes.dashboard,
            name:    'dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),

          GoRoute(
            path:    AppRoutes.library,
            name:    'library',
            builder: (_, __) => const AttackLibraryScreen(),
            routes: [
              GoRoute(
                path:    ':id',
                name:    'techniqueDetail',
                builder: (_, state) => TechniqueDetailScreen(
                  techniqueId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          GoRoute(
            path:    AppRoutes.coverage,
            name:    'coverage',
            builder: (_, __) => const ThreatMappingScreen(),
          ),

          GoRoute(
            path:    AppRoutes.alerts,
            name:    'alerts',
            builder: (_, __) => const AlertsScreen(),
            routes: [
              GoRoute(
                path:    'create',
                name:    'createAlert',
                builder: (_, __) => const CreateAlertScreen(),
              ),
            ],
          ),

          GoRoute(
            path:    AppRoutes.simulations,
            name:    'simulations',
            builder: (_, __) => const SimulationsScreen(),
          ),

          GoRoute(
            path:    AppRoutes.reports,
            name:    'reports',
            builder: (_, __) => const ReportsScreen(),
          ),

          GoRoute(
            path:    AppRoutes.settings,
            name:    'settings',
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],

    errorBuilder: (_, state) => Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.broken_image_outlined, size: 48),
          const SizedBox(height: 12),
          Text('Page not found: ${state.error?.message ?? state.uri}'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => state.namedLocation('dashboard'),
            child: const Text('Go to Dashboard'),
          ),
        ]),
      ),
    ),
  );
}