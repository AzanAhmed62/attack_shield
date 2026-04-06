import 'package:attackshield/shared/models/models.dart';
import '../../core/constants/constants.dart';
import '../../core/errors/errors.dart';
import '../services/services.dart';

abstract class CoverageRepository {
  Future<List<CoverageStatus>> getAllCoverageStatuses();
  Future<CoverageStatus?> getCoverageStatus(String techniqueId);
  Future<void> updateCoverageStatus(CoverageStatus status);
  Future<void> deleteCoverageStatus(String techniqueId);
  Future<double> calculateCoveragePercentage();
  Future<Map<String, int>> getCoverageBreakdown();
}

class CoverageRepositoryImpl implements CoverageRepository {
  final LocalStorageService _storageService;

  CoverageRepositoryImpl(this._storageService);

  @override
  Future<List<CoverageStatus>> getAllCoverageStatuses() async {
    try {
      final data = _storageService.read<List>(AppConstants.storageKeyCoverage);
      if (data == null) return [];

      return data
          .map(
            (item) =>
                CoverageStatus.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch coverage statuses: $e');
    }
  }

  @override
  Future<CoverageStatus?> getCoverageStatus(String techniqueId) async {
    try {
      final statuses = await getAllCoverageStatuses();
      final found = statuses.where((s) => s.techniqueId == techniqueId);
      if (found.isEmpty) return null;
      return found.first;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateCoverageStatus(CoverageStatus status) async {
    try {
      var statuses = await getAllCoverageStatuses();
      final index = statuses.indexWhere(
        (s) => s.techniqueId == status.techniqueId,
      );

      final updated = status.copyWith(lastUpdated: DateTime.now());

      if (index >= 0) {
        statuses[index] = updated;
      } else {
        statuses.add(updated);
      }

      await _storageService.write(
        AppConstants.storageKeyCoverage,
        statuses.map((s) => s.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to update coverage status: $e');
    }
  }

  @override
  Future<void> deleteCoverageStatus(String techniqueId) async {
    try {
      var statuses = await getAllCoverageStatuses();
      statuses.removeWhere((s) => s.techniqueId == techniqueId);

      await _storageService.write(
        AppConstants.storageKeyCoverage,
        statuses.map((s) => s.toJson()).toList(),
      );
    } catch (e) {
      throw DataException(message: 'Failed to delete coverage status: $e');
    }
  }

  @override
  Future<double> calculateCoveragePercentage() async {
    try {
      final statuses = await getAllCoverageStatuses();
      if (statuses.isEmpty) return 0.0;

      // Weighted: covered=2pts, partial=1pt, max=2pts per technique
      int score = 0;
      for (final s in statuses) {
        if (s.level == CoverageLevel.covered) score += 2;
        if (s.level == CoverageLevel.partiallyCovered) score += 1;
      }
      return (score / (statuses.length * 2)) * 100.0;
    } catch (e) {
      throw DataException(message: 'Failed to calculate coverage: $e');
    }
  }

  @override
  Future<Map<String, int>> getCoverageBreakdown() async {
    try {
      final statuses = await getAllCoverageStatuses();
      return {
        'covered':
            statuses.where((s) => s.level == CoverageLevel.covered).length,
        'partiallyCovered': statuses
            .where((s) => s.level == CoverageLevel.partiallyCovered)
            .length,
        'notCovered':
            statuses.where((s) => s.level == CoverageLevel.notCovered).length,
        'unknown':
            statuses.where((s) => s.level == CoverageLevel.unknown).length,
      };
    } catch (e) {
      throw DataException(message: 'Failed to get coverage breakdown: $e');
    }
  }
}