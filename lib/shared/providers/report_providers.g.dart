// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allReportsHash() => r'a6534ece0fda814f03472fc6bde89b9a0266623a';

/// All saved reports, sorted newest first.
///
/// Copied from [allReports].
@ProviderFor(allReports)
final allReportsProvider =
    AutoDisposeFutureProvider<List<ReportSummary>>.internal(
      allReports,
      name: r'allReportsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allReportsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllReportsRef = AutoDisposeFutureProviderRef<List<ReportSummary>>;
String _$latestReportHash() => r'eead5aeb4503db96e9ce7a107cf3d4dfd378c4be';

/// The most recently generated report, or null if none exist.
///
/// Copied from [latestReport].
@ProviderFor(latestReport)
final latestReportProvider = AutoDisposeFutureProvider<ReportSummary?>.internal(
  latestReport,
  name: r'latestReportProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestReportHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestReportRef = AutoDisposeFutureProviderRef<ReportSummary?>;
String _$generateReportHash() => r'd2bb8b1ff55da3a8ee08ff346a36f452a9e5c856';

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

/// Generate (save) a new report and refresh the report list.
///
/// Copied from [generateReport].
@ProviderFor(generateReport)
const generateReportProvider = GenerateReportFamily();

/// Generate (save) a new report and refresh the report list.
///
/// Copied from [generateReport].
class GenerateReportFamily extends Family<AsyncValue<void>> {
  /// Generate (save) a new report and refresh the report list.
  ///
  /// Copied from [generateReport].
  const GenerateReportFamily();

  /// Generate (save) a new report and refresh the report list.
  ///
  /// Copied from [generateReport].
  GenerateReportProvider call(ReportSummary report) {
    return GenerateReportProvider(report);
  }

  @override
  GenerateReportProvider getProviderOverride(
    covariant GenerateReportProvider provider,
  ) {
    return call(provider.report);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'generateReportProvider';
}

/// Generate (save) a new report and refresh the report list.
///
/// Copied from [generateReport].
class GenerateReportProvider extends AutoDisposeFutureProvider<void> {
  /// Generate (save) a new report and refresh the report list.
  ///
  /// Copied from [generateReport].
  GenerateReportProvider(ReportSummary report)
    : this._internal(
        (ref) => generateReport(ref as GenerateReportRef, report),
        from: generateReportProvider,
        name: r'generateReportProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$generateReportHash,
        dependencies: GenerateReportFamily._dependencies,
        allTransitiveDependencies:
            GenerateReportFamily._allTransitiveDependencies,
        report: report,
      );

  GenerateReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.report,
  }) : super.internal();

  final ReportSummary report;

  @override
  Override overrideWith(
    FutureOr<void> Function(GenerateReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GenerateReportProvider._internal(
        (ref) => create(ref as GenerateReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        report: report,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _GenerateReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GenerateReportProvider && other.report == report;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, report.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GenerateReportRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `report` of this provider.
  ReportSummary get report;
}

class _GenerateReportProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with GenerateReportRef {
  _GenerateReportProviderElement(super.provider);

  @override
  ReportSummary get report => (origin as GenerateReportProvider).report;
}

String _$deleteReportHash() => r'ee39eb629fb229bf097c875bc2bed53b10123e50';

/// Delete a specific report by ID.
///
/// Copied from [deleteReport].
@ProviderFor(deleteReport)
const deleteReportProvider = DeleteReportFamily();

/// Delete a specific report by ID.
///
/// Copied from [deleteReport].
class DeleteReportFamily extends Family<AsyncValue<void>> {
  /// Delete a specific report by ID.
  ///
  /// Copied from [deleteReport].
  const DeleteReportFamily();

  /// Delete a specific report by ID.
  ///
  /// Copied from [deleteReport].
  DeleteReportProvider call(String id) {
    return DeleteReportProvider(id);
  }

  @override
  DeleteReportProvider getProviderOverride(
    covariant DeleteReportProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteReportProvider';
}

/// Delete a specific report by ID.
///
/// Copied from [deleteReport].
class DeleteReportProvider extends AutoDisposeFutureProvider<void> {
  /// Delete a specific report by ID.
  ///
  /// Copied from [deleteReport].
  DeleteReportProvider(String id)
    : this._internal(
        (ref) => deleteReport(ref as DeleteReportRef, id),
        from: deleteReportProvider,
        name: r'deleteReportProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$deleteReportHash,
        dependencies: DeleteReportFamily._dependencies,
        allTransitiveDependencies:
            DeleteReportFamily._allTransitiveDependencies,
        id: id,
      );

  DeleteReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteReportProvider._internal(
        (ref) => create(ref as DeleteReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteReportProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteReportRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DeleteReportProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with DeleteReportRef {
  _DeleteReportProviderElement(super.provider);

  @override
  String get id => (origin as DeleteReportProvider).id;
}

String _$clearAllReportsHash() => r'238de81d10706cf429492c697ee2f914b94b079a';

/// Clear all reports.
///
/// Copied from [clearAllReports].
@ProviderFor(clearAllReports)
final clearAllReportsProvider = AutoDisposeFutureProvider<void>.internal(
  clearAllReports,
  name: r'clearAllReportsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearAllReportsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClearAllReportsRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
