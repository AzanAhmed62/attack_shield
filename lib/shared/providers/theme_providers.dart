import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';

part 'theme_providers.g.dart';

@Riverpod()
ThemeMode themeMode(ThemeModeRef ref) {
  return ThemeMode.dark; // Default to dark mode
}
