import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/providers.dart';
import 'package:journey/settings/app_settings.dart';

import 'package:journey/ui/search/search_page.dart';
import 'package:journey/ui/widgets/pastel_backdrop.dart';

final _streakProvider = StreamProvider<int>((ref) {
  return ref.watch(entryRepositoryProvider).watchStreakUpTo(DateTime.now());
});

class InsightsTab extends ConsumerWidget {
  const InsightsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(_streakProvider);

    final settingsAsync = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (_, __, ___) => const SearchPage(),
                  transitionsBuilder: (_, anim, __, child) {
                    return FadeTransition(opacity: anim, child: child);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: PastelBackdrop(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: streakAsync.when(
                data: (streak) {
                  final headline = streak == 1 ? '1 day' : '$streak days';
                  final sub = streak == 0
                      ? 'Start today — your streak begins with one honest entry.'
                      : 'Keep going. Small, daily notes add up.';

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Writing streak',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            headline,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            sub,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                error: (e, _) => Text('Failed to load streak: $e'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 24),
            settingsAsync.when(
              data: (settings) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appearance',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<AppThemeMode>(
                            value: settings.themeMode,
                            items: const [
                              DropdownMenuItem(
                                value: AppThemeMode.system,
                                child: Text('Follow system'),
                              ),
                              DropdownMenuItem(
                                value: AppThemeMode.light,
                                child: Text('Light'),
                              ),
                              DropdownMenuItem(
                                value: AppThemeMode.dark,
                                child: Text('Dark'),
                              ),
                            ],
                            onChanged: (value) async {
                              if (value == null) return;
                              await ref
                                  .read(appSettingsStoreProvider)
                                  .setThemeMode(value);
                              ref.invalidate(appSettingsProvider);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (e, _) => Text('Failed to load appearance settings: $e'),
              loading: () => const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
