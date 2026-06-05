// lib/data/services/osint_service.dart
// NEW FILE — Unified OSINT Intelligence Service
// Integrates: AlienVault OTX · NVD/CVE · AbuseIPDB · VirusTotal
// All free APIs, keys stored in GetStorage alongside Gemini key.
// Each method caches results in memory for the session (no redundant calls).

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// ─── Storage keys for API keys ────────────────────────────────────────────────
const _kOtxKey         = 'osint_otx_api_key';
const _kAbuseIpKey     = 'osint_abuseipdb_api_key';
const _kVirusTotalKey  = 'osint_virustotal_api_key';

const _kTimeout = Duration(seconds: 15);

// ─── Result types ─────────────────────────────────────────────────────────────

class OtxPulse {
  final String name;
  final String description;
  final List<String> attackIds;      // MITRE ATT&CK T-IDs
  final List<String> indicatorTypes;
  final int    indicatorCount;
  final String created;
  final String author;

  const OtxPulse({
    required this.name,
    required this.description,
    required this.attackIds,
    required this.indicatorTypes,
    required this.indicatorCount,
    required this.created,
    required this.author,
  });
}

class CveEntry {
  final String id;                // CVE-2024-XXXXX
  final String description;
  final double cvssScore;
  final String severity;
  final String published;
  final List<String> cwes;

  const CveEntry({
    required this.id,
    required this.description,
    required this.cvssScore,
    required this.severity,
    required this.published,
    required this.cwes,
  });
}

class IpReputation {
  final String ip;
  final int    abuseScore;         // 0–100
  final String countryCode;
  final String isp;
  final bool   isPublic;
  final int    totalReports;
  final String lastReported;

  const IpReputation({
    required this.ip,
    required this.abuseScore,
    required this.countryCode,
    required this.isp,
    required this.isPublic,
    required this.totalReports,
    required this.lastReported,
  });
}

class VtResult {
  final String resource;
  final int    malicious;
  final int    suspicious;
  final int    harmless;
  final int    total;
  final String permalink;

  const VtResult({
    required this.resource,
    required this.malicious,
    required this.suspicious,
    required this.harmless,
    required this.total,
    required this.permalink,
  });
}

class OsintResult<T> {
  final T?      data;
  final String? error;
  final bool    isSuccess;
  const OsintResult.success(this.data) : error = null,    isSuccess = true;
  const OsintResult.failure(this.error) : data = null,    isSuccess = false;
  const OsintResult.empty() : data = null, error = null,  isSuccess = true;
}

// ─── Service ──────────────────────────────────────────────────────────────────

class OsintService {
  static final OsintService _instance = OsintService._internal();
  factory OsintService() => _instance;
  OsintService._internal();

  final _storage = GetStorage();

  // Session-level cache (cleared on each app launch)
  final _otxCache   = <String, List<OtxPulse>>{};
  final _cveCache   = <String, List<CveEntry>>{};
  final _ipCache    = <String, IpReputation>{};
  final _vtCache    = <String, VtResult>{};

  // ── API key management ──────────────────────────────────────────────────────
  String? get otxKey        => _storage.read<String>(_kOtxKey);
  String? get abuseIpKey    => _storage.read<String>(_kAbuseIpKey);
  String? get virusTotalKey => _storage.read<String>(_kVirusTotalKey);

  Future<void> setOtxKey(String key)         async => _storage.write(_kOtxKey,        key.trim());
  Future<void> setAbuseIpKey(String key)     async => _storage.write(_kAbuseIpKey,    key.trim());
  Future<void> setVirusTotalKey(String key)  async => _storage.write(_kVirusTotalKey, key.trim());

  bool get hasOtxKey        => otxKey?.isNotEmpty        ?? false;
  bool get hasAbuseIpKey    => abuseIpKey?.isNotEmpty    ?? false;
  bool get hasVirusTotalKey => virusTotalKey?.isNotEmpty ?? false;

  // ── 1. AlienVault OTX — technique enrichment ───────────────────────────────
  // Fetches threat intelligence pulses related to a MITRE ATT&CK technique.
  // OTX natively indexes pulses by ATT&CK technique ID.
  Future<OsintResult<List<OtxPulse>>> getOtxPulsesForTechnique(
    String techniqueId,    // e.g. "T1566"
  ) async {
    if (!hasOtxKey) {
      return const OsintResult.failure(
        'AlienVault OTX key not configured. Add it in Settings → OSINT Settings.');
    }
    if (_otxCache.containsKey(techniqueId)) {
      return OsintResult.success(_otxCache[techniqueId]);
    }
    try {
      final uri = Uri.parse(
        'https://otx.alienvault.com/api/v1/indicators/mitre/$techniqueId/pulses?limit=5',
      );
      final resp = await http.get(uri, headers: {
        'X-OTX-API-KEY': otxKey!,
        'Accept':        'application/json',
      }).timeout(_kTimeout);

      if (resp.statusCode == 200) {
        final json    = jsonDecode(resp.body) as Map<String, dynamic>;
        final results = (json['results'] as List?)?.cast<Map<String, dynamic>>() ?? [];
        final pulses  = results.map((p) {
          final attackRefs = (p['attack_ids'] as List?)?.cast<String>() ?? [];
          return OtxPulse(
            name:           p['name']              as String? ?? '',
            description:    p['description']       as String? ?? '',
            attackIds:      attackRefs,
            indicatorTypes: (p['indicator_type_counts'] as Map?)?.keys.toList().cast<String>() ?? [],
            indicatorCount: p['indicator_count']   as int?    ?? 0,
            created:        (p['created'] as String? ?? '').substring(0, 10),
            author:         p['author_name']       as String? ?? 'Unknown',
          );
        }).toList();
        _otxCache[techniqueId] = pulses;
        return OsintResult.success(pulses);
      } else if (resp.statusCode == 401 || resp.statusCode == 403) {
        return const OsintResult.failure('Invalid OTX API key.');
      } else {
        return OsintResult.failure('OTX error: HTTP ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('[OSINT OTX] $techniqueId error: $e');
      return OsintResult.failure('OTX unavailable: $e');
    }
  }

  // ── 2. NVD / CVE — technique-related CVEs ──────────────────────────────────
  // NVD API v2 is completely free (no key needed, just respect rate limits).
  // We search CVEs by keyword (technique name) and return top 5.
  Future<OsintResult<List<CveEntry>>> getCvesForTechnique(
    String techniqueName,   // e.g. "Phishing"
    String techniqueId,     // for cache key
  ) async {
    if (_cveCache.containsKey(techniqueId)) {
      return OsintResult.success(_cveCache[techniqueId]);
    }
    try {
      final query = Uri.encodeComponent(techniqueName);
      final uri   = Uri.parse(
        'https://services.nvd.nist.gov/rest/json/cves/2.0?keywordSearch=$query&resultsPerPage=5',
      );
      final resp = await http.get(uri, headers: {
        'Accept': 'application/json',
      }).timeout(_kTimeout);

      if (resp.statusCode == 200) {
        final json         = jsonDecode(resp.body) as Map<String, dynamic>;
        final vulnerabilities = (json['vulnerabilities'] as List?)?.cast<Map<String, dynamic>>() ?? [];
        final cves         = vulnerabilities.map((v) {
          final cve       = v['cve'] as Map<String, dynamic>? ?? {};
          final id        = cve['id']  as String? ?? '';
          final descs     = (cve['descriptions'] as List?)?.cast<Map<String, dynamic>>() ?? [];
          final desc      = descs.firstWhere(
            (d) => d['lang'] == 'en', orElse: () => {'value': ''},
          )['value'] as String? ?? '';
          final metrics   = cve['metrics'] as Map<String, dynamic>? ?? {};
          final cvssData  = _extractCvss(metrics);
          final weaknesses = (cve['weaknesses'] as List?)?.cast<Map<String, dynamic>>() ?? [];
          final cwes      = weaknesses.expand((w) =>
            (w['description'] as List?)?.cast<Map>()
              .where((d) => d['lang'] == 'en')
              .map((d) => d['value'] as String? ?? '') ?? []
          ).toList();
          return CveEntry(
            id:          id,
            description: desc,
            cvssScore:   cvssData['score'] as double? ?? 0,
            severity:    cvssData['severity'] as String? ?? 'Unknown',
            published:   (cve['published'] as String? ?? '').substring(0, 10),
            cwes:        cwes,
          );
        }).toList();
        _cveCache[techniqueId] = cves;
        return OsintResult.success(cves);
      } else {
        return OsintResult.failure('NVD error: HTTP ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('[OSINT CVE] $techniqueId error: $e');
      return OsintResult.failure('NVD unavailable: $e');
    }
  }

  // ── 3. AbuseIPDB — IP reputation ───────────────────────────────────────────
  Future<OsintResult<IpReputation>> lookupIp(String ip) async {
    if (!hasAbuseIpKey) {
      return const OsintResult.failure(
        'AbuseIPDB key not configured. Add it in Settings → OSINT Settings.');
    }
    if (_ipCache.containsKey(ip)) return OsintResult.success(_ipCache[ip]!);
    try {
      final uri  = Uri.parse(
        'https://api.abuseipdb.com/api/v2/check?ipAddress=$ip&maxAgeInDays=90',
      );
      final resp = await http.get(uri, headers: {
        'Key':    abuseIpKey!,
        'Accept': 'application/json',
      }).timeout(_kTimeout);

      if (resp.statusCode == 200) {
        final data = (jsonDecode(resp.body) as Map)['data'] as Map<String, dynamic>;
        final rep  = IpReputation(
          ip:           data['ipAddress']          as String? ?? ip,
          abuseScore:   data['abuseConfidenceScore'] as int?  ?? 0,
          countryCode:  data['countryCode']        as String? ?? 'Unknown',
          isp:          data['isp']                as String? ?? 'Unknown',
          isPublic:     data['isPublic']           as bool?   ?? true,
          totalReports: data['totalReports']       as int?    ?? 0,
          lastReported: data['lastReportedAt']     as String? ?? '',
        );
        _ipCache[ip] = rep;
        return OsintResult.success(rep);
      } else if (resp.statusCode == 401 || resp.statusCode == 403) {
        return const OsintResult.failure('Invalid AbuseIPDB key.');
      } else {
        return OsintResult.failure('AbuseIPDB error: HTTP ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('[OSINT AbuseIPDB] $ip error: $e');
      return OsintResult.failure('AbuseIPDB unavailable: $e');
    }
  }

  // ── 4. VirusTotal — IOC lookup ─────────────────────────────────────────────
  Future<OsintResult<VtResult>> lookupUrl(String url) async {
    if (!hasVirusTotalKey) {
      return const OsintResult.failure(
        'VirusTotal key not configured. Add it in Settings → OSINT Settings.');
    }
    final cacheKey = url;
    if (_vtCache.containsKey(cacheKey)) return OsintResult.success(_vtCache[cacheKey]!);
    try {
      // URL lookup via VT API v3
      final encoded = base64Url.encode(utf8.encode(url)).replaceAll('=', '');
      final uri     = Uri.parse('https://www.virustotal.com/api/v3/urls/$encoded');
      final resp    = await http.get(uri, headers: {
        'x-apikey': virusTotalKey!,
        'Accept':   'application/json',
      }).timeout(_kTimeout);

      if (resp.statusCode == 200) {
        final attrs = ((jsonDecode(resp.body) as Map)['data'] as Map)
            ['attributes'] as Map<String, dynamic>;
        final stats = attrs['last_analysis_stats'] as Map<String, dynamic>? ?? {};
        final result = VtResult(
          resource:  url,
          malicious:  stats['malicious']  as int? ?? 0,
          suspicious: stats['suspicious'] as int? ?? 0,
          harmless:   stats['harmless']   as int? ?? 0,
          total:      (stats.values.whereType<int>().fold<int>(0, (a, b) => a + b)),
          permalink: 'https://www.virustotal.com/gui/url/$encoded',
        );
        _vtCache[cacheKey] = result;
        return OsintResult.success(result);
      } else if (resp.statusCode == 401 || resp.statusCode == 403) {
        return const OsintResult.failure('Invalid VirusTotal key.');
      } else if (resp.statusCode == 404) {
        return const OsintResult.failure('URL not found in VirusTotal database.');
      } else {
        return OsintResult.failure('VirusTotal error: HTTP ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('[OSINT VT] $url error: $e');
      return OsintResult.failure('VirusTotal unavailable: $e');
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  Map<String, dynamic> _extractCvss(Map<String, dynamic> metrics) {
    // Try CVSS v3.1 first, then v3.0, then v2
    for (final key in ['cvssMetricV31', 'cvssMetricV30', 'cvssMetricV2']) {
      final list = metrics[key] as List?;
      if (list != null && list.isNotEmpty) {
        final cvssData = (list.first as Map)['cvssData'] as Map?;
        if (cvssData != null) {
          return {
            'score':    (cvssData['baseScore'] as num?)?.toDouble() ?? 0.0,
            'severity': cvssData['baseSeverity'] as String? ?? 'Unknown',
          };
        }
      }
    }
    return {'score': 0.0, 'severity': 'Unknown'};
  }

  void clearSessionCache() {
    _otxCache.clear();
    _cveCache.clear();
    _ipCache.clear();
    _vtCache.clear();
  }
}
