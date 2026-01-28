import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/providers.dart';
import 'package:journey/settings/app_settings.dart';
import 'package:journey/ui/theme/journey_theme.dart';
import 'package:journey/ui/shell/home_shell.dart';

class JourneyApp extends ConsumerWidget {
  const JourneyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsProvider);

    return settingsAsync.when(
      data: (settings) {
        final themeMode = switch (settings.themeMode) {
          AppThemeMode.system => ThemeMode.system,
          AppThemeMode.light => ThemeMode.light,
          AppThemeMode.dark => ThemeMode.dark,
        };

        return MaterialApp(
          title: 'Journey',
          theme: JourneyTheme.light(),
          darkTheme: JourneyTheme.dark(),
          themeMode: themeMode,
          home: const HomeShell(),
        );
      },
      loading: () => MaterialApp(
        title: 'Journey',
        theme: JourneyTheme.light(),
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, _) => MaterialApp(
        title: 'Journey',
        theme: JourneyTheme.light(),
        home: Scaffold(
          body: Center(child: Text('Failed to load settings: $e')),
        ),
      ),
    );
  }
}
