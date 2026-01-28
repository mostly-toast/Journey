import 'package:drift/drift.dart';
import 'package:journey/core/time/day.dart';
import 'package:journey/data/db/app_db.dart';

class EntryRepository {
  EntryRepository(this._db);

  final AppDb _db;

  Future<int> ensureEntryForDay(DateTime day) async {
    final d = startOfDay(day);
    final now = DateTime.now();
    final existing = await getEntryForDay(d);
    if (existing != null) return existing.id;

    return _db.into(_db.entries).insert(
          EntriesCompanion.insert(
            day: d,
            textContent: const Value(''),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Stream<Entry?> watchEntryForDay(DateTime day) {
    final d = startOfDay(day);
    final q = _db.select(_db.entries)..where((t) => t.day.equals(d));
    return q.watchSingleOrNull();
  }

  Future<Entry?> getEntryForDay(DateTime day) async {
    final d = startOfDay(day);
    final q = _db.select(_db.entries)..where((t) => t.day.equals(d));
    return q.getSingleOrNull();
  }

  Future<void> upsertTextForDay(DateTime day, String text) async {
    final d = startOfDay(day);
    final now = DateTime.now();

    final existing = await getEntryForDay(d);
    if (existing == null) {
      await _db.into(_db.entries).insert(
            EntriesCompanion.insert(
              day: d,
              textContent: Value(text),
              createdAt: now,
              updatedAt: now,
            ),
          );
      return;
    }

    await (_db.update(_db.entries)..where((t) => t.id.equals(existing.id))).write(
      EntriesCompanion(
        textContent: Value(text),
        updatedAt: Value(now),
      ),
    );
  }

  Stream<List<EntryImage>> watchImagesForDay(DateTime day) {
    final d = startOfDay(day);
    final q = _db.select(_db.entryImages).join([
      innerJoin(_db.entries, _db.entries.id.equalsExp(_db.entryImages.entryId)),
    ])
      ..where(_db.entries.day.equals(d))
      ..orderBy([OrderingTerm(expression: _db.entryImages.sortOrder)]);

    return q.watch().map((rows) {
      return rows.map((row) => row.readTable(_db.entryImages)).toList();
    });
  }

  Future<List<EntryImage>> getImagesForDay(DateTime day) async {
    final d = startOfDay(day);
    final entry = await getEntryForDay(d);
    if (entry == null) return <EntryImage>[];
    final q = (_db.select(_db.entryImages)..where((t) => t.entryId.equals(entry.id)))
      ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]);
    return q.get();
  }

  Future<void> addImageForDay(DateTime day, String imagePath) async {
    final entryId = await ensureEntryForDay(day);
    final current = await (_db.select(_db.entryImages)..where((t) => t.entryId.equals(entryId))).get();
    final nextOrder = current.isEmpty ? 0 : (current.map((e) => e.sortOrder).reduce((a, b) => a > b ? a : b) + 1);
    await _db.into(_db.entryImages).insert(
          EntryImagesCompanion.insert(
            entryId: entryId,
            imagePath: imagePath,
            sortOrder: Value(nextOrder),
          ),
        );
  }

  Future<void> deleteImage(int id) async {
    await (_db.delete(_db.entryImages)..where((t) => t.id.equals(id))).go();
  }

  Stream<List<VoiceNote>> watchVoiceNotesForDay(DateTime day) {
    final d = startOfDay(day);
    final q = _db.select(_db.voiceNotes).join([
      innerJoin(_db.entries, _db.entries.id.equalsExp(_db.voiceNotes.entryId)),
    ])
      ..where(_db.entries.day.equals(d))
      ..orderBy([OrderingTerm(expression: _db.voiceNotes.sortOrder)]);

    return q.watch().map((rows) {
      return rows.map((row) => row.readTable(_db.voiceNotes)).toList();
    });
  }

  Future<void> addVoiceNoteForDay({
    required DateTime day,
    required String audioPath,
    int? durationMs,
  }) async {
    final entryId = await ensureEntryForDay(day);
    final current = await (_db.select(_db.voiceNotes)..where((t) => t.entryId.equals(entryId))).get();
    final nextOrder = current.isEmpty ? 0 : (current.map((e) => e.sortOrder).reduce((a, b) => a > b ? a : b) + 1);
    await _db.into(_db.voiceNotes).insert(
          VoiceNotesCompanion.insert(
            entryId: entryId,
            audioPath: audioPath,
            durationMs: Value(durationMs),
            sortOrder: Value(nextOrder),
            createdAt: DateTime.now(),
          ),
        );
  }

  Future<void> deleteVoiceNote(int id) async {
    await (_db.delete(_db.voiceNotes)..where((t) => t.id.equals(id))).go();
  }

  Stream<Set<DateTime>> watchDaysWithEntriesInMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);

    final q = _db.select(_db.entries)
      ..where((t) => t.day.isBiggerOrEqualValue(start))
      ..where((t) => t.day.isSmallerThanValue(end));

    return q.watch().map((rows) => rows.map((e) => e.day).toSet());
  }

  Stream<int> watchStreakUpTo(DateTime today) {
    // Simple approach for Phase 1: read all days up to today and compute streak.
    final t = startOfDay(today);
    final q = _db.select(_db.entries)
      ..where((row) => row.day.isSmallerOrEqualValue(t))
      ..orderBy([(row) => OrderingTerm(expression: row.day, mode: OrderingMode.desc)]);

    return q.watch().map((rows) {
      final days = rows.map((e) => startOfDay(e.day)).toSet();
      var streak = 0;
      var cursor = t;
      while (days.contains(cursor)) {
        streak += 1;
        cursor = cursor.subtract(const Duration(days: 1));
      }
      return streak;
    });
  }

  Stream<Map<DateTime, String>> watchMonthThumbnailPaths(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);

    final q = _db.select(_db.entryImages).join([
      innerJoin(_db.entries, _db.entries.id.equalsExp(_db.entryImages.entryId)),
    ])
      ..where(_db.entries.day.isBiggerOrEqualValue(start))
      ..where(_db.entries.day.isSmallerThanValue(end))
      ..orderBy([
        OrderingTerm(expression: _db.entries.day),
        OrderingTerm(expression: _db.entryImages.sortOrder),
      ]);

    return q.watch().map((rows) {
      final out = <DateTime, String>{};
      for (final row in rows) {
        final entry = row.readTable(_db.entries);
        final img = row.readTable(_db.entryImages);
        out.putIfAbsent(entry.day, () => img.imagePath);
      }
      return out;
    });
  }
}

