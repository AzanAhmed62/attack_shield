import 'package:attackshield/features/assets/presentation/assets_screen.dart';
import 'package:attackshield/features/bookmarks/features/bookmarks_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:attackshield/core/constants/constants.dart';
import 'package:attackshield/core/routing/shell_nav.dart';

// ── Screen imports ────────────────────────────────────────────────────────────
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/attack_library/presentation/screens/attack_library_screen.dart';
import '../../features/technique_detail/presentation/screens/technique_detail_screen.dart'
    as technique_detail_screen;
import '../../features/technique_detail/presentation/screens/sub_technique_detail_screen.dart';
import '../../features/threat_mapping/presentation/screens/threat_mapping_screen.dart';
import '../../features/threat_intel/presentation/screens/threat_intel_mapper_screen.dart';
import '../../features/simulations/presentation/screens/simulations_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/alerts/presentation/screens/alerts_screen.dart';
import '../../features/detection/presentation/screens/detection_screens.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/organization/presentation/screens/organization_setup_wizard.dart';

bool _onboardingComplete() {
  final storage = GetStorage();
  return storage.read<bool>(AppConstants.storageKeyOnboardingComplete) ?? false;
}

final appRouter = GoRouter(
  initialLocation: _onboardingComplete() ? '/' : '/onboarding',
  debugLogDiagnostics: false,

  // Custom page transition — slide up from bottom
  routerNeglect: false,

  routes: [
    // ── Onboarding (outside shell) ───────────────────────────────────────
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionsBuilder: _fadeTransition,
      ),
    ),

    // ── Shell with persistent bottom nav ────────────────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ShellScaffold(navigationShell: navigationShell),
      branches: [
        // Branch 0 — Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'dashboard',
              pageBuilder: (context, state) =>
                  _slide(state, const DashboardScreen()),
            ),
          ],
        ),

        // Branch 1 — Library
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/library',
              name: 'library',
              pageBuilder: (context, state) {
                return _slide(state, const AttackLibraryScreen());
              },
              routes: [
                GoRoute(
                  path: 'technique/:id',
                  name: 'technique-detail',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    if (id.contains('.')) {
                      final parentId = id.split('.').first;
                      return _slide(
                        state,
                        SubTechniqueDetailScreen(
                          parentTechniqueId: parentId,
                          subTechniqueId: id,
                        ),
                      );
                    }
                    return _slide(
                      state,
                      technique_detail_screen.TechniqueDetailScreen(
                        techniqueId: id,
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'sub/:subId',
                      name: 'sub-technique-detail',
                      pageBuilder: (context, state) {
                        final id = state.pathParameters['id']!;
                        final subId = state.pathParameters['subId']!;
                        return _slide(
                          state,
                          SubTechniqueDetailScreen(
                            parentTechniqueId: id,
                            subTechniqueId: subId,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Branch 2 — Coverage
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/coverage',
              name: 'coverage',
              pageBuilder: (context, state) =>
                  _slide(state, const ThreatMappingScreen()),
            ),
          ],
        ),

        // Branch 3 — Alerts
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/alerts',
              name: 'alerts',
              pageBuilder: (context, state) =>
                  _slide(state, const AlertsScreen()),
            ),
          ],
        ),

        // Branch 4 — More (hub screen)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/more',
              name: 'more',
              pageBuilder: (context, state) =>
                  _slide(state, const MoreScreen()),
              routes: [
                GoRoute(
                  path: 'simulations',
                  pageBuilder: (context, state) =>
                      _slide(state, const SimulationsScreen()),
                ),
                GoRoute(
                  path: 'reports',
                  pageBuilder: (context, state) =>
                      _slide(state, const ReportsScreen()),
                ),
                GoRoute(
                  path: 'settings',
                  pageBuilder: (context, state) =>
                      _slide(state, const SettingsScreen()),
                ),
                GoRoute(
                  path: 'bookmarks',
                  pageBuilder: (context, state) =>
                      _slide(state, const BookmarksScreen()),
                ),
                GoRoute(
                  path: 'assets',
                  pageBuilder: (context, state) =>
                      _slide(state, const AssetsScreen()),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // ── Standalone routes (pushed on top of shell) ───────────────────────
    GoRoute(
      path: '/setup-organization',
      name: 'setup-organization',
      pageBuilder: (context, state) =>
          _slide(state, const OrganizationSetupWizard()),
    ),
    GoRoute(
      path: '/threat-intel',
      name: 'threat-intel',
      pageBuilder: (context, state) =>
          _slide(state, const ThreatIntelMapperScreen()),
    ),
    GoRoute(
      path: '/detection',
      name: 'detection',
      pageBuilder: (context, state) =>
          _slide(state, const DetectionHomeScreen()),
    ),
    GoRoute(
      path: '/simulations',
      name: 'simulations',
      pageBuilder: (context, state) => _slide(state, const SimulationsScreen()),
    ),
    GoRoute(
      path: '/reports',
      name: 'reports',
      pageBuilder: (context, state) => _slide(state, const ReportsScreen()),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) => _slide(state, const SettingsScreen()),
    ),
    GoRoute(
      path: '/bookmarks',
      name: 'bookmarks',
      pageBuilder: (context, state) => _slide(state, const BookmarksScreen()),
    ),
    GoRoute(
      path: '/assets',
      name: 'assets',
      pageBuilder: (context, state) => _slide(state, const AssetsScreen()),
    ),
    // Technique detail accessible from anywhere (not just inside library branch)
    GoRoute(
      path: '/technique/:id',
      name: 'technique-detail-global',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        if (id.contains('.')) {
          final parentId = id.split('.').first;
          return _slide(
            state,
            SubTechniqueDetailScreen(
              parentTechniqueId: parentId,
              subTechniqueId: id,
            ),
          );
        }
        return _slide(
          state,
          technique_detail_screen.TechniqueDetailScreen(techniqueId: id),
        );
      },
    ),
    GoRoute(
      path: '/technique/:id/sub/:subId',
      name: 'sub-technique-detail-global',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        final subId = state.pathParameters['subId']!;
        return _slide(
          state,
          SubTechniqueDetailScreen(
            parentTechniqueId: id,
            subTechniqueId: subId,
          ),
        );
      },
    ),
  ],
);

// ── Transition helpers ────────────────────────────────────────────────────────

CustomTransitionPage<void> _slide(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}
