import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journey/data/db/app_db.dart';
import 'package:journey/data/media/journey_media_store.dart';
import 'package:journey/data/repository/entry_repository.dart';
import 'package:journey/settings/app_settings.dart';

final dbProvider = Provider<AppDb>((ref) {
  final db = AppDb();
  ref.onDispose(db.close);
  return db;
});

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  return EntryRepository(ref.watch(dbProvider));
});

final mediaStoreProvider = Provider<JourneyMediaStore>((ref) {
  return JourneyMediaStore();
});

final appSettingsStoreProvider = Provider<AppSettingsStore>((ref) {
  return AppSettingsStore();
});

final appSettingsProvider = FutureProvider<AppSettings>((ref) async {
  return ref.read(appSettingsStoreProvider).load();
});


