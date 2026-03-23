import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/database.dart';
import '../../../main.dart'; // IMPORTANT : On importe le provider global depuis main.dart

/// 1. SUPPRESSION de appDatabaseProvider ici.
/// On utilise uniquement databaseProvider défini dans main.dart.

final activeEntryProvider = StreamProvider<TimeEntry?>((ref) {
  // On utilise le provider global
  final database = ref.watch(databaseProvider);
  return database.watchActiveEntry();
});

final recentEntriesProvider = StreamProvider<List<TimeEntry>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.watchRecentEntries(limit: 10);
});

final trackerControllerProvider = Provider<TrackerController>((ref) {
  final database = ref.watch(databaseProvider);
  return TrackerController(database);
});

class TrackerController {
  TrackerController(this._database);
  final AppDatabase _database;

  /// Lance ou arrête le chronomètre
  /// Ajout de paramètres pour ne plus avoir de texte "en dur"
  Future<void> toggleTracking({
    TimeEntry? activeEntry,
    String? taskName,
    Client? selectedClient,
  }) async {
    if (activeEntry == null) {
      // DÉMARRAGE
      await _database.startEntry(
        taskName: taskName ?? 'Tâche sans nom',
        clientName: selectedClient?.societe ?? '—',
        clientId: selectedClient?.id,
      );
    } else {
      // ARRÊT
      await _database.stopEntry(id: activeEntry.id);
    }
  }
}