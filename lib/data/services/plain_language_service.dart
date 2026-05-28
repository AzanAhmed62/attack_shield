// lib/data/services/plain_language_service.dart
// NEW FILE — parses assets/data/plain_language_mappings.json and serves
// plain-English content for any technique ID. Used as offline fallback
// when Gemini AI is unavailable.

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

const _kAssetPath = 'assets/data/plain_language_mappings.json';

class PlainTechniqueData {
  final String  techniqueId;
  final String  plainTitle;
  final String  simpleSummary;
  final String  businessRisk;
  final String  urgencyLevel;        // Critical | High | Medium | Low
  final List<String> remediationSteps;
  final List<String> realWorldExamples;

  const PlainTechniqueData({
    required this.techniqueId,
    required this.plainTitle,
    required this.simpleSummary,
    required this.businessRisk,
    required this.urgencyLevel,
    required this.remediationSteps,
    required this.realWorldExamples,
  });

  factory PlainTechniqueData.fromJson(String id, Map<String, dynamic> json) {
    return PlainTechniqueData(
      techniqueId:     id,
      plainTitle:      json['plain_title']       as String? ?? '',
      simpleSummary:   json['simple_summary']    as String? ?? '',
      businessRisk:    json['business_risk']      as String? ?? '',
      urgencyLevel:    json['urgency_level']      as String? ?? 'Medium',
      remediationSteps: (json['remediation_steps'] as List?)?.cast<String>() ?? [],
      realWorldExamples: (json['real_world_examples'] as List?)?.cast<String>() ?? [],
    );
  }
}

class PlainLanguageService {
  // Singleton
  static final PlainLanguageService _instance = PlainLanguageService._internal();
  factory PlainLanguageService() => _instance;
  PlainLanguageService._internal();

  Map<String, PlainTechniqueData>? _cache;

  // ── Load and cache ────────────────────────────────────────────────────────
  Future<void> ensureLoaded() async {
    if (_cache != null) return;
    try {
      final jsonString = await rootBundle.loadString(_kAssetPath);
      final raw        = jsonDecode(jsonString) as Map<String, dynamic>;
      _cache = raw.map((id, data) => MapEntry(
        id,
        PlainTechniqueData.fromJson(id, data as Map<String, dynamic>),
      ));
      debugPrint('[PlainLanguage] Loaded ${_cache!.length} technique mappings.');
    } catch (e) {
      debugPrint('[PlainLanguage] Failed to load mappings: $e');
      _cache = {};
    }
  }

  // ── Public accessors ──────────────────────────────────────────────────────
  PlainTechniqueData? get(String techniqueId) => _cache?[techniqueId];

  String getSimpleSummary(String techniqueId) =>
      _cache?[techniqueId]?.simpleSummary ?? '';

  String getPlainTitle(String techniqueId) =>
      _cache?[techniqueId]?.plainTitle ?? '';

  String getBusinessRisk(String techniqueId) =>
      _cache?[techniqueId]?.businessRisk ?? '';

  String getUrgencyLevel(String techniqueId) =>
      _cache?[techniqueId]?.urgencyLevel ?? 'Medium';

  List<String> getRemediationSteps(String techniqueId) =>
      _cache?[techniqueId]?.remediationSteps ?? [];

  List<String> getRealWorldExamples(String techniqueId) =>
      _cache?[techniqueId]?.realWorldExamples ?? [];

  bool has(String techniqueId) => _cache?.containsKey(techniqueId) ?? false;

  // ── Convert to Gemini-style AI explanation map ────────────────────────────
  // Allows TechniqueDetailScreen to use plain_language data with zero code change
  // when Gemini is unavailable (same map shape as Gemini JSON response).
  Map<String, dynamic>? asAiExplanationMap(String techniqueId) {
    final data = _cache?[techniqueId];
    if (data == null) return null;
    return {
      'simpleExplanation': data.simpleSummary,
      'realWorldExample':  data.realWorldExamples.isNotEmpty
          ? data.realWorldExamples.first : null,
      'businessImpact':    data.businessRisk,
      'urgencyLevel':      data.urgencyLevel,
      'topThreeActions':   data.remediationSteps.take(3).toList(),
    };
  }
}
