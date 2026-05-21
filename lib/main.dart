// lib/main.dart
// FULL REPLACEMENT — proper initialization order: GetStorage → ProviderScope
// → MaterialApp.router with GoRouter. Onboarding guard is in app_router.dart.

import 'package:attackshield/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init GetStorage before any provider reads it
  await GetStorage.init();

  // Lock to portrait on mobile
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(child: AttackShieldApp()),
  );
}

class AttackShieldApp extends ConsumerWidget {
  const AttackShieldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title:             'ATT&CK Shield',
      debugShowCheckedModeBanner: false,
      routerConfig:      router,

      // ── Light theme ──────────────────────────────────────────────────
      theme: ThemeData(
        useMaterial3:    true,
        colorSchemeSeed: const Color(0xFF1565C0), // deep blue
        brightness:      Brightness.light,
        fontFamily:      'Inter',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0.5,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation:    0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          elevation:    0,
          height:       64,
          labelBehavior:
              NavigationDestinationLabelBehavior.alwaysShow,
        ),
      ),

      // ── Dark theme ───────────────────────────────────────────────────
      darkTheme: ThemeData(
        useMaterial3:    true,
        colorSchemeSeed: const Color(0xFF1565C0),
        brightness:      Brightness.dark,
        fontFamily:      'Inter',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0.5,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          elevation: 0,
          height:    64,
          labelBehavior:
              NavigationDestinationLabelBehavior.alwaysShow,
        ),
      ),

      themeMode: ThemeMode.system,
    );
  }
}