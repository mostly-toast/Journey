import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/providers.dart';
import 'package:journey/ui/lock/pin_pad.dart';

class PinLockPage extends ConsumerStatefulWidget {
  const PinLockPage({super.key, required this.onUnlocked});

  final VoidCallback onUnlocked;

  @override
  ConsumerState<PinLockPage> createState() => _PinLockPageState();
}

class _PinLockPageState extends ConsumerState<PinLockPage> {
  static const _max = 6;
  String _pin = '';
  String? _error;
  bool _verifying = false;

  Future<void> _submit() async {
    final pin = _pin;
    if (pin.isEmpty) return;
    setState(() {
      _verifying = true;
      _error = null;
    });
    final ok = await ref.read(appSettingsStoreProvider).verifyPin(pin);
    if (!mounted) return;
    if (ok) {
      widget.onUnlocked();
    } else {
      setState(() {
        _verifying = false;
        _error = 'Incorrect PIN';
        _pin = '';
      });
    }
  }

  void _digit(int d) {
    if (_pin.length >= _max) return;
    setState(() {
      _error = null;
      _pin += '$d';
    });
  }

  void _backspace() {
    if (_pin.isEmpty) return;
    setState(() {
      _error = null;
      _pin = _pin.substring(0, _pin.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unlock Journey',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your 4–6 digit PIN to continue.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _PinDots(count: _pin.length, total: _max),
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
                    pinLength: _pin.length,
                    maxLength: _max,
                    onDigit: _digit,
                    onBackspace: _backspace,
                    onSubmit: _verifying ? null : _submit,
                  ),
                ],
              ),
            ),
          ),
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

