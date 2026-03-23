import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// --- TABLES ---

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get societe => text().withLength(min: 1, max: 100)();
  TextColumn get nomContact => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get telephone => text().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get tarifHt => real().withDefault(const Constant(0.0))();
  TextColumn get colorToken => text().withDefault(const Constant('blue-500'))();
}

class TimeEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().nullable().references(
    Clients,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get taskName => text().withLength(min: 1, max: 200)();
  TextColumn get clientName =>
      text().nullable().withDefault(const Constant('—'))();
  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime().nullable()();

  BoolColumn get autoStart => boolean().withDefault(const Constant(false))();
  BoolColumn get autoStop => boolean().withDefault(const Constant(false))();
  IntColumn get alerteMinutes => integer().withDefault(const Constant(0))();
}

// Classe de jointure pour l'Agenda (Prestation + Client)
class TimeEntryWithClient {
  final TimeEntry entry;
  final Client? client;
  TimeEntryWithClient(this.entry, this.client);
}

// --- BASE DE DONNÉES ---

@DriftDatabase(tables: [Clients, TimeEntries])
class AppDatabase extends _$AppDatabase {
  // --- AJOUT DU SINGLETON ---
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._internal() : super(_openConnection());
  // --------------------------

  @override
  int get schemaVersion => 2; // On monte la version car on a ajouté clientName

  // --- MÉTHODES POUR LE TRACKER (Dashboard) ---

  Stream<TimeEntry?> watchActiveEntry() {
    return (select(
      timeEntries,
    )..where((t) => t.endAt.isNull())).watchSingleOrNull();
  }

  Stream<List<TimeEntry>> watchRecentEntries({int limit = 10}) {
    return (select(timeEntries)
          ..orderBy([
            (t) => OrderingTerm(expression: t.startAt, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .watch();
  }

  Future<int> startEntry({
    required String taskName,
    required String clientName,
    int? clientId,
  }) {
    return into(timeEntries).insert(
      TimeEntriesCompanion.insert(
        taskName: taskName,
        clientName: Value(clientName),
        clientId: Value(clientId),
        startAt: DateTime.now(),
      ),
    );
  }

  Future<bool> updateTimeEntry(TimeEntry entry) {
    return update(timeEntries).replace(entry);
  }

  Future<int> deleteTimeEntry(int id) {
    return (delete(timeEntries)..where((t) => t.id.equals(id))).go();
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          // Logique pour passer de la V1 à la V2 : on ajoute la colonne manquante
          await m.addColumn(timeEntries, timeEntries.clientName);
        }
      },
      beforeOpen: (details) async {
        // Optionnel : Active les clés étrangères pour SQLite
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> stopEntry({required int id}) {
    return (update(timeEntries)..where((t) => t.id.equals(id))).write(
      TimeEntriesCompanion(endAt: Value(DateTime.now())),
    );
  }

  // --- MÉTHODES POUR L'AGENDA (Jointure) ---

  Stream<List<TimeEntryWithClient>> watchPrestationsWithClient() {
    final query = select(timeEntries).join([
      leftOuterJoin(clients, clients.id.equalsExp(timeEntries.clientId)),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TimeEntryWithClient(
          row.readTable(timeEntries),
          row.readTableOrNull(clients),
        );
      }).toList();
    });
  }

  // --- MÉTHODES CLIENTS (CRUD) ---

  Stream<List<Client>> watchAllClients() => select(clients).watch();
  Future<int> addClient(ClientsCompanion entry) => into(clients).insert(entry);
  Future<bool> updateClient(Client entry) => update(clients).replace(entry);
  Future<int> deleteClient(int id) =>
      (delete(clients)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'temps_track.sqlite'));
    return NativeDatabase(file);
  });
}
