import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/services/services.dart';
import 'data/repositories/repositories.dart';
import 'core/services/seed_data_service.dart';
import 'core/services/mitre_stix_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialise GetStorage
  await GetStorage.init();

  // 2. Load MITRE STIX data (one-time: ~10s, cached: <2s after)
  print('🔄 Loading MITRE STIX data...');
  await MitreStixDataService().initialize();
  print('✅ MITRE data loaded');

  // 3. Initialise LocalStorageService singleton
  final storageService = LocalStorageService();
  await storageService.initialize();

  // 4. Seed sample data on first launch after onboarding
  final seedService = SeedDataService(
    storage: storageService,
    alertRepo: AlertRepositoryImpl(storageService),
    simRepo: SimulationRepositoryImpl(storageService),
    assetRepo: AssetRepositoryImpl(storageService),
  );
  await seedService.seedIfNeeded();

  runApp(const ProviderScope(child: AttackShieldApp()));
}
