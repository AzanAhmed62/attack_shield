// lib/shared/widgets/shimmer_loader.dart
// Reusable shimmer skeleton for loading states across the app.

import 'package:flutter/material.dart';

class ShimmerLoader extends StatefulWidget {
  final double  height;
  final double? width;
  final double  borderRadius;
  const ShimmerLoader({
    super.key,
    required this.height,
    this.width,
    this.borderRadius = 12,
  });

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double>   _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return Container(
          height:       widget.height,
          width:        widget.width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin:  Alignment(_anim.value - 1, 0),
              end:    Alignment(_anim.value,      0),
              colors: [
                cs.surfaceContainerHighest,
                cs.surfaceContainerHigh,
                cs.surfaceContainerHighest,
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

// lib/shared/widgets/main_scaffold.dart
// Bottom navigation shell — correct destinations, correct icons, correct labels.

// NOTE: This is a separate class but kept in one file for delivery.
// Split into main_scaffold.dart manually.
