import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Search field widget with filter option
class SearchField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterPressed;
  final TextEditingController? controller;

  const SearchField({
    super.key,
    this.hintText = 'Search...',
    required this.onChanged,
    this.onFilterPressed,
    this.controller,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: widget.onFilterPressed != null
            ? IconButton(
                icon: const Icon(Icons.tune),
                onPressed: widget.onFilterPressed,
              )
            : null,
      ),
    );
  }
}

/// Progress ring widget for showing percentage
class ProgressRing extends StatelessWidget {
  final double percentage;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final String? label;

  const ProgressRing({
    super.key,
    required this.percentage,
    this.progressColor = AppTheme.primaryColor,
    this.backgroundColor = const Color(0xFF333333),
    this.strokeWidth = 8,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                backgroundColor: backgroundColor,
              ),
              Center(
                child: Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: progressColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 8),
          Text(label!, style: Theme.of(context).textTheme.bodySmall),
        ],
      ],
    );
  }
}

/// Section header widget
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;
  final bool showViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAllPressed,
    this.showViewAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        if (showViewAll && onViewAllPressed != null)
          TextButton(
            onPressed: onViewAllPressed,
            child: const Text('View All'),
          ),
      ],
    );
  }
}
