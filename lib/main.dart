// lib/main.dart
// FIX: correct router import path (lib/core/routing/ not lib/core/router/)
// FIX: PlainLanguageService.ensureLoaded() called at startup so plain_language_mappings.json
//      is always available before the first screen opens.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routing/app_router.dart'; // FIX: was core/router/
import 'data/services/plain_language_service.dart';
import 'data/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Init GetStorage before any provider reads it
  await GetStorage.init();

  // 2. Initialize LocalStorageService (singleton wrapper around GetStorage)
  await LocalStorageService().initialize();

  // 3. Preload plain-language mappings from assets (fast, ~100ms)
  //    Runs before first frame so TechniqueDetail never shows empty plain mode
  await PlainLanguageService().ensureLoaded();

  // 3. Lock orientation to portrait on phones
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: AttackShieldApp()));
}

class AttackShieldApp extends ConsumerWidget {
  const AttackShieldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'ATT\u0026CK Shield',
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      // Light theme
      theme: _buildTheme(Brightness.light),

      // Dark theme
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF1565C0),
      brightness: brightness,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        height: 64,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }
}
