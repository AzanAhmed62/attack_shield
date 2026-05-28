// lib/shared/providers/app_mode_provider.dart
// NEW FILE — AppMode toggle (Expert / Plain English) used by dashboard
// and technique_detail_screen. Persisted across sessions.

import 'package:get_storage/get_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_mode_provider.g.dart';

enum AppMode {
  expertMode,         // Full technical MITRE data
  plainLanguageMode,  // Plain English, non-technical
}

const _kAppModeKey = 'app_mode_v1';

@Riverpod(keepAlive: true)
class AppModeNotifier extends _$AppModeNotifier {
  final _storage = GetStorage();

  @override
  AppMode build() {
    final stored = _storage.read<String>(_kAppModeKey);
    return stored == 'plain' ? AppMode.plainLanguageMode : AppMode.expertMode;
  }

  void toggleAppMode() {
    final next = state == AppMode.expertMode
        ? AppMode.plainLanguageMode
        : AppMode.expertMode;
    state = next;
    _storage.write(_kAppModeKey, next == AppMode.plainLanguageMode ? 'plain' : 'expert');
  }

  void setMode(AppMode mode) {
    state = mode;
    _storage.write(_kAppModeKey, mode == AppMode.plainLanguageMode ? 'plain' : 'expert');
  }
}

// Convenience alias — screens watch this directly
// Usage: final mode = ref.watch(appModeProvider);
// Notifier: ref.read(appModeProvider.notifier).toggleAppMode();
