import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:uuid/uuid.dart';
import 'repository_providers.dart';

part 'bookmark_providers.g.dart';

// ── Data ──────────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: false)
Future<List<BookmarkItem>> allBookmarks(Ref ref) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  return repository.getAllBookmarks();
}

/// Returns true if a technique is bookmarked.
@Riverpod(keepAlive: false)
Future<bool> isTechniqueBookmarked(Ref ref, String techniqueId) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  return repository.isBookmarked(techniqueId);
}

// ── Mutations ─────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: false)
Future<void> addBookmark(Ref ref, String techniqueId, String techniqueName) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  final item = BookmarkItem(
    id: const Uuid().v4(),
    techniqueId: techniqueId,
    techniqueName: techniqueName,
    bookmarkedAt: DateTime.now(),
  );
  await repository.addBookmark(item);
  ref.invalidate(allBookmarksProvider);
  ref.invalidate(isTechniqueBookmarkedProvider(techniqueId));
}

@Riverpod(keepAlive: false)
Future<void> removeBookmark(Ref ref, String techniqueId) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  await repository.removeBookmark(techniqueId);
  ref.invalidate(allBookmarksProvider);
  ref.invalidate(isTechniqueBookmarkedProvider(techniqueId));
}

@Riverpod(keepAlive: false)
Future<void> updateBookmarkNotes(
    Ref ref, String techniqueId, String notes) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  await repository.updateBookmarkNotes(techniqueId, notes);
  ref.invalidate(allBookmarksProvider);
}

@Riverpod(keepAlive: false)
Future<void> clearAllBookmarks(Ref ref) async {
  final repository = ref.watch(bookmarkRepositoryProvider);
  await repository.clearAllBookmarks();
  ref.invalidate(allBookmarksProvider);
}