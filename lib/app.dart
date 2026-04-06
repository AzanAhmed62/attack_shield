import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/routing/routing.dart';
import 'core/theme/theme.dart';
import 'shared/providers/providers.dart';

class AttackShieldApp extends ConsumerWidget {
  const AttackShieldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeMode_Provider);

    return MaterialApp.router(
      title: 'ATT&CK Defender',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
