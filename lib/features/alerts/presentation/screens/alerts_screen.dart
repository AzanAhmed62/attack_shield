import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:attackshield/core/widgets/widgets.dart';
import 'package:attackshield/shared/providers/providers.dart';
import 'package:attackshield/shared/models/models.dart';
import 'package:intl/intl.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAlertsAsync = ref.watch(filteredAlertsProvider);
    final criticalCountAsync = ref.watch(criticalAlertCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Alerts'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: criticalCountAsync.when(
                data: (count) => count > 0
                    ? Badge(
                        label: Text(count.toString()),
                        child: const Icon(Icons.notifications),
                      )
                    : const SizedBox.shrink(),
                loading: () => const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const Icon(Icons.notifications),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchField(
                  hintText: 'Search alerts...',
                  onChanged: (value) {
                    // Update search query provider
                  },
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(label: const Text('All'), onSelected: (_) {}),
                      const SizedBox(width: 8),
                      FilterChip(label: const Text('Open'), onSelected: (_) {}),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Critical'),
                        onSelected: (_) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Alerts list
          Expanded(
            child: filteredAlertsAsync.when(
              data: (alerts) {
                if (alerts.isEmpty) {
                  return EmptyStateWidget(
                    title: 'No Alerts',
                    subtitle: 'Your security feed is empty',
                    icon: Icons.notifications_none,
                    actionLabel: 'Create Alert',
                    onActionPressed: () => _showCreateAlertDialog(context, ref),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: alerts.length,
                  itemBuilder: (context, index) => _AlertCard(
                    alert: alerts[index],
                    onTap: () => _showAlertDetail(context, alerts[index]),
                    onStatusChanged: (newStatus) =>
                        _updateAlertStatus(ref, alerts[index], newStatus),
                  ),
                );
              },
              loading: () => const LoadingWidget(message: 'Loading alerts...'),
              error: (err, st) => EmptyStateWidget(
                title: 'Error',
                subtitle: err.toString(),
                icon: Icons.error_outline,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateAlertDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateAlertDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => _CreateAlertDialog(
        onCreateAlert: (alert) {
          ref.read(createAlertProvider(alert));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showAlertDetail(BuildContext context, AlertItem alert) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _AlertDetailSheet(alert: alert),
    );
  }

  void _updateAlertStatus(
    WidgetRef ref,
    AlertItem alert,
    AlertStatus newStatus,
  ) {
    final updated = alert.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );
    ref.read(updateAlertProvider(updated));
  }
}

class _AlertCard extends StatelessWidget {
  final AlertItem alert;
  final VoidCallback onTap;
  final Function(AlertStatus) onStatusChanged;

  const _AlertCard({
    required this.alert,
    required this.onTap,
    required this.onStatusChanged,
  });

  Color _getPriorityColor() {
    switch (alert.priority) {
      case AlertPriority.critical:
        return Colors.red;
      case AlertPriority.high:
        return Colors.orange;
      case AlertPriority.medium:
        return Colors.yellow;
      case AlertPriority.low:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _getPriorityColor(),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          alert.description,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Chip(
                        label: Text(alert.status.toString().split('.').last),
                        backgroundColor: alert.status == AlertStatus.open
                            ? Colors.red.withValues(alpha: 0.2)
                            : Colors.green.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM d').format(alert.createdAt),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertDetailSheet extends StatelessWidget {
  final AlertItem alert;

  const _AlertDetailSheet({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(alert.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(alert.description),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: const Text('Source:')),
              Chip(label: Text(alert.source)),
              if (alert.relatedTechniqueId != null) ...[
                Chip(label: const Text('Technique:')),
                Chip(label: Text(alert.relatedTechniqueId!)),
              ],
            ],
          ),
          const SizedBox(height: 12),
          if (alert.notes != null && alert.notes!.isNotEmpty) ...[
            Text('Notes:', style: Theme.of(context).textTheme.labelLarge),
            Text(alert.notes!),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _CreateAlertDialog extends StatefulWidget {
  final Function(AlertItem) onCreateAlert;

  const _CreateAlertDialog({required this.onCreateAlert});

  @override
  State<_CreateAlertDialog> createState() => _CreateAlertDialogState();
}

class _CreateAlertDialogState extends State<_CreateAlertDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _sourceController;
  AlertPriority _selectedPriority = AlertPriority.medium;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _sourceController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _sourceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Alert'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sourceController,
              decoration: const InputDecoration(labelText: 'Source'),
            ),
            const SizedBox(height: 12),
            DropdownButton<AlertPriority>(
              value: _selectedPriority,
              isExpanded: true,
              items: AlertPriority.values
                  .map(
                    (p) => DropdownMenuItem(
                      value: p,
                      child: Text(p.toString().split('.').last),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedPriority = value);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final alert = AlertItem(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: _titleController.text,
              description: _descriptionController.text,
              priority: _selectedPriority,
              status: AlertStatus.open,
              source: _sourceController.text,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            widget.onCreateAlert(alert);
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
