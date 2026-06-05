// lib/data/services/gemini_service.dart
// Complete Gemini 1.5 Flash integration — single source of truth for all AI
// calls in the app. Drop-in replacement for any old Claude/AI service files.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// ─── Constants ────────────────────────────────────────────────────────────────
const _kApiKeyStorageKey = 'gemini_api_key';
const _kModelId = 'gemini-2.0-flash';
const _kBaseUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/$_kModelId:generateContent';
const _kMaxRetries = 3;
const _kBaseDelay = Duration(seconds: 2);
const _kRequestTimeout = Duration(seconds: 30);

// ─── Result type ──────────────────────────────────────────────────────────────
class GeminiResult {
  final String? text;
  final String? error;
  final bool isSuccess;

  const GeminiResult.success(this.text) : error = null, isSuccess = true;
  const GeminiResult.failure(this.error) : text = null, isSuccess = false;
}

// ─── Service ──────────────────────────────────────────────────────────────────
class GeminiService {
  // Singleton
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;
  GeminiService._internal();

  final _storage = GetStorage();

  // ── API key management ──────────────────────────────────────────────────────
  String? get apiKey => _storage.read<String>(_kApiKeyStorageKey);

  Future<void> setApiKey(String key) async {
    await _storage.write(_kApiKeyStorageKey, key.trim());
  }

  bool get hasApiKey => apiKey != null && apiKey!.isNotEmpty;

  // ── Core generate method ────────────────────────────────────────────────────
  Future<GeminiResult> generate({
    required String prompt,
    String? systemInstruction,
    double temperature = 0.7,
    int maxTokens = 1024,
  }) async {
    if (!hasApiKey) {
      return const GeminiResult.failure(
        'Gemini API key not configured. Go to Settings → AI Settings to add your key.',
      );
    }

    final key = apiKey!;
    int attempt = 0;

    while (attempt < _kMaxRetries) {
      attempt++;
      try {
        final result = await _sendRequest(
          apiKey: key,
          prompt: prompt,
          systemInstruction: systemInstruction,
          temperature: temperature,
          maxTokens: maxTokens,
        );
        return result;
      } catch (e) {
        if (attempt == _kMaxRetries) {
          debugPrint('[Gemini] All $attempt attempts failed: $e');
          return GeminiResult.failure(
            'AI service unavailable after $attempt attempts. Check your connection.',
          );
        }
        // Exponential backoff
        final delay = _kBaseDelay * attempt;
        debugPrint(
          '[Gemini] Attempt $attempt failed, retrying in ${delay.inSeconds}s...',
        );
        await Future.delayed(delay);
      }
    }

    return const GeminiResult.failure('Unexpected error in Gemini service.');
  }

  Future<GeminiResult> _sendRequest({
    required String apiKey,
    required String prompt,
    String? systemInstruction,
    double temperature = 0.7,
    int maxTokens = 1024,
  }) async {
    final uri = Uri.parse('$_kBaseUrl?key=$apiKey');

    final body = <String, dynamic>{
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': prompt},
          ],
        },
      ],
      'generationConfig': {
        'temperature': temperature,
        'maxOutputTokens': maxTokens,
        'candidateCount': 1,
      },
    };

    if (systemInstruction != null) {
      body['systemInstruction'] = {
        'parts': [
          {'text': systemInstruction},
        ],
      };
    }

    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(_kRequestTimeout);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final candidates = json['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) {
        return const GeminiResult.failure(
          'No response candidates from Gemini.',
        );
      }
      final content = candidates.first['content'] as Map<String, dynamic>?;
      final parts = content?['parts'] as List?;
      final text = parts?.first['text'] as String?;
      if (text == null || text.isEmpty) {
        return const GeminiResult.failure('Empty response from Gemini.');
      }
      return GeminiResult.success(text.trim());
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      return const GeminiResult.failure(
        'Invalid Gemini API key. Please update it in Settings → AI Settings.',
      );
    } else if (response.statusCode == 429) {
      throw Exception('Rate limited — will retry');
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.body}');
    }
  }

  // ── Domain-specific prompts ──────────────────────────────────────────────────

  /// Plain-English explanation of a MITRE technique for non-technical users.
  Future<GeminiResult> explainTechniqueSimply({
    required String techniqueId,
    required String techniqueName,
    required String stixDescription,
  }) => generate(
    systemInstruction:
        'You are a cybersecurity advisor explaining threats to a non-technical business '
        'audience. Use plain language. No jargon. Be concise.',
    prompt:
        '''
Explain the MITRE ATT&CK technique "$techniqueName" ($techniqueId) in plain English.

Technical description: $stixDescription

Respond in this exact JSON format (no markdown):
{
  "simpleExplanation": "One paragraph, max 80 words, what this attack is",
  "realWorldExample": "One concrete real-world sentence (e.g. 'Like when hackers...')",
  "businessImpact": "One sentence about what damage this could cause to an organisation",
  "urgencyLevel": "Critical|High|Medium|Low",
  "topThreeActions": ["action 1", "action 2", "action 3"]
}
''',
    temperature: 0.3,
    maxTokens: 512,
  );

  /// AI-generated executive summary for a PDF security report.
  Future<GeminiResult> generateReportNarrative({
    required String orgName,
    required double coveragePercent,
    required int totalTechniques,
    required int coveredCount,
    required int criticalGaps,
    required List<String> topUncoveredTechniques,
  }) => generate(
    systemInstruction:
        'You are a senior cybersecurity consultant writing an executive summary. '
        'Be professional, concise, and action-oriented.',
    prompt:
        '''
Write a 3-paragraph executive summary for a MITRE ATT&CK coverage report.

Organization: $orgName
Overall coverage: ${coveragePercent.toStringAsFixed(1)}%
Total techniques assessed: $totalTechniques
Covered: $coveredCount
Critical gaps: $criticalGaps
Top uncovered high-risk techniques: ${topUncoveredTechniques.take(5).join(', ')}

Paragraph 1: Current security posture overview.
Paragraph 2: Key risks from the gaps identified.
Paragraph 3: Top 3 recommended priorities.

Plain prose only, no bullet points, no headers.
''',
    temperature: 0.5,
    maxTokens: 512,
  );

  /// Dashboard security posture summary (generated once per session).
  Future<GeminiResult> generatePostureSummary({
    required double riskScore,
    required double coveragePercent,
    required int openAlerts,
    required int criticalAlerts,
    required List<String> tacticGaps,
  }) => generate(
    systemInstruction:
        'You are a security dashboard AI. Be brief, direct, and actionable. '
        'Max 60 words total.',
    prompt:
        '''
Security posture snapshot:
- Risk score: ${riskScore.toStringAsFixed(0)}/100
- Coverage: ${coveragePercent.toStringAsFixed(0)}%
- Open alerts: $openAlerts ($criticalAlerts critical)
- Tactic gaps: ${tacticGaps.take(3).join(', ')}

Write one 2-sentence summary of the security posture and one recommended action.
''',
    temperature: 0.4,
    maxTokens: 128,
  );

  /// Simulation narrative — what could an attacker do with these gaps.
  Future<GeminiResult> generateSimulationNarrative({
    required String scenarioName,
    required List<String> uncoveredTechniques,
    required double readinessScore,
  }) => generate(
    systemInstruction:
        'You are a red team analyst explaining what an attacker could do. '
        'Be realistic but not alarmist. Max 120 words.',
    prompt:
        '''
Simulation: "$scenarioName"
Readiness score: ${readinessScore.toStringAsFixed(0)}%
Uncovered techniques: ${uncoveredTechniques.take(6).join(', ')}

Write a short attack narrative: how an attacker could chain these gaps into a 
successful intrusion. Then give 2 specific defensive recommendations.
''',
    temperature: 0.6,
    maxTokens: 256,
  );
}
