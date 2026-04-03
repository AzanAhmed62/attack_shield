import 'dart:convert';
import 'package:attackshield/shared/models/models.dart';
import '../../core/constants/constants.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class BookmarkRepository {
  Future<List<BookmarkItem>> getAllBookmarks();
  Future<bool> isBookmarked(String techniqueId);
  Future<void> addBookmark(
    String techniqueId,
    String techniqueName, {
    String? notes,
  });
  Future<void> removeBookmark(String techniqueId);
  Future<void> updateBookmarkNotes(String techniqueId, String notes);
  Future<void> clearAllBookmarks();
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  final LocalStorageService _storageService;

  BookmarkRepositoryImpl(this._storageService);

  @override
  Future<List<BookmarkItem>> getAllBookmarks() async {
    try {
      final data = _storageService.read<List>(AppConstants.storageKeyBookmarks);
      if (data == null) return [];

      return data
          .map((item) => BookmarkItem.fromJson(jsonDecode(jsonEncode(item))))
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch bookmarks: $e');
    }
  }

  @override
  Future<bool> isBookmarked(String techniqueId) async {
    try {
      final bookmarks = await getAllBookmarks();
      return bookmarks.any((b) => b.techniqueId == techniqueId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> addBookmark(
    String techniqueId,
    String techniqueName, {
    String? notes,
  }) async {
    try {
      final bookmarks = await getAllBookmarks();

      if (bookmarks.any((b) => b.techniqueId == techniqueId)) {
        return; // Already bookmarked
      }

      final newBookmark = BookmarkItem(
        id: UniqueKey().toString(),
        techniqueId: techniqueId,
        techniqueName: techniqueName,
        notes: notes,
        bookmarkedAt: DateTime.now(),
      );

      bookmarks.add(newBookmark);
      await _storageService.write(
        AppConstants.storageKeyBookmarks,
        bookmarks.map((b) => b.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to add bookmark: $e');
    }
  }

  @override
  Future<void> removeBookmark(String techniqueId) async {
    try {
      var bookmarks = await getAllBookmarks();
      bookmarks.removeWhere((b) => b.techniqueId == techniqueId);

      await _storageService.write(
        AppConstants.storageKeyBookmarks,
        bookmarks.map((b) => b.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to remove bookmark: $e');
    }
  }

  @override
  Future<void> updateBookmarkNotes(String techniqueId, String notes) async {
    try {
      var bookmarks = await getAllBookmarks();
      final index = bookmarks.indexWhere((b) => b.techniqueId == techniqueId);

      if (index >= 0) {
        bookmarks[index] = bookmarks[index].copyWith(notes: notes);
        await _storageService.write(
          AppConstants.storageKeyBookmarks,
          bookmarks.map((b) => b.toJson()).toList(),
        );
      }
    } catch (e) {
      throw DataException(message: 'Failed to update bookmark notes: $e');
    }
  }

  @override
  Future<void> clearAllBookmarks() async {
    try {
      await _storageService.remove(AppConstants.storageKeyBookmarks);
    } catch (e) {
      throw DataException(message: 'Failed to clear bookmarks: $e');
    }
  }
}

// Helper to generate unique key
class UniqueKey {
  static int _counter = 0;

  @override
  String toString() {
    return 'UniqueKey_${++_counter}';
  }
}
