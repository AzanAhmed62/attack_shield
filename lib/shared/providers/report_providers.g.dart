// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allReportsHash() => r'e6251f08abc4cf0ece709339584cedce1f59f2d7';

/// See also [allReports].
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
String _$latestReportHash() => r'f230416cf4e5519303f931002f95cf311e26a379';

/// See also [latestReport].
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
String _$reportCountHash() => r'bfd8f2a0666e7f161cd546ec8595647b3e214fd9';

/// See also [reportCount].
@ProviderFor(reportCount)
final reportCountProvider = AutoDisposeFutureProvider<int>.internal(
  reportCount,
  name: r'reportCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReportCountRef = AutoDisposeFutureProviderRef<int>;
String _$averageCoverageHash() => r'bef10b1efb0374d70662e94802aa12e967a6d0d6';

/// See also [averageCoverage].
@ProviderFor(averageCoverage)
final averageCoverageProvider = AutoDisposeFutureProvider<double>.internal(
  averageCoverage,
  name: r'averageCoverageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$averageCoverageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AverageCoverageRef = AutoDisposeFutureProviderRef<double>;
String _$generateReportHash() => r'a7d3f8727d2734a39816653abd5493b6afb6ca04';

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

/// See also [generateReport].
@ProviderFor(generateReport)
const generateReportProvider = GenerateReportFamily();

/// See also [generateReport].
class GenerateReportFamily extends Family<AsyncValue<void>> {
  /// See also [generateReport].
  const GenerateReportFamily();

  /// See also [generateReport].
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

/// See also [generateReport].
class GenerateReportProvider extends AutoDisposeFutureProvider<void> {
  /// See also [generateReport].
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

String _$deleteReportHash() => r'039e509eb7fae7edc6f78981d450faf7a487c328';

/// See also [deleteReport].
@ProviderFor(deleteReport)
const deleteReportProvider = DeleteReportFamily();

/// See also [deleteReport].
class DeleteReportFamily extends Family<AsyncValue<void>> {
  /// See also [deleteReport].
  const DeleteReportFamily();

  /// See also [deleteReport].
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

/// See also [deleteReport].
class DeleteReportProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteReport].
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
