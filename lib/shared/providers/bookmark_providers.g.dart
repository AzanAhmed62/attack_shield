// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allBookmarksHash() => r'bf3a31588b8731e68b66716a9eb3c9b6117f9b3e';

/// See also [allBookmarks].
@ProviderFor(allBookmarks)
final allBookmarksProvider =
    AutoDisposeFutureProvider<List<BookmarkItem>>.internal(
      allBookmarks,
      name: r'allBookmarksProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allBookmarksHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllBookmarksRef = AutoDisposeFutureProviderRef<List<BookmarkItem>>;
String _$isTechniqueBookmarkedHash() =>
    r'e0f68e8a67996ae33f724c1c1030b4a1416d10bd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Returns true if a technique is bookmarked.
///
/// Copied from [isTechniqueBookmarked].
@ProviderFor(isTechniqueBookmarked)
const isTechniqueBookmarkedProvider = IsTechniqueBookmarkedFamily();

/// Returns true if a technique is bookmarked.
///
/// Copied from [isTechniqueBookmarked].
class IsTechniqueBookmarkedFamily extends Family<AsyncValue<bool>> {
  /// Returns true if a technique is bookmarked.
  ///
  /// Copied from [isTechniqueBookmarked].
  const IsTechniqueBookmarkedFamily();

  /// Returns true if a technique is bookmarked.
  ///
  /// Copied from [isTechniqueBookmarked].
  IsTechniqueBookmarkedProvider call(String techniqueId) {
    return IsTechniqueBookmarkedProvider(techniqueId);
  }

  @override
  IsTechniqueBookmarkedProvider getProviderOverride(
    covariant IsTechniqueBookmarkedProvider provider,
  ) {
    return call(provider.techniqueId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isTechniqueBookmarkedProvider';
}

/// Returns true if a technique is bookmarked.
///
/// Copied from [isTechniqueBookmarked].
class IsTechniqueBookmarkedProvider extends AutoDisposeFutureProvider<bool> {
  /// Returns true if a technique is bookmarked.
  ///
  /// Copied from [isTechniqueBookmarked].
  IsTechniqueBookmarkedProvider(String techniqueId)
    : this._internal(
        (ref) =>
            isTechniqueBookmarked(ref as IsTechniqueBookmarkedRef, techniqueId),
        from: isTechniqueBookmarkedProvider,
        name: r'isTechniqueBookmarkedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isTechniqueBookmarkedHash,
        dependencies: IsTechniqueBookmarkedFamily._dependencies,
        allTransitiveDependencies:
            IsTechniqueBookmarkedFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
      );

  IsTechniqueBookmarkedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.techniqueId,
  }) : super.internal();

  final String techniqueId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsTechniqueBookmarkedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsTechniqueBookmarkedProvider._internal(
        (ref) => create(ref as IsTechniqueBookmarkedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        techniqueId: techniqueId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsTechniqueBookmarkedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsTechniqueBookmarkedProvider &&
        other.techniqueId == techniqueId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, techniqueId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsTechniqueBookmarkedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `techniqueId` of this provider.
  String get techniqueId;
}

class _IsTechniqueBookmarkedProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with IsTechniqueBookmarkedRef {
  _IsTechniqueBookmarkedProviderElement(super.provider);

  @override
  String get techniqueId =>
      (origin as IsTechniqueBookmarkedProvider).techniqueId;
}

String _$addBookmarkHash() => r'85427438ff15b0876185bd2c09a35cd207d7f0ac';

/// See also [addBookmark].
@ProviderFor(addBookmark)
const addBookmarkProvider = AddBookmarkFamily();

/// See also [addBookmark].
class AddBookmarkFamily extends Family<AsyncValue<void>> {
  /// See also [addBookmark].
  const AddBookmarkFamily();

  /// See also [addBookmark].
  AddBookmarkProvider call(String techniqueId, String techniqueName) {
    return AddBookmarkProvider(techniqueId, techniqueName);
  }

  @override
  AddBookmarkProvider getProviderOverride(
    covariant AddBookmarkProvider provider,
  ) {
    return call(provider.techniqueId, provider.techniqueName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addBookmarkProvider';
}

/// See also [addBookmark].
class AddBookmarkProvider extends AutoDisposeFutureProvider<void> {
  /// See also [addBookmark].
  AddBookmarkProvider(String techniqueId, String techniqueName)
    : this._internal(
        (ref) => addBookmark(ref as AddBookmarkRef, techniqueId, techniqueName),
        from: addBookmarkProvider,
        name: r'addBookmarkProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$addBookmarkHash,
        dependencies: AddBookmarkFamily._dependencies,
        allTransitiveDependencies: AddBookmarkFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
        techniqueName: techniqueName,
      );

  AddBookmarkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.techniqueId,
    required this.techniqueName,
  }) : super.internal();

  final String techniqueId;
  final String techniqueName;

  @override
  Override overrideWith(
    FutureOr<void> Function(AddBookmarkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddBookmarkProvider._internal(
        (ref) => create(ref as AddBookmarkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        techniqueId: techniqueId,
        techniqueName: techniqueName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddBookmarkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddBookmarkProvider &&
        other.techniqueId == techniqueId &&
        other.techniqueName == techniqueName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, techniqueId.hashCode);
    hash = _SystemHash.combine(hash, techniqueName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddBookmarkRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `techniqueId` of this provider.
  String get techniqueId;

  /// The parameter `techniqueName` of this provider.
  String get techniqueName;
}

class _AddBookmarkProviderElement extends AutoDisposeFutureProviderElement<void>
    with AddBookmarkRef {
  _AddBookmarkProviderElement(super.provider);

  @override
  String get techniqueId => (origin as AddBookmarkProvider).techniqueId;
  @override
  String get techniqueName => (origin as AddBookmarkProvider).techniqueName;
}

String _$removeBookmarkHash() => r'c14b6f0594aa74246f852c0ae2d81e3d1ec9d85c';

/// See also [removeBookmark].
@ProviderFor(removeBookmark)
const removeBookmarkProvider = RemoveBookmarkFamily();

/// See also [removeBookmark].
class RemoveBookmarkFamily extends Family<AsyncValue<void>> {
  /// See also [removeBookmark].
  const RemoveBookmarkFamily();

  /// See also [removeBookmark].
  RemoveBookmarkProvider call(String techniqueId) {
    return RemoveBookmarkProvider(techniqueId);
  }

  @override
  RemoveBookmarkProvider getProviderOverride(
    covariant RemoveBookmarkProvider provider,
  ) {
    return call(provider.techniqueId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'removeBookmarkProvider';
}

/// See also [removeBookmark].
class RemoveBookmarkProvider extends AutoDisposeFutureProvider<void> {
  /// See also [removeBookmark].
  RemoveBookmarkProvider(String techniqueId)
    : this._internal(
        (ref) => removeBookmark(ref as RemoveBookmarkRef, techniqueId),
        from: removeBookmarkProvider,
        name: r'removeBookmarkProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$removeBookmarkHash,
        dependencies: RemoveBookmarkFamily._dependencies,
        allTransitiveDependencies:
            RemoveBookmarkFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
      );

  RemoveBookmarkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.techniqueId,
  }) : super.internal();

  final String techniqueId;

  @override
  Override overrideWith(
    FutureOr<void> Function(RemoveBookmarkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveBookmarkProvider._internal(
        (ref) => create(ref as RemoveBookmarkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        techniqueId: techniqueId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RemoveBookmarkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveBookmarkProvider && other.techniqueId == techniqueId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, techniqueId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemoveBookmarkRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `techniqueId` of this provider.
  String get techniqueId;
}

class _RemoveBookmarkProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with RemoveBookmarkRef {
  _RemoveBookmarkProviderElement(super.provider);

  @override
  String get techniqueId => (origin as RemoveBookmarkProvider).techniqueId;
}

String _$updateBookmarkNotesHash() =>
    r'10e37eb4b90f1e66fd65c45e8e62b3d63b2ab3b7';

/// See also [updateBookmarkNotes].
@ProviderFor(updateBookmarkNotes)
const updateBookmarkNotesProvider = UpdateBookmarkNotesFamily();

/// See also [updateBookmarkNotes].
class UpdateBookmarkNotesFamily extends Family<AsyncValue<void>> {
  /// See also [updateBookmarkNotes].
  const UpdateBookmarkNotesFamily();

  /// See also [updateBookmarkNotes].
  UpdateBookmarkNotesProvider call(String techniqueId, String notes) {
    return UpdateBookmarkNotesProvider(techniqueId, notes);
  }

  @override
  UpdateBookmarkNotesProvider getProviderOverride(
    covariant UpdateBookmarkNotesProvider provider,
  ) {
    return call(provider.techniqueId, provider.notes);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateBookmarkNotesProvider';
}

/// See also [updateBookmarkNotes].
class UpdateBookmarkNotesProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateBookmarkNotes].
  UpdateBookmarkNotesProvider(String techniqueId, String notes)
    : this._internal(
        (ref) => updateBookmarkNotes(
          ref as UpdateBookmarkNotesRef,
          techniqueId,
          notes,
        ),
        from: updateBookmarkNotesProvider,
        name: r'updateBookmarkNotesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateBookmarkNotesHash,
        dependencies: UpdateBookmarkNotesFamily._dependencies,
        allTransitiveDependencies:
            UpdateBookmarkNotesFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
        notes: notes,
      );

  UpdateBookmarkNotesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.techniqueId,
    required this.notes,
  }) : super.internal();

  final String techniqueId;
  final String notes;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateBookmarkNotesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateBookmarkNotesProvider._internal(
        (ref) => create(ref as UpdateBookmarkNotesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        techniqueId: techniqueId,
        notes: notes,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateBookmarkNotesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateBookmarkNotesProvider &&
        other.techniqueId == techniqueId &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, techniqueId.hashCode);
    hash = _SystemHash.combine(hash, notes.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateBookmarkNotesRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `techniqueId` of this provider.
  String get techniqueId;

  /// The parameter `notes` of this provider.
  String get notes;
}

class _UpdateBookmarkNotesProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with UpdateBookmarkNotesRef {
  _UpdateBookmarkNotesProviderElement(super.provider);

  @override
  String get techniqueId => (origin as UpdateBookmarkNotesProvider).techniqueId;
  @override
  String get notes => (origin as UpdateBookmarkNotesProvider).notes;
}

String _$clearAllBookmarksHash() => r'cb05212ffa9c4c90f63624f4f4dd4ed092c22dde';

/// See also [clearAllBookmarks].
@ProviderFor(clearAllBookmarks)
final clearAllBookmarksProvider = AutoDisposeFutureProvider<void>.internal(
  clearAllBookmarks,
  name: r'clearAllBookmarksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearAllBookmarksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClearAllBookmarksRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
