import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage for local persistence
  await GetStorage.init();

  // Initialize LocalStorageService
  final storageService = LocalStorageService();
  await storageService.initialize();

  runApp(const ProviderScope(child: AttackShieldApp()));
}
