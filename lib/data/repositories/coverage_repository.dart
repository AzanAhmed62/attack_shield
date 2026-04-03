import 'dart:convert';
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
          .map((item) => CoverageStatus.fromJson(jsonDecode(jsonEncode(item))))
          .toList();
    } catch (e) {
      throw DataException(message: 'Failed to fetch coverage statuses: $e');
    }
  }

  @override
  Future<CoverageStatus?> getCoverageStatus(String techniqueId) async {
    try {
      final statuses = await getAllCoverageStatuses();
      return statuses.firstWhere(
        (s) => s.techniqueId == techniqueId,
        orElse: () => CoverageStatus(
          techniqueId: techniqueId,
          level: CoverageLevel.unknown,
        ),
      );
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

      if (index >= 0) {
        statuses[index] = status;
      } else {
        statuses.add(status);
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

      final covered = statuses
          .where(
            (s) =>
                s.level == CoverageLevel.covered ||
                s.level == CoverageLevel.partiallyCovered,
          )
          .length;

      return (covered / statuses.length) * 100;
    } catch (e) {
      throw DataException(message: 'Failed to calculate coverage: $e');
    }
  }

  @override
  Future<Map<String, int>> getCoverageBreakdown() async {
    try {
      final statuses = await getAllCoverageStatuses();
      return {
        'covered': statuses
            .where((s) => s.level == CoverageLevel.covered)
            .length,
        'partiallyCovered': statuses
            .where((s) => s.level == CoverageLevel.partiallyCovered)
            .length,
        'notCovered': statuses
            .where((s) => s.level == CoverageLevel.notCovered)
            .length,
        'unknown': statuses
            .where((s) => s.level == CoverageLevel.unknown)
            .length,
      };
    } catch (e) {
      throw DataException(message: 'Failed to get coverage breakdown: $e');
    }
  }
}
