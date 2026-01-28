import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

class Entries extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Normalized as local midnight for that day.
  DateTimeColumn get day => dateTime().unique()();

  TextColumn get textContent => text().withDefault(const Constant(''))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class EntryImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().references(Entries, #id, onDelete: KeyAction.cascade)();
  TextColumn get imagePath => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class VoiceNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().references(Entries, #id, onDelete: KeyAction.cascade)();
  TextColumn get audioPath => text()();
  IntColumn get durationMs => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [Entries, EntryImages, VoiceNotes])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(entryImages);
            await m.createTable(voiceNotes);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'journey.sqlite'));
    return NativeDatabase(file);
  });
}

