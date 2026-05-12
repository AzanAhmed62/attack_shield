// ════════════════════════════════════════════════════════════════
// lib/main.dart  — COMPLETE REPLACEMENT
// Initializes all services in correct order before runApp()
// ════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:attackshield/core/services/mitre_stix_data_service.dart';
import 'package:attackshield/app.dart'; // AttackShieldApp

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Storage (must come first — MITRE cache uses it)
  await GetStorage.init();

  // 2. MITRE STIX data (one-time 10 s parse, cached < 2 s after)
  await MitreStixDataService().initialize();

  // 3. Run
  runApp(const ProviderScope(child: AttackShieldApp()));
}


// ════════════════════════════════════════════════════════════════
// pubspec.yaml — REQUIRED CHANGES
// ════════════════════════════════════════════════════════════════
//
// dependencies:
//   flutter:
//     sdk: flutter
//   hooks_riverpod: ^2.5.1
//   riverpod_annotation: ^2.3.5
//   freezed_annotation: ^2.4.2
//   get_storage: ^2.1.1
//   go_router: ^13.2.5
//   uuid: ^4.3.3
//   fl_chart: ^0.67.0
//   pdf: ^3.10.8
//   printing: ^5.12.0
//
// dev_dependencies:
//   build_runner: ^2.4.9
//   freezed: ^2.5.2
//   riverpod_generator: ^2.4.0
//   json_serializable: ^6.7.1
//
// flutter:
//   assets:
//     - assets/data/enterprise-attack-14.5.json   ← NEW
//     - assets/data/plain_language_mappings.json


// ════════════════════════════════════════════════════════════════
// GoRouter — UPDATED ROUTES (add these to your existing router)
// ════════════════════════════════════════════════════════════════
//
// Paste these GoRoute entries into your existing GoRouter definition.
// They add the new Library detail route and the Simulation routes.

/*

final _router = GoRouter(
  initialLocation: '/dashboard',
  routes: [

    // ── existing routes (keep as-is) ──────────────────────
    GoRoute(path: '/dashboard',      builder: (_, __) => const DashboardScreen()),
    GoRoute(path: '/settings',       builder: (_, __) => const SettingsScreen()),
    GoRoute(path: '/alerts',         builder: (_, __) => const AlertsScreen()),
    GoRoute(path: '/reports',        builder: (_, __) => const ReportsScreen()),
    GoRoute(path: '/coverage',       builder: (_, __) => const CoverageScreen()),

    // ── updated library route ──────────────────────────────
    GoRoute(
      path: '/library',
      builder: (_, __) => const AttackLibraryScreen(),   // ← new full-STIX version
      routes: [
        GoRoute(
          path: ':attackId',
          builder: (_, state) => TechniqueDetailScreen(
            attackId: Uri.decodeComponent(
              state.pathParameters['attackId'] ?? '',
            ),
          ),
        ),
      ],
    ),

    // ── new simulation routes ──────────────────────────────
    GoRoute(
      path: '/simulations',
      builder: (_, __) => const SimulationHomeScreen(),
      routes: [
        GoRoute(
          path: ':scenarioId/walkthrough',
          builder: (_, state) => SimulationWalkthroughScreen(
            scenarioId: state.pathParameters['scenarioId'] ?? '',
          ),
        ),
        GoRoute(
          path: 'debrief',
          builder: (_, __) => const SimulationDebriefScreen(),
        ),
      ],
    ),

    // ── new organization setup ─────────────────────────────
    GoRoute(
      path: '/setup-organization',
      builder: (_, __) => const OrganizationSetupWizard(),
    ),
  ],
);

*/


// ════════════════════════════════════════════════════════════════
// INTEGRATION CHECKLIST
// Run through this top-to-bottom after copying all files
// ════════════════════════════════════════════════════════════════
//
// STEP 1 — Files to copy
//   lib/core/services/mitre_stix_data_service.dart          ✅ DONE
//   lib/shared/providers/mitre_data_providers.dart           ✅ DONE
//   lib/shared/providers/plain_language_providers.dart       ✅ DONE
//   lib/shared/models/plain_language_model.dart              ✅ DONE
//   lib/shared/models/simulation_models.dart                 ✅ DONE
//   lib/shared/widgets/plain_language_widgets.dart           ✅ DONE
//   lib/features/attack_library/presentation/screens/
//     attack_library_screen.dart                             ✅ DONE
//   lib/features/simulation/providers/
//     simulation_providers.dart                              ✅ DONE
//   lib/features/simulation/presentation/screens/
//     simulation_ui_screens.dart                             ✅ DONE
//   lib/features/organization/presentation/screens/
//     organization_setup_wizard.dart                         ✅ DONE
//   lib/core/services/
//     enhanced_threat_profile_generator.dart                 ✅ DONE
//   assets/data/enterprise-attack-14.5.json                  ← YOU DOWNLOAD
//   assets/data/plain_language_mappings.json                 ✅ DONE
//
// STEP 2 — Update main.dart
//   Replace with the file above (or merge the initialize calls)
//
// STEP 3 — Update GoRouter
//   Add routes shown in the comment block above
//
// STEP 4 — Update pubspec.yaml
//   Add assets section as shown in the comment block above
//
// STEP 5 — Run code generation
//   flutter pub get
//   flutter pub run build_runner build --delete-conflicting-outputs
//
// STEP 6 — Verify
//   flutter run
//   Open Attack Library → Should show 1000+ techniques
//   Tap any technique  → Full STIX detail (APTs, malware, mitigations)
//   Open Simulations   → 5 scenarios ready
//   Open Settings      → Organization setup wizard
