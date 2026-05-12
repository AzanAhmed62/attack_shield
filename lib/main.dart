import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'data/services/services.dart';
import 'data/repositories/repositories.dart';
import 'core/services/seed_data_service.dart';
import 'core/services/mitre_stix_data_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialise storage needed by all repositories and providers.
  await GetStorage.init();

  // 2. Initialise the storage wrapper before any repository access.
  final storageService = LocalStorageService();
  await storageService.initialize();

  // 3. Seed lightweight sample data synchronously so first render is consistent.
  final seedService = SeedDataService(
    storage: storageService,
    alertRepo: AlertRepositoryImpl(storageService),
    simRepo: SimulationRepositoryImpl(storageService),
    assetRepo: AssetRepositoryImpl(storageService),
  );
  await seedService.seedIfNeeded();

  runApp(const ProviderScope(child: AttackShieldApp()));

  // 4. Warm the large MITRE dataset after first frame instead of blocking launch.
  unawaited(_warmMitreData());
}

Future<void> _warmMitreData() async {
  try {
    if (kDebugMode) {
      debugPrint('Warming MITRE ATT&CK data in background...');
    }
    await MitreStixDataService().initialize();
    if (kDebugMode) {
      debugPrint('MITRE ATT&CK data ready.');
    }
  } catch (e, st) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: e,
        stack: st,
        library: 'attackshield bootstrap',
        informationCollector: () sync* {
          yield ErrorDescription('Background MITRE ATT&CK warm-up failed.');
        },
      ),
    );
  }
}
