import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Reusable metric card for displaying KPIs like coverage, risk, etc
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: Theme.of(context).textTheme.titleSmall),
                  if (icon != null)
                    Icon(icon, color: AppTheme.primaryColor, size: 20),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: valueColor ?? AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable widget for displaying a technique as a tile/card
class TechniqueTile extends StatelessWidget {
  final String techniqueId;
  final String techniqueName;
  final String? tactic;
  final double riskScore;
  final bool isBookmarked;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkToggle;

  const TechniqueTile({
    super.key,
    required this.techniqueId,
    required this.techniqueName,
    this.tactic,
    required this.riskScore,
    this.isBookmarked = false,
    required this.onTap,
    this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(techniqueName),
          if (tactic != null)
            Text(tactic!, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
      subtitle: Text(techniqueId),
      trailing: Wrap(
        spacing: 8,
        children: [
          RiskScoreBadge(riskScore: riskScore),
          if (onBookmarkToggle != null)
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: AppTheme.primaryColor,
              ),
              onPressed: onBookmarkToggle,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}

/// Risk score badge component
class RiskScoreBadge extends StatelessWidget {
  final double riskScore;

  const RiskScoreBadge({super.key, required this.riskScore});

  Color _getRiskColor() {
    if (riskScore < 2.0) return AppTheme.successColor;
    if (riskScore < 4.0) return AppTheme.warningColor;
    if (riskScore < 6.0) return AppTheme.accentColor;
    return AppTheme.dangerColor;
  }

  String _getRiskLabel() {
    if (riskScore < 2.0) return 'Low';
    if (riskScore < 4.0) return 'Medium';
    if (riskScore < 6.0) return 'High';
    return 'Critical';
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(_getRiskLabel()),
      backgroundColor: _getRiskColor().withValues(alpha: 0.2),
      labelStyle: TextStyle(color: _getRiskColor()),
    );
  }
}

/// Severity badge component (deprecated - use RiskScoreBadge instead)
class SeverityBadge extends StatelessWidget {
  final int severity;

  const SeverityBadge({super.key, required this.severity});

  Color _getSeverityColor() {
    switch (severity) {
      case 1:
      case 2:
        return AppTheme.successColor;
      case 3:
      case 4:
        return AppTheme.warningColor;
      case 5:
      case 6:
        return AppTheme.accentColor;
      case 7:
      case 8:
      case 9:
        return AppTheme.dangerColor;
      default:
        return Colors.grey;
    }
  }

  String _getSeverityLabel() {
    switch (severity) {
      case 1:
      case 2:
        return 'Low';
      case 3:
      case 4:
        return 'Medium';
      case 5:
      case 6:
        return 'High';
      case 7:
      case 8:
      case 9:
        return 'Critical';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(_getSeverityLabel()),
      backgroundColor: _getSeverityColor().withValues(alpha: 0.2),
      labelStyle: TextStyle(color: _getSeverityColor()),
    );
  }
}

/// Status chip for coverage status
class StatusChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: backgroundColor.withValues(alpha: 0.2),
      labelStyle: TextStyle(color: textColor),
    );
  }
}

/// Empty state widget
class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onActionPressed,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppTheme.primaryColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (onActionPressed != null && actionLabel != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onActionPressed,
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

/// Loading widget
class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
