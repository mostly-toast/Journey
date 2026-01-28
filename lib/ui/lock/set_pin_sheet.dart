import 'package:flutter/material.dart';
import 'package:journey/ui/lock/pin_pad.dart';

class SetPinSheet extends StatefulWidget {
  const SetPinSheet({super.key});

  @override
  State<SetPinSheet> createState() => _SetPinSheetState();
}

class _SetPinSheetState extends State<SetPinSheet> {
  static const _max = 6;

  String _pin = '';
  String _confirm = '';
  bool _confirming = false;
  String? _error;

  void _digit(int d) {
    setState(() {
      _error = null;
      if (!_confirming) {
        if (_pin.length < _max) _pin += '$d';
      } else {
        if (_confirm.length < _max) _confirm += '$d';
      }
    });
  }

  void _backspace() {
    setState(() {
      _error = null;
      if (!_confirming) {
        if (_pin.isNotEmpty) _pin = _pin.substring(0, _pin.length - 1);
      } else {
        if (_confirm.isNotEmpty) _confirm = _confirm.substring(0, _confirm.length - 1);
      }
    });
  }

  void _submit() {
    setState(() => _error = null);

    if (!_confirming) {
      if (_pin.length < 4) {
        setState(() => _error = 'Use at least 4 digits.');
        return;
      }
      setState(() {
        _confirming = true;
        _confirm = '';
      });
      return;
    }

    if (_confirm != _pin) {
      setState(() {
        _error = 'PINs do not match. Try again.';
        _confirming = false;
        _pin = '';
        _confirm = '';
      });
      return;
    }

    Navigator.of(context).pop(_pin);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final active = _confirming ? _confirm : _pin;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              _confirming ? 'Confirm PIN' : 'Set PIN',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              _confirming ? 'Re-enter your PIN to confirm.' : 'Choose a 4–6 digit PIN.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            _PinDots(count: active.length, total: _max),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(
                _error!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: cs.error,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
            const SizedBox(height: 16),
            PinPad(
              pinLength: active.length,
              maxLength: _max,
              onDigit: _digit,
              onBackspace: _backspace,
              onSubmit: _submit,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PinDots extends StatelessWidget {
  const _PinDots({required this.count, required this.total});

  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final filled = i < count;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? cs.primary : cs.surfaceContainerHighest,
            border: Border.all(
              color: filled ? cs.primary : cs.onSurfaceVariant.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
        );
      }),
    );
  }
}

