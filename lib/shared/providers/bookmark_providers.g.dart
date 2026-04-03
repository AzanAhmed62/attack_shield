// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allBookmarksHash() => r'4de73274b2f18af1b9637ccee925362b8fae12ff';

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
    r'3457da5baa0512208610d3b4057890a9cb3a39b3';

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

/// See also [isTechniqueBookmarked].
@ProviderFor(isTechniqueBookmarked)
const isTechniqueBookmarkedProvider = IsTechniqueBookmarkedFamily();

/// See also [isTechniqueBookmarked].
class IsTechniqueBookmarkedFamily extends Family<AsyncValue<bool>> {
  /// See also [isTechniqueBookmarked].
  const IsTechniqueBookmarkedFamily();

  /// See also [isTechniqueBookmarked].
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

/// See also [isTechniqueBookmarked].
class IsTechniqueBookmarkedProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [isTechniqueBookmarked].
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

String _$addBookmarkHash() => r'8bbc2a6448d363ac4a2d30c3598f826a4524252c';

/// See also [addBookmark].
@ProviderFor(addBookmark)
const addBookmarkProvider = AddBookmarkFamily();

/// See also [addBookmark].
class AddBookmarkFamily extends Family<AsyncValue<void>> {
  /// See also [addBookmark].
  const AddBookmarkFamily();

  /// See also [addBookmark].
  AddBookmarkProvider call(
    String techniqueId,
    String techniqueName, {
    String? notes,
  }) {
    return AddBookmarkProvider(techniqueId, techniqueName, notes: notes);
  }

  @override
  AddBookmarkProvider getProviderOverride(
    covariant AddBookmarkProvider provider,
  ) {
    return call(
      provider.techniqueId,
      provider.techniqueName,
      notes: provider.notes,
    );
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
  AddBookmarkProvider(String techniqueId, String techniqueName, {String? notes})
    : this._internal(
        (ref) => addBookmark(
          ref as AddBookmarkRef,
          techniqueId,
          techniqueName,
          notes: notes,
        ),
        from: addBookmarkProvider,
        name: r'addBookmarkProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$addBookmarkHash,
        dependencies: AddBookmarkFamily._dependencies,
        allTransitiveDependencies: AddBookmarkFamily._allTransitiveDependencies,
        techniqueId: techniqueId,
        techniqueName: techniqueName,
        notes: notes,
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
    required this.notes,
  }) : super.internal();

  final String techniqueId;
  final String techniqueName;
  final String? notes;

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
        notes: notes,
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
        other.techniqueName == techniqueName &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, techniqueId.hashCode);
    hash = _SystemHash.combine(hash, techniqueName.hashCode);
    hash = _SystemHash.combine(hash, notes.hashCode);

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

  /// The parameter `notes` of this provider.
  String? get notes;
}

class _AddBookmarkProviderElement extends AutoDisposeFutureProviderElement<void>
    with AddBookmarkRef {
  _AddBookmarkProviderElement(super.provider);

  @override
  String get techniqueId => (origin as AddBookmarkProvider).techniqueId;
  @override
  String get techniqueName => (origin as AddBookmarkProvider).techniqueName;
  @override
  String? get notes => (origin as AddBookmarkProvider).notes;
}

String _$removeBookmarkHash() => r'028f2aab4c60c506ffc9fddc1b36c143f0d08289';

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
    r'47364239797f4b405aa6dfc616e8a7fffd792c82';

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

String _$clearAllBookmarksHash() => r'1c60245816a73605ef521a811b9d7cfcf257c6ff';

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
