// lib/shared/providers/app_mode_provider.dart
// NEW FILE — global AppMode (Expert / Plain English) toggle.
// Persisted across sessions via GetStorage.
// Used in: dashboard_screen, technique_detail_screen, threat_mapping_screen.

import 'package:get_storage/get_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_mode_provider.g.dart';

enum AppMode { expertMode, plainLanguageMode }

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
    _save(next);
  }

  void setMode(AppMode mode) => _save(mode);

  void _save(AppMode mode) {
    state = mode;
    _storage.write(
      _kAppModeKey,
      mode == AppMode.plainLanguageMode ? 'plain' : 'expert',
    );
  }
}

// Convenience shorthand — watch this in screens:
// final mode = ref.watch(appModeProvider);
// ref.read(appModeProvider.notifier).toggleAppMode();

/// Direct access to appModeProvider notifier
final appModeProvider = appModeNotifierProvider;
