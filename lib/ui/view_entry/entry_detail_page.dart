import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:journey/core/time/day.dart';
import 'package:journey/data/db/app_db.dart';
import 'package:journey/providers.dart';
import 'package:journey/ui/widgets/audio_note_tile.dart';

final _entryForDayProvider = StreamProvider.family<Entry?, DateTime>((ref, day) {
  return ref.watch(entryRepositoryProvider).watchEntryForDay(day);
});

final _imagesForDayProvider = StreamProvider.family<List<EntryImage>, DateTime>((ref, day) {
  return ref.watch(entryRepositoryProvider).watchImagesForDay(day);
});

final _voiceNotesForDayProvider =
    StreamProvider.family<List<VoiceNote>, DateTime>((ref, day) {
  return ref.watch(entryRepositoryProvider).watchVoiceNotesForDay(day);
});

class EntryDetailPage extends ConsumerWidget {
  const EntryDetailPage({super.key, required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = startOfDay(day);
    final isToday = d == startOfDay(DateTime.now());
    final entryAsync = ref.watch(_entryForDayProvider(d));
    final imagesAsync = ref.watch(_imagesForDayProvider(d));
    final notesAsync = ref.watch(_voiceNotesForDayProvider(d));

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('EEE, MMM d').format(d)),
      ),
      body: entryAsync.when(
        data: (entry) {
          final text = entry?.textContent.trim() ?? '';

          if (isToday) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'This is today — edit it from the Today tab.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              imagesAsync.when(
                data: (images) {
                  if (images.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (final img in images)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  File(img.imagePath),
                                  width: (MediaQuery.of(context).size.width - 16 * 2 - 12 * 2 - 10) / 2,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                error: (e, _) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text('Failed to load images: $e'),
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: LinearProgressIndicator(),
                ),
              ),
              if (text.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No text entry for this day.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              notesAsync.when(
                data: (notes) {
                  if (notes.isEmpty) return const SizedBox.shrink();
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Voice notes',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 10),
                          for (var i = 0; i < notes.length; i++) ...[
                            AudioNoteTile(
                              path: notes[i].audioPath,
                              title: 'Note ${i + 1}',
                            ),
                            if (i != notes.length - 1) const Divider(height: 1),
                          ],
                        ],
                      ),
                    ),
                  );
                },
                error: (e, _) => Text('Failed to load voice notes: $e'),
                loading: () => const LinearProgressIndicator(),
              ),
            ],
          );
        },
        error: (e, _) => Center(child: Text('Failed to load entry: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

