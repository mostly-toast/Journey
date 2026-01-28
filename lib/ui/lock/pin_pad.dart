import 'package:flutter/material.dart';

class PinPad extends StatelessWidget {
  const PinPad({
    super.key,
    required this.pinLength,
    required this.maxLength,
    required this.onDigit,
    required this.onBackspace,
    this.onSubmit,
  });

  final int pinLength;
  final int maxLength;
  final void Function(int digit) onDigit;
  final VoidCallback onBackspace;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget key(String label, {VoidCallback? onTap, bool filled = false}) {
      return AspectRatio(
        aspectRatio: 1.4,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: filled ? cs.primaryContainer : cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            for (final d in [1, 2, 3, 4, 5, 6, 7, 8, 9])
              key(
                '$d',
                onTap: pinLength < maxLength ? () => onDigit(d) : null,
              ),
            key('⌫', onTap: onBackspace),
            key('0', onTap: pinLength < maxLength ? () => onDigit(0) : null),
            key('OK', filled: true, onTap: onSubmit),
          ],
        ),
      ],
    );
  }
}

