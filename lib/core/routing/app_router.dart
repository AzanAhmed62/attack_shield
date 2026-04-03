import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/attack_library/presentation/screens/attack_library_screen.dart';
import '../../features/technique_detail/presentation/screens/technique_detail_screen.dart';
import '../../features/threat_mapping/presentation/screens/threat_mapping_screen.dart';
import '../../features/simulations/presentation/screens/simulations_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/alerts/presentation/screens/alerts_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/library',
      name: 'library',
      builder: (context, state) => const AttackLibraryScreen(),
    ),
    GoRoute(
      path: '/technique/:id',
      name: 'technique-detail',
      builder: (context, state) {
        final techniqueId = state.pathParameters['id']!;
        return TechniqueDetailScreen(techniqueId: techniqueId);
      },
    ),
    GoRoute(
      path: '/coverage',
      name: 'coverage',
      builder: (context, state) => const ThreatMappingScreen(),
    ),
    GoRoute(
      path: '/simulations',
      name: 'simulations',
      builder: (context, state) => const SimulationsScreen(),
    ),
    GoRoute(
      path: '/reports',
      name: 'reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/alerts',
      name: 'alerts',
      builder: (context, state) => const AlertsScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);
