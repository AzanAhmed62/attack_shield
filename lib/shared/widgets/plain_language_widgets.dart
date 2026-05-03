// lib/shared/widgets/plain_language_widgets.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/shared/models/plain_language_model.dart';

/// ════════════════════════════════════════════════════════════════════════════════
/// PLAIN LANGUAGE TECHNIQUE CARD
/// Display a technique in non-technical, story-driven format
/// ════════════════════════════════════════════════════════════════════════════════

class PlainLanguageTechniqueCard extends ConsumerWidget {
  final PlainLanguageMapping mapping;
  final String? coverageStatus;
  final VoidCallback? onTap;

  const PlainLanguageTechniqueCard({
    super.key,
    required this.mapping,
    this.coverageStatus,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = _getCoverageColors(coverageStatus);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: colors.borderColor, width: 4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon, name, and status
                Row(
                  children: [
                    // Icon
                    Text(mapping.icon, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    // Name and danger level
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mapping.plainName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            mapping.dangerLevel,
                            style: TextStyle(
                              color: _getDangerColor(mapping.dangerLevel),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Coverage status emoji
                    if (coverageStatus != null)
                      _CoverageStatusBadge(status: coverageStatus!),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),

                // Real-world story
                Text(
                  'What it means:',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mapping.realWorldScenario,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                const SizedBox(height: 12),

                // Who gets hit
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '👥 Who:',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        mapping.targetedTypes,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // How you'd know
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '🔍 Signs:',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        mapping.howYouWouldKnow,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Single action
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    border: Border.all(color: Colors.green.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Text('✅ Do this: '),
                      Expanded(
                        child: Text(
                          mapping.singleActionToTake,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getDangerColor(String level) {
    switch (level) {
      case 'Easy to Do':
        return Colors.red;
      case 'Moderate':
        return Colors.orange;
      case 'Difficult':
        return Colors.amber;
      case 'Highly Difficult':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  ({Color borderColor, Color backgroundColor}) _getCoverageColors(
    String? status,
  ) {
    switch (status) {
      case 'NotCovered':
        return (borderColor: Colors.red, backgroundColor: Colors.red.shade50);
      case 'PartiallyCovered':
        return (
          borderColor: Colors.orange,
          backgroundColor: Colors.orange.shade50,
        );
      case 'Covered':
        return (
          borderColor: Colors.green,
          backgroundColor: Colors.green.shade50,
        );
      default:
        return (borderColor: Colors.grey, backgroundColor: Colors.grey.shade50);
    }
  }
}

/// Coverage status badge with emoji
class _CoverageStatusBadge extends StatelessWidget {
  final String status;

  const _CoverageStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final emoji = status == 'Covered'
        ? '✅'
        : status == 'PartiallyCovered'
        ? '⚠️'
        : '❌';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 16)),
    );
  }
}

/// ════════════════════════════════════════════════════════════════════════════════
/// PLAIN LANGUAGE DETAIL SCREEN
/// Full expanded view of a single technique
/// ════════════════════════════════════════════════════════════════════════════════

class PlainLanguageTechniqueDetail extends ConsumerWidget {
  final PlainLanguageMapping mapping;
  final String? coverageStatus;
  final VoidCallback? onCoverageChanged;

  const PlainLanguageTechniqueDetail({
    super.key,
    required this.mapping,
    this.coverageStatus,
    this.onCoverageChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Color(
                int.parse('FF${mapping.color.substring(1)}', radix: 16),
              ),
              child: Center(
                child: Text(mapping.icon, style: const TextStyle(fontSize: 80)),
              ),
            ),
          ),
        ),
        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  mapping.plainName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                // Danger level
                Chip(
                  label: Text(mapping.dangerLevel),
                  backgroundColor: _getDangerColor(
                    mapping.dangerLevel,
                  ).withValues(alpha: 0.2),
                ),

                const SizedBox(height: 32),

                // Real-world story
                _Section(
                  title: 'What It Means',
                  icon: '📖',
                  content: mapping.realWorldScenario,
                ),

                const SizedBox(height: 24),

                // Who gets hit
                _Section(
                  title: 'Who Gets Attacked This Way',
                  icon: '👥',
                  content: mapping.targetedTypes,
                ),

                const SizedBox(height: 24),

                // How you'd know
                _Section(
                  title: 'How You\'d Know If This Happened',
                  icon: '🔍',
                  content: mapping.howYouWouldKnow,
                ),

                const SizedBox(height: 24),

                // Single action to take
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green.shade300, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '✅ What To Do Right Now',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Colors.green.shade900),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mapping.singleActionToTake,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Coverage status
                if (coverageStatus != null) ...[
                  _buildCoverageSection(context),
                  const SizedBox(height: 24),
                ],

                // Technical ID (for reference)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Technical ID: ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          mapping.techniqueId,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoverageSection(BuildContext context) {
    final colors = _getCoverageColors(coverageStatus);
    final coverageData = {
      'NotCovered': (
        emoji: '❌',
        status: 'Not Protected',
        meaning: 'You have no defense against this attack type',
        suggestion:
            'Add security tools or training to defend against this threat',
      ),
      'PartiallyCovered': (
        emoji: '⚠️',
        status: 'Some Protection',
        meaning: 'You have some defense, but not complete',
        suggestion: 'Improve your defenses and add additional security layers',
      ),
      'Covered': (
        emoji: '✅',
        status: 'Well Protected',
        meaning: 'You have good defense against this attack',
        suggestion: 'Keep this defense updated and test it regularly',
      ),
    };

    final data =
        coverageData[coverageStatus] ??
        (
          emoji: '❓',
          status: 'Unknown',
          meaning: 'Status is unknown',
          suggestion: 'Update your coverage information',
        );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        border: Border.all(color: colors.borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(data.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Status: ${data.status}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.meaning,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '💡 ${data.suggestion}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Color _getDangerColor(String level) {
    switch (level) {
      case 'Easy to Do':
        return Colors.red;
      case 'Moderate':
        return Colors.orange;
      case 'Difficult':
        return Colors.amber;
      case 'Highly Difficult':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  ({Color borderColor, Color backgroundColor}) _getCoverageColors(
    String? status,
  ) {
    switch (status) {
      case 'NotCovered':
        return (borderColor: Colors.red, backgroundColor: Colors.red.shade50);
      case 'PartiallyCovered':
        return (
          borderColor: Colors.orange,
          backgroundColor: Colors.orange.shade50,
        );
      case 'Covered':
        return (
          borderColor: Colors.green,
          backgroundColor: Colors.green.shade50,
        );
      default:
        return (borderColor: Colors.grey, backgroundColor: Colors.grey.shade50);
    }
  }
}

/// ════════════════════════════════════════════════════════════════════════════════
/// SECTION COMPONENT
/// Reusable section for detail screens
/// ════════════════════════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  final String title;
  final String icon;
  final String content;

  const _Section({
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(content, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

/// ════════════════════════════════════════════════════════════════════════════════
/// THREAT PROFILE SUMMARY CARD
/// Display threat profile for organization
/// ════════════════════════════════════════════════════════════════════════════════

class ThreatProfileSummaryCard extends ConsumerWidget {
  final GeneratedThreatProfile profile;

  const ThreatProfileSummaryCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎯 Your Threat Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            // Sector description
            Text(
              profile.sectorDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            // Top threats
            Text(
              'Top Threats To You:',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...profile.topThreats.take(5).map((threat) {
              final percent = (threat.priorityScore / 100 * 100)
                  .toStringAsFixed(0);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        threat.plainLanguageName,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: (threat.priorityScore / 100) * 50,
                            height: 20,
                            decoration: BoxDecoration(
                              color: threat.priorityScore > 70
                                  ? Colors.red
                                  : threat.priorityScore > 40
                                  ? Colors.orange
                                  : Colors.yellow,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Center(
                            child: Text(
                              percent,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            // Initial recommendations
            Text(
              'What To Do First:',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...profile.initialRecommendations.map(
              (rec) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        rec,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
