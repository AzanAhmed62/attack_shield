import 'package:flutter/material.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/shared/models/models.dart';

/// Returns the display color for a given ATT&CK risk score (0–10).
Color riskScoreColor(double score) {
  if (score >= 8.5) return AppTheme.dangerColor;
  if (score >= 7.0) return AppTheme.accentColor;
  if (score >= 5.0) return AppTheme.warningColor;
  return AppTheme.successColor;
}

/// Returns the display label for a risk score.
String riskScoreLabel(double score) {
  if (score >= 8.5) return 'Critical';
  if (score >= 7.0) return 'High';
  if (score >= 5.0) return 'Medium';
  if (score >= 3.0) return 'Low';
  return 'Minimal';
}

/// Returns the color for a coverage level.
Color coverageLevelColor(CoverageLevel level) {
  switch (level) {
    case CoverageLevel.covered:
      return AppTheme.successColor;
    case CoverageLevel.partiallyCovered:
      return AppTheme.warningColor;
    case CoverageLevel.unknown:
      return Colors.grey;
    case CoverageLevel.notCovered:
      return AppTheme.dangerColor;
  }
}

/// Returns the display label for a coverage level.
String coverageLevelLabel(CoverageLevel level) {
  switch (level) {
    case CoverageLevel.covered:
      return 'Covered';
    case CoverageLevel.partiallyCovered:
      return 'Partial';
    case CoverageLevel.unknown:
      return 'Unknown';
    case CoverageLevel.notCovered:
      return 'Not Covered';
  }
}

/// Returns the color for an alert priority.
Color alertPriorityColor(AlertPriority priority) {
  switch (priority) {
    case AlertPriority.critical:
      return AppTheme.dangerColor;
    case AlertPriority.high:
      return AppTheme.accentColor;
    case AlertPriority.medium:
      return AppTheme.warningColor;
    case AlertPriority.low:
      return AppTheme.successColor;
  }
}

/// Returns the display label for an alert status.
String alertStatusLabel(AlertStatus status) {
  switch (status) {
    case AlertStatus.open:
      return 'Open';
    case AlertStatus.acknowledged:
      return 'Acknowledged';
    case AlertStatus.resolved:
      return 'Resolved';
  }
}

/// Returns the display label for a simulation test result.
String testResultLabel(TestResult result) {
  switch (result) {
    case TestResult.passed:
      return 'Passed';
    case TestResult.failed:
      return 'Failed';
    case TestResult.partiallyPassed:
      return 'Partially Passed';
    case TestResult.notTested:
      return 'Not Tested';
  }
}

/// Returns the color for a simulation test result.
Color testResultColor(TestResult result) {
  switch (result) {
    case TestResult.passed:
      return AppTheme.successColor;
    case TestResult.failed:
      return AppTheme.dangerColor;
    case TestResult.partiallyPassed:
      return AppTheme.warningColor;
    case TestResult.notTested:
      return Colors.grey;
  }
}

/// Returns the color for an asset criticality level.
Color assetCriticalityColor(AssetCriticality criticality) {
  switch (criticality) {
    case AssetCriticality.critical:
      return AppTheme.dangerColor;
    case AssetCriticality.high:
      return AppTheme.accentColor;
    case AssetCriticality.medium:
      return AppTheme.warningColor;
    case AssetCriticality.low:
      return AppTheme.successColor;
  }
}