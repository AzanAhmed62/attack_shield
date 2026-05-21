// lib/features/alerts/presentation/screens/alerts_screen.dart
// Real persisted alerts, FAB to create, resolve/dismiss,
// priority filtering, linked technique navigation.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../shared/models/alert_item.dart';
import '../../../../shared/providers/alert_providers.dart';

class AlertsScreen extends HookConsumerWidget {
  const AlertsScreen({super.key});

  static const _priorities = ['all', 'critical', 'high', 'medium', 'low'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = useState('all');
    final alertsAsync = ref.watch(alertsProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text(
          'Alerts',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          alertsAsync.when(
            data: (alerts) => Text(
              '${alerts.length} total',
              style: TextStyle(fontSize: 12, color: cs.onSurface),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _priorities.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (_, i) {
                final p = _priorities[i];
                final selected = filter.value == p;
                final color = _priorityColor(p);
                return FilterChip(
                  label: Text(
                    p == 'all' ? 'All' : p[0].toUpperCase() + p.substring(1),
                  ),
                  selected: selected,
                  selectedColor: color.withOpacity(.15),
                  side: BorderSide(
                    color: selected ? color : cs.outlineVariant,
                    width: selected ? 1.5 : 0.5,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: selected ? color : cs.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  onSelected: (_) => filter.value = p,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/alerts/create'),
        icon: const Icon(Icons.add_alert_rounded),
        label: const Text('New Alert'),
      ),
      body: alertsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (alerts) {
          final filtered = filter.value == 'all'
              ? alerts
              : alerts.where((a) => a.priority.name == filter.value).toList();

          if (filtered.isEmpty) return _EmptyState(filter: filter.value);

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) => _AlertCard(
              alert: filtered[i],
              onResolve: () =>
                  ref.read(resolveAlertProvider(filtered[i].id).future),
              onDismiss: () =>
                  ref.read(deleteAlertProvider(filtered[i].id).future),
              onTechniqueOpen: filtered[i].relatedTechniqueId != null
                  ? () => context.push(
                      '/library/${filtered[i].relatedTechniqueId}',
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Color _priorityColor(String p) {
    switch (p) {
      case 'critical':
        return Colors.red.shade600;
      case 'high':
        return Colors.orange.shade600;
      case 'medium':
        return Colors.amber.shade600;
      case 'low':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}

// ─── Alert Card ───────────────────────────────────────────────────────────────
class _AlertCard extends StatelessWidget {
  final AlertItem alert;
  final VoidCallback onResolve;
  final VoidCallback onDismiss;
  final VoidCallback? onTechniqueOpen;
  const _AlertCard({
    required this.alert,
    required this.onResolve,
    required this.onDismiss,
    this.onTechniqueOpen,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = _color(alert.priority);
    final isResolved = alert.status == AlertStatus.resolved;

    return Dismissible(
      key: Key(alert.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(Icons.delete_outline_rounded, color: Colors.red.shade600),
      ),
      onDismissed: (_) => onDismiss(),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isResolved
              ? cs.surfaceContainerLowest
              : cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isResolved ? cs.outlineVariant : color.withOpacity(.3),
            width: isResolved ? 0.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isResolved ? cs.outline : color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    alert.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isResolved ? cs.outline : cs.onSurface,
                      decoration: isResolved
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isResolved
                        ? cs.surfaceContainerHighest
                        : color.withOpacity(.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isResolved ? 'Resolved' : alert.priority.name,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isResolved ? cs.outline : color,
                    ),
                  ),
                ),
              ],
            ),

            if (alert.description.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                alert.description,
                style: TextStyle(fontSize: 12, color: cs.outline, height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time_rounded, size: 12, color: cs.outline),
                const SizedBox(width: 4),
                Text(
                  timeago.format(alert.createdAt),
                  style: TextStyle(fontSize: 11, color: cs.outline),
                ),
                const SizedBox(width: 10),
                Icon(Icons.dns_outlined, size: 12, color: cs.outline),
                const SizedBox(width: 4),
                Text(
                  alert.source,
                  style: TextStyle(fontSize: 11, color: cs.outline),
                ),
                const Spacer(),

                // Linked technique badge
                if (alert.relatedTechniqueId != null)
                  GestureDetector(
                    onTap: onTechniqueOpen,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.link_rounded, size: 10, color: cs.primary),
                          const SizedBox(width: 3),
                          Text(
                            alert.relatedTechniqueId!,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: cs.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(width: 6),
                if (!isResolved)
                  GestureDetector(
                    onTap: onResolve,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.green.shade300,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        'Resolve',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _color(AlertPriority priority) {
    switch (priority) {
      case AlertPriority.critical:
        return Colors.red.shade600;
      case AlertPriority.high:
        return Colors.orange.shade600;
      case AlertPriority.medium:
        return Colors.amber.shade600;
      case AlertPriority.low:
        return Colors.blue.shade600;
    }
  }
}

class _EmptyState extends StatelessWidget {
  final String filter;
  const _EmptyState({required this.filter});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            filter == 'all'
                ? Icons.check_circle_outline_rounded
                : Icons.filter_list_off_rounded,
            size: 52,
            color: cs.outlineVariant,
          ),
          const SizedBox(height: 12),
          Text(
            filter == 'all' ? 'No alerts yet' : 'No $filter alerts',
            style: TextStyle(
              fontSize: 15,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            filter == 'all'
                ? 'Tap + New Alert to log a security event.'
                : 'Try a different severity filter.',
            style: TextStyle(fontSize: 12, color: cs.outline),
          ),
        ],
      ),
    );
  }
}
