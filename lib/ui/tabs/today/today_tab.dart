import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:journey/core/time/day.dart';
import 'package:journey/data/db/app_db.dart';
import 'package:journey/providers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:journey/ui/widgets/audio_note_tile.dart';
import 'package:journey/ui/search/search_page.dart';
import 'package:journey/ui/widgets/pastel_backdrop.dart';

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

class TodayTab extends ConsumerStatefulWidget {
  const TodayTab({super.key});

  @override
  ConsumerState<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends ConsumerState<TodayTab> {
  final _controller = TextEditingController();
  Timer? _debounce;
  DateTime _day = startOfDay(DateTime.now());
  String _lastSaved = '';
  bool _hydrated = false;

  final _picker = ImagePicker();
  FlutterSoundRecorder? _recorder;
  bool _recorderReady = false;
  bool _isRecording = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _recorder?.closeRecorder();
    super.dispose();
  }

  Future<void> _ensureRecorder() async {
    if (_recorderReady) return;
    _recorder = FlutterSoundRecorder();

    final mic = await Permission.microphone.request();
    if (!mic.isGranted) {
      throw StateError('Microphone permission denied');
    }

    await _recorder!.openRecorder();
    _recorderReady = true;
  }

  void _scheduleSave() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () async {
      final text = _controller.text;
      if (text == _lastSaved) return;
      _lastSaved = text;
      await ref.read(entryRepositoryProvider).upsertTextForDay(_day, text);
    });
  }

  Future<void> _addImage() async {
    final images = await ref.read(entryRepositoryProvider).getImagesForDay(_day);
    if (images.length >= 3) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can add up to 3 images per day.')),
      );
      return;
    }

    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked == null) return;

    final stored = await ref.read(mediaStoreProvider).saveImageForDay(
          day: _day,
          source: File(picked.path),
        );
    await ref.read(entryRepositoryProvider).addImageForDay(_day, stored.path);
  }

  Future<void> _toggleRecording() async {
    try {
      if (_isRecording) {
        final path = await _recorder!.stopRecorder();
        setState(() => _isRecording = false);
        if (path == null) return;
        await ref.read(entryRepositoryProvider).addVoiceNoteForDay(
              day: _day,
              audioPath: path,
              durationMs: null,
            );
        return;
      }

      await _ensureRecorder();
      final file = await ref.read(mediaStoreProvider).audioFileForNewRecording(day: _day);
      await _recorder!.startRecorder(
        toFile: file.path,
        codec: Codec.aacMP4,
      );
      setState(() => _isRecording = true);
    } catch (e) {
      setState(() => _isRecording = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recording failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = startOfDay(DateTime.now());
    if (today != _day) {
      // If the app stayed open across midnight, we pivot to the new day.
      _day = today;
      _hydrated = false;
      _lastSaved = '';
    }

    final asyncEntry = ref.watch(_entryForDayProvider(_day));
    final imagesAsync = ref.watch(_imagesForDayProvider(_day));
    final notesAsync = ref.watch(_voiceNotesForDayProvider(_day));

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('EEEE, MMM d').format(_day)),
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
          IconButton(
            tooltip: 'Add image',
            onPressed: _addImage,
            icon: const Icon(Icons.image_outlined),
          ),
          IconButton(
            tooltip: _isRecording ? 'Stop recording' : 'Record voice note',
            onPressed: _toggleRecording,
            icon: Icon(_isRecording ? Icons.stop_circle_outlined : Icons.mic_none_outlined),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: PastelBackdrop(
        child: RefreshIndicator(
        onRefresh: () async {
          // Streams refresh automatically; keep this for UX.
          await Future<void>.delayed(const Duration(milliseconds: 250));
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What did I learn?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Write a few honest lines. You can only edit today—past entries are read-only.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            imagesAsync.when(
              data: (images) {
                if (images.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    height: 92,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) {
                        final img = images[i];
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                File(img.imagePath),
                                width: 92,
                                height: 92,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 6,
                              child: InkWell(
                                onTap: () => ref.read(entryRepositoryProvider).deleteImage(img.id),
                                borderRadius: BorderRadius.circular(999),
                                child: Ink(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.55),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
            asyncEntry.when(
              data: (entry) {
                final currentText = entry?.textContent ?? '';
                if (!_hydrated) {
                  _hydrated = true;
                  _controller.text = currentText;
                  _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: _controller.text.length),
                  );
                  _lastSaved = currentText;
                }

                return TextField(
                  controller: _controller,
                  onChanged: (_) => _scheduleSave(),
                  maxLines: null,
                  minLines: 14,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    hintText: 'Start writing…',
                  ),
                );
              },
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Failed to load today’s entry: $e'),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: LinearProgressIndicator(),
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
                            onDelete: () => ref.read(entryRepositoryProvider).deleteVoiceNote(notes[i].id),
                          ),
                          if (i != notes.length - 1) const Divider(height: 1),
                        ]
                      ],
                    ),
                  ),
                );
              },
              error: (e, _) => Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text('Failed to load voice notes: $e'),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.only(top: 12),
                child: LinearProgressIndicator(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _isRecording ? 'Recording… tap the stop button to save' : 'Auto-saves as you type',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

