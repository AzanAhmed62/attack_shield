import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_item.freezed.dart';
part 'bookmark_item.g.dart';

@freezed
class BookmarkItem with _$BookmarkItem {
  const factory BookmarkItem({
    required String id,
    required String techniqueId,
    required String techniqueName,
    String? notes,
    DateTime? bookmarkedAt,
  }) = _BookmarkItem;

  factory BookmarkItem.fromJson(Map<String, dynamic> json) =>
      _$BookmarkItemFromJson(json);
}
