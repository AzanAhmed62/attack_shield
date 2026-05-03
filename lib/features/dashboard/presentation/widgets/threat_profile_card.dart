import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attackshield/core/theme/theme.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';

/// Displays the full threat profile card with sector insight,
/// top threats, baseline risk, and coverage suggestion prompt.
class ThreatProfileCard extends ConsumerWidget {
  final bool compact;
  const ThreatProfileCard({super.key, this.compact = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(threatProfileProvider);
    final orgAsync = ref.watch(organizationProfileProvider);

    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return _SetupPrompt(onSetup: () => context.push('/settings'));
        }
        return compact
            ? _CompactCard(profile: profile, orgAsync: orgAsync)
            : _FullCard(profile: profile, ref: ref);
      },
      loading: () => const LoadingWidget(),
      error: (e, _) => const SizedBox.shrink(),
    );
  }
}

// ─── Full card ────────────────────────────────────────────────────────────────

class _FullCard extends StatelessWidget {
  final ThreatProfile profile;
  final WidgetRef ref;

  const _FullCard({required this.profile, required this.ref});

  Color get _riskColor {
    switch (profile.riskLevel) {
      case 'Critical':
        return AppTheme.dangerColor;
      case 'High':
        return AppTheme.accentColor;
      case 'Medium':
        return AppTheme.warningColor;
      default:
        return AppTheme.successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.person_pin,
                    color: AppTheme.primaryColor, size: 20),
                const SizedBox(width: 8),
                Text('Your Threat Profile',
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _riskColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: _riskColor.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        profile.baselineRiskScore.toStringAsFixed(0),
                        style: TextStyle(
                            color: _riskColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text('/100',
                          style: TextStyle(
                              color: _riskColor.withValues(alpha: 0.7),
                              fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              profile.sector.label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),

            // ── Risk summary ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _riskColor.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: _riskColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: _riskColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      profile.riskSummary,
                      style: TextStyle(
                          color: _riskColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── Top threats ──────────────────────────────────────────
            Text('Top Threats for Your Organization',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ...profile.topThreats.take(5).map(
                  (threat) => _ThreatRow(threat: threat),
                ),
            const SizedBox(height: 10),

            // ── Sector insight ───────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline,
                      color: AppTheme.primaryColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      profile.sectorInsight,
                      style: const TextStyle(
                          color: AppTheme.primaryColor, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),

            // ── Threat actors ────────────────────────────────────────
            if (profile.commonThreatActors.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text('Known Threat Actors Targeting Your Sector',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: profile.commonThreatActors
                    .map(
                      (actor) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: AppTheme.accentColor
                                  .withValues(alpha: 0.3)),
                        ),
                        child: Text(actor,
                            style: const TextStyle(
                                color: AppTheme.accentColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Compact card (for dashboard) ────────────────────────────────────────────

class _CompactCard extends StatelessWidget {
  final ThreatProfile profile;
  final AsyncValue<OrganizationProfile?> orgAsync;

  const _CompactCard(
      {required this.profile, required this.orgAsync});

  Color get _riskColor {
    switch (profile.riskLevel) {
      case 'Critical':
        return AppTheme.dangerColor;
      case 'High':
        return AppTheme.accentColor;
      case 'Medium':
        return AppTheme.warningColor;
      default:
        return AppTheme.successColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_pin,
                    color: AppTheme.primaryColor, size: 18),
                const SizedBox(width: 6),
                Text('Threat Profile',
                    style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _riskColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    profile.riskLevel,
                    style: TextStyle(
                        color: _riskColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            orgAsync.when(
              data: (org) => Text(
                org?.name ?? 'Your Organization',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppTheme.primaryColor),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),
            // Top 3 threats compact
            ...profile.topThreats.take(3).map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _threatColor(t.riskScore),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            t.plainName,
                            style:
                                Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            if (profile.topThreats.length > 3)
              Text(
                '+${profile.topThreats.length - 3} more threats for your sector',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                        color: AppTheme.primaryColor, fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }

  Color _threatColor(double risk) {
    if (risk >= 8.5) return AppTheme.dangerColor;
    if (risk >= 7.0) return AppTheme.accentColor;
    if (risk >= 5.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }
}

// ─── Threat row ───────────────────────────────────────────────────────────────

class _ThreatRow extends StatelessWidget {
  final NamedThreat threat;
  const _ThreatRow({required this.threat});

  Color get _color {
    if (threat.riskScore >= 8.5) return AppTheme.dangerColor;
    if (threat.riskScore >= 7.0) return AppTheme.accentColor;
    if (threat.riskScore >= 5.0) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${threat.priority}',
                style: TextStyle(
                    color: _color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        threat.plainName,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      threat.techniqueId,
                      style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  threat.riskReason,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Setup prompt ─────────────────────────────────────────────────────────────

class _SetupPrompt extends StatelessWidget {
  final VoidCallback onSetup;
  const _SetupPrompt({required this.onSetup});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_pin_outlined,
                    color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text('Complete Your Profile',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Set your sector, technology stack, and security controls to generate your personalized threat profile.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('Set Up Profile'),
              onPressed: onSetup,
            ),
          ],
        ),
      ),
    );
  }
}
