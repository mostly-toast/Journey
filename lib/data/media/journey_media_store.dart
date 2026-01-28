import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Stores media under the app documents directory:
/// `journey_media/YYYY-MM-DD/{images|audio}/...`
class JourneyMediaStore {
  Future<Directory> _dayDir(String dayKey) async {
    final docs = await getApplicationDocumentsDirectory();
    final root = Directory(p.join(docs.path, 'journey_media', dayKey));
    if (!root.existsSync()) root.createSync(recursive: true);
    return root;
  }

  Future<File> saveImageForDay({
    required DateTime day,
    required File source,
  }) async {
    final dayKey = _dayKey(day);
    final dir = Directory(p.join((await _dayDir(dayKey)).path, 'images'));
    if (!dir.existsSync()) dir.createSync(recursive: true);

    final ext = p.extension(source.path).isEmpty ? '.jpg' : p.extension(source.path);
    final filename = 'img_${DateTime.now().microsecondsSinceEpoch}$ext';
    final target = File(p.join(dir.path, filename));
    return source.copy(target.path);
  }

  Future<File> audioFileForNewRecording({
    required DateTime day,
  }) async {
    final dayKey = _dayKey(day);
    final dir = Directory(p.join((await _dayDir(dayKey)).path, 'audio'));
    if (!dir.existsSync()) dir.createSync(recursive: true);

    final filename = 'note_${DateTime.now().microsecondsSinceEpoch}.m4a';
    return File(p.join(dir.path, filename));
  }

  String _dayKey(DateTime day) {
    final y = day.year.toString().padLeft(4, '0');
    final m = day.month.toString().padLeft(2, '0');
    final d = day.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}

