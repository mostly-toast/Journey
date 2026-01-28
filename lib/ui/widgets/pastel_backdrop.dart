import 'package:flutter/material.dart';

/// A subtle pastel background wash (light + dark friendly).
class PastelBackdrop extends StatelessWidget {
  const PastelBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Pastel, low-contrast blobs. Keep very subtle in dark mode.
    final a1 = isDark ? 0.10 : 0.16;
    final a2 = isDark ? 0.06 : 0.12;

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cs.primary.withValues(alpha: a1),
                  cs.tertiary.withValues(alpha: a2),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

