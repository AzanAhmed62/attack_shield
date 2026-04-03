import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'repository_providers.dart';

part 'bookmark_providers.g.dart';

// All Bookmarks
@Riverpod()
Future<List<BookmarkItem>> allBookmarks(AllBookmarksRef ref) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  return repository.getAllBookmarks();
}

// Check if Technique is Bookmarked
@Riverpod()
Future<bool> isTechniqueBookmarked(
  IsTechniqueBookmarkedRef ref,
  String techniqueId,
) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  return repository.isBookmarked(techniqueId);
}

// Add Bookmark
@Riverpod()
Future<void> addBookmark(
  AddBookmarkRef ref,
  String techniqueId,
  String techniqueName, {
  String? notes,
}) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  await repository.addBookmark(techniqueId, techniqueName, notes: notes);
  // Invalidate related providers
  ref.invalidate(allBookmarksProvider);
  ref.invalidate(isTechniqueBookmarkedProvider);
}

// Remove Bookmark
@Riverpod()
Future<void> removeBookmark(RemoveBookmarkRef ref, String techniqueId) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  await repository.removeBookmark(techniqueId);
  // Invalidate related providers
  ref.invalidate(allBookmarksProvider);
  ref.invalidate(isTechniqueBookmarkedProvider);
}

// Update Bookmark Notes
@Riverpod()
Future<void> updateBookmarkNotes(
  UpdateBookmarkNotesRef ref,
  String techniqueId,
  String notes,
) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  await repository.updateBookmarkNotes(techniqueId, notes);
  // Invalidate related providers
  ref.invalidate(allBookmarksProvider);
}

// Clear All Bookmarks
@Riverpod()
Future<void> clearAllBookmarks(ClearAllBookmarksRef ref) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  await repository.clearAllBookmarks();
  // Invalidate related providers
  ref.invalidate(allBookmarksProvider);
  ref.invalidate(isTechniqueBookmarkedProvider);
}
