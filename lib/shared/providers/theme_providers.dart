import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_providers.g.dart';

/// Persists and exposes the current ThemeMode.
/// Call ref.read(themeModeProvider.notifier).toggle() to switch.
@Riverpod(keepAlive: true)
class ThemeMode_ extends _$ThemeMode_ {
  @override
  ThemeMode build() => ThemeMode.dark; // default: dark

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  void setDark() => state = ThemeMode.dark;
  void setLight() => state = ThemeMode.light;
}