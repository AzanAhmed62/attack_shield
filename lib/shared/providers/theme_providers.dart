import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:attackshield/core/constants/constants.dart';

part 'theme_providers.g.dart';

/// Manages ThemeMode with persistence.
/// Generated provider name: appThemeModeProvider
/// Usage: ref.watch(appThemeModeProvider) → ThemeMode
///        ref.read(appThemeModeProvider.notifier).toggle()
@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    // Restore persisted preference (default: dark)
    final stored = GetStorage().read<String>(AppConstants.storageKeyThemeMode);
    return stored == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    GetStorage().write(
      AppConstants.storageKeyThemeMode,
      state == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  void setDark() {
    state = ThemeMode.dark;
    GetStorage().write(AppConstants.storageKeyThemeMode, 'dark');
  }

  void setLight() {
    state = ThemeMode.light;
    GetStorage().write(AppConstants.storageKeyThemeMode, 'light');
  }
}