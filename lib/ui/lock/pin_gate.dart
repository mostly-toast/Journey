import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/providers.dart';
import 'package:journey/ui/lock/pin_lock_page.dart';

/// Simple in-app gate to avoid navigator/route loops.
/// Locks when app is backgrounded and a PIN exists.
class PinGate extends ConsumerStatefulWidget {
  const PinGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<PinGate> createState() => _PinGateState();
}

class _PinGateState extends ConsumerState<PinGate> with WidgetsBindingObserver {
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      final settings = ref.read(appSettingsProvider).valueOrNull;
      if (settings?.hasPin == true) {
        setState(() => _unlocked = false);
      }
    }
  }

  void _onUnlocked() {
    setState(() => _unlocked = true);
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsProvider);

    final hasPin = settingsAsync.valueOrNull?.hasPin == true;
    if (!hasPin) {
      _unlocked = true; // Keep app usable if PIN is disabled.
      return widget.child;
    }

    if (_unlocked) return widget.child;

    return PinLockPage(onUnlocked: _onUnlocked);
  }
}

