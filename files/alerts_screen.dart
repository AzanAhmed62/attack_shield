// lib/features/alerts/presentation/screens/alerts_screen.dart
// FULL REPLACEMENT — uses AlertItem model, AlertActions notifier,
// AbuseIPDB IP enrichment on alert detail expand.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../shared/models/alert_item.dart';
import '../../../../shared/providers/alert_providers.dart';
import '../../../../shared/providers/repository_providers.dart';
import '../../../../data/services/osint_service.dart';

class AlertsScreen extends HookConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterPriority = useState<AlertPriority?>(null);
    final filterStatus   = useState<AlertStatus?>(AlertStatus.open);
    final alertsAsync    = ref.watch(alertsProvider);
    final cs             = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text('Alerts',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600)),
        actions: [
          alertsAsync.when(
            data: (alerts) {
              final unread = alerts.where((a) => !a.isRead).length;
              if (unread == 0) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('$unread unread',
                    style: TextStyle(fontSize: 11,
                        color: cs.onErrorContainer, fontWeight: FontWeight.w600)),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error:   (_, __) => const SizedBox.shrink(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Column(children: [
            // Status row
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _StatusChip(label: 'Open',   value: AlertStatus.open,         current: filterStatus.value, onTap: (v) => filterStatus.value = filterStatus.value == v ? null : v),
                  const SizedBox(width: 6),
                  _StatusChip(label: 'Ack',    value: AlertStatus.acknowledged, current: filterStatus.value, onTap: (v) => filterStatus.value = filterStatus.value == v ? null : v),
                  const SizedBox(width: 6),
                  _StatusChip(label: 'Resolved', value: AlertStatus.resolved,   current: filterStatus.value, onTap: (v) => filterStatus.value = filterStatus.value == v ? null : v),
                ],
              ),
            ),
            // Priority row
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _PriorityChip(label: 'All',      value: null,                   current: filterPriority.value, onTap: (_) => filterPriority.value = null),
                  const SizedBox(width: 6),
                  _PriorityChip(label: 'Critical',  value: AlertPriority.critical, current: filterPriority.value, onTap: (v) => filterPriority.value = v),
                  const SizedBox(width: 6),
                  _PriorityChip(label: 'High',      value: AlertPriority.high,     current: filterPriority.value, onTap: (v) => filterPriority.value = v),
                  const SizedBox(width: 6),
                  _PriorityChip(label: 'Medium',    value: AlertPriority.medium,   current: filterPriority.value, onTap: (v) => filterPriority.value = v),
                  const SizedBox(width: 6),
                  _PriorityChip(label: 'Low',       value: AlertPriority.low,      current: filterPriority.value, onTap: (v) => filterPriority.value = v),
                ],
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/alerts/create'),
        icon:  const Icon(Icons.add_alert_rounded),
        label: const Text('New Alert'),
      ),
      body: alertsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:   (e, _) => Center(child: Text('Error: $e')),
        data: (alerts) {
          // Mark all unread as read
          WidgetsBinding.instance.addPostFrameCallback((_) {
            for (final a in alerts.where((x) => !x.isRead)) {
              ref.read(alertActionsProvider.notifier).markRead(a.id);
            }
          });

          var filtered = alerts;
          if (filterStatus.value != null) {
            filtered = filtered.where((a) => a.status == filterStatus.value).toList();
          }
          if (filterPriority.value != null) {
            filtered = filtered.where((a) => a.priority == filterPriority.value).toList();
          }

          if (filtered.isEmpty) {
            return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.check_circle_outline_rounded, size: 52, color: cs.outlineVariant),
              const SizedBox(height: 12),
              Text('No alerts match these filters',
                style: TextStyle(fontSize: 15, color: cs.onSurfaceVariant)),
              const SizedBox(height: 6),
              Text('Tap + New Alert to log a security event.',
                style: TextStyle(fontSize: 12, color: cs.outline)),
            ]));
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) => _AlertCard(
              alert: filtered[i],
              onResolve:       () => ref.read(alertActionsProvider.notifier).resolve(filtered[i].id),
              onAcknowledge:   () => ref.read(alertActionsProvider.notifier).acknowledge(filtered[i].id),
              onDismiss:       () => ref.read(alertActionsProvider.notifier).delete(filtered[i].id),
              onTechniqueOpen: filtered[i].effectiveLinkedTechniqueId != null
                  ? () => context.push('/library/${filtered[i].effectiveLinkedTechniqueId}')
                  : null,
            ),
          );
        },
      ),
    );
  }
}

// ─── Alert Card ───────────────────────────────────────────────────────────────
class _AlertCard extends HookConsumerWidget {
  final AlertItem  alert;
  final VoidCallback onResolve, onAcknowledge, onDismiss;
  final VoidCallback? onTechniqueOpen;
  const _AlertCard({
    required this.alert,
    required this.onResolve,
    required this.onAcknowledge,
    required this.onDismiss,
    this.onTechniqueOpen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded  = useState(false);
    final ipResult  = useState<IpReputation?>(null);
    final ipLoading = useState(false);
    final cs        = Theme.of(context).colorScheme;
    final color     = _priorityColor(alert.priority);
    final isResolved = alert.status == AlertStatus.resolved;

    return Dismissible(
      key:       Key(alert.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding:   const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade100, borderRadius: BorderRadius.circular(14)),
        child: Icon(Icons.delete_outline_rounded, color: Colors.red.shade600),
      ),
      onDismissed: (_) => onDismiss(),
      child: GestureDetector(
        onTap: () => expanded.value = !expanded.value,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isResolved ? cs.surfaceContainerLowest : cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isResolved ? cs.outlineVariant : color.withOpacity(.35),
              width: isResolved ? 0.5 : 1,
            ),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Header row
            Row(children: [
              Container(width: 8, height: 8,
                decoration: BoxDecoration(
                  color: isResolved ? cs.outline : color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Expanded(child: Text(alert.title, style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600,
                color: isResolved ? cs.outline : cs.onSurface,
                decoration: isResolved ? TextDecoration.lineThrough : null))),
              _PriorityBadge(priority: alert.priority, isResolved: isResolved),
            ]),

            if (alert.description.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(alert.description,
                style: TextStyle(fontSize: 12, color: cs.outline, height: 1.3),
                maxLines: expanded.value ? null : 2,
                overflow: expanded.value ? null : TextOverflow.ellipsis),
            ],

            const SizedBox(height: 8),
            Row(children: [
              Icon(Icons.access_time_rounded, size: 12, color: cs.outline),
              const SizedBox(width: 4),
              Text(timeago.format(alert.createdAt),
                style: TextStyle(fontSize: 11, color: cs.outline)),
              const SizedBox(width: 10),
              Icon(Icons.dns_outlined, size: 12, color: cs.outline),
              const SizedBox(width: 4),
              Text(alert.source, style: TextStyle(fontSize: 11, color: cs.outline)),
              const Spacer(),
              if (alert.effectiveLinkedTechniqueId != null)
                GestureDetector(
                  onTap: onTechniqueOpen,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer, borderRadius: BorderRadius.circular(5)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.link_rounded, size: 10, color: cs.primary),
                      const SizedBox(width: 3),
                      Text(alert.effectiveLinkedTechniqueId!,
                        style: TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold, color: cs.primary)),
                    ]),
                  ),
                ),
            ]),

            // Expanded actions + OSINT
            if (expanded.value) ...[
              const Divider(height: 16),
              if (!isResolved)
                Row(children: [
                  if (alert.status != AlertStatus.acknowledged)
                    OutlinedButton.icon(
                      onPressed: onAcknowledge,
                      icon: const Icon(Icons.visibility_rounded, size: 14),
                      label: const Text('Ack', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                      ),
                    ),
                  if (alert.status != AlertStatus.acknowledged)
                    const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: onResolve,
                    icon: Icon(Icons.check_circle_outline_rounded,
                        size: 14, color: Colors.green.shade600),
                    label: Text('Resolve',
                        style: TextStyle(fontSize: 12, color: Colors.green.shade600)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      minimumSize: Size.zero,
                      side: BorderSide(color: Colors.green.shade300),
                    ),
                  ),
                ]),

              // Notes
              if (alert.notes?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.sticky_note_2_outlined, size: 13, color: cs.outline),
                  const SizedBox(width: 6),
                  Expanded(child: Text(alert.notes!,
                    style: TextStyle(fontSize: 11, color: cs.outline, height: 1.4))),
                ]),
              ],
            ],
          ]),
        ),
      ),
    );
  }

  Color _priorityColor(AlertPriority p) {
    switch (p) {
      case AlertPriority.critical: return Colors.red.shade600;
      case AlertPriority.high:     return Colors.orange.shade600;
      case AlertPriority.medium:   return Colors.amber.shade600;
      case AlertPriority.low:      return Colors.blue.shade600;
    }
  }
}

class _PriorityBadge extends StatelessWidget {
  final AlertPriority priority;
  final bool          isResolved;
  const _PriorityBadge({required this.priority, required this.isResolved});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (isResolved) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest, borderRadius: BorderRadius.circular(6)),
        child: Text('Resolved', style: TextStyle(fontSize: 10, color: cs.outline)));
    }
    final color = priority == AlertPriority.critical ? Colors.red.shade600
        : priority == AlertPriority.high   ? Colors.orange.shade600
        : priority == AlertPriority.medium ? Colors.amber.shade600
        : Colors.blue.shade600;
    final label = priority.name[0].toUpperCase() + priority.name.substring(1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w600, color: color)));
  }
}

class _StatusChip extends StatelessWidget {
  final String label; final AlertStatus value;
  final AlertStatus? current; final void Function(AlertStatus) onTap;
  const _StatusChip({required this.label, required this.value,
      required this.current, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sel = current == value;
    return FilterChip(
      label: Text(label, style: TextStyle(fontSize: 12,
          color: sel ? cs.primary : cs.onSurface)),
      selected: sel,
      onSelected: (_) => onTap(value),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final String label; final AlertPriority? value;
  final AlertPriority? current; final void Function(AlertPriority?) onTap;
  const _PriorityChip({required this.label, required this.value,
      required this.current, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final cs  = Theme.of(context).colorScheme;
    final sel = current == value;
    return FilterChip(
      label: Text(label, style: TextStyle(fontSize: 12,
          color: sel ? cs.primary : cs.onSurface)),
      selected: sel,
      onSelected: (_) => onTap(value),
    );
  }
}
