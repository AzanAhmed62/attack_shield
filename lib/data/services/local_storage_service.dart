import 'package:get_storage/get_storage.dart';

/// Singleton wrapper around GetStorage.
/// All repositories use this service — never call GetStorage directly.
class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  late final GetStorage _storage;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _storage = GetStorage();
    _initialized = true;
  }

  /// Read a value by key. Returns null if missing.
  T? read<T>(String key) {
    _assertInitialized();
    try {
      return _storage.read<T>(key);
    } catch (_) {
      return null;
    }
  }

  /// Write a value by key.
  Future<void> write(String key, dynamic value) async {
    _assertInitialized();
    await _storage.write(key, value);
  }

  /// Remove a key.
  Future<void> remove(String key) async {
    _assertInitialized();
    await _storage.remove(key);
  }

  /// Check if a key exists.
  bool hasKey(String key) {
    _assertInitialized();
    return _storage.hasData(key);
  }

  /// Clear all stored data.
  Future<void> clearAll() async {
    _assertInitialized();
    await _storage.erase();
  }

  void _assertInitialized() {
    if (_initialized) {
      return;
    }

    throw StateError(
      'LocalStorageService must be initialized before use. Call initialize() in main().',
    );
  }
}
