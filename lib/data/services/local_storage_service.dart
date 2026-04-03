import 'package:get_storage/get_storage.dart';
import '../../core/errors/errors.dart';

/// LocalStorageService provides a simple interface for storing and retrieving data locally
class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  late GetStorage _storage;

  LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  /// Initialize the storage service
  Future<void> initialize() async {
    try {
      await GetStorage.init();
      _storage = GetStorage();
    } catch (e) {
      throw CacheException(message: 'Failed to initialize local storage: $e');
    }
  }

  /// Write a value to storage
  Future<void> write<T>(String key, T value) async {
    try {
      await _storage.write(key, value);
    } catch (e) {
      throw CacheException(
        message: 'Failed to write to storage: $e',
        code: 'WRITE_ERROR',
      );
    }
  }

  /// Read a value from storage
  T? read<T>(String key) {
    try {
      return _storage.read<T>(key);
    } catch (e) {
      throw CacheException(
        message: 'Failed to read from storage: $e',
        code: 'READ_ERROR',
      );
    }
  }

  /// Check if a key exists
  bool hasKey(String key) {
    try {
      return _storage.hasData(key);
    } catch (e) {
      return false;
    }
  }

  /// Remove a key from storage
  Future<void> remove(String key) async {
    try {
      await _storage.remove(key);
    } catch (e) {
      throw CacheException(
        message: 'Failed to remove from storage: $e',
        code: 'REMOVE_ERROR',
      );
    }
  }

  /// Clear all storage
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear storage: $e',
        code: 'CLEAR_ERROR',
      );
    }
  }

  /// Get all keys in storage
  List<String> getAllKeys() {
    try {
      return _storage.getKeys().toList();
    } catch (e) {
      return [];
    }
  }
}
