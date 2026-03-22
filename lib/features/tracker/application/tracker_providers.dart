import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final activeEntryProvider = StreamProvider<TimeEntry?>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchActiveEntry();
});

final recentEntriesProvider = StreamProvider<List<TimeEntry>>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchRecentEntries(limit: 10);
});

final trackerControllerProvider = Provider<TrackerController>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return TrackerController(database);
});

class TrackerController {
  TrackerController(this._database);

  final AppDatabase _database;

  Future<void> toggleTracking(TimeEntry? activeEntry) async {
    if (activeEntry == null) {
      await _database.startEntry(
        taskName: 'Installation Réseau',
        clientName: 'Client Martin',
      );
      return;
    }

    await _database.stopEntry(id: activeEntry.id);
  }
}
