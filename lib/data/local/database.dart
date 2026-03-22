import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Ce fichier sera généré par Drift (flutter pub run build_runner build)
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

class Prestations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id, onDelete: KeyAction.cascade)();
  TextColumn get nomTache => text().withLength(min: 1, max: 200)();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime()();

  // Flags d'automatisation
  BoolColumn get autoStart => boolean().withDefault(const Constant(false))();
  BoolColumn get autoStop => boolean().withDefault(const Constant(false))();
  IntColumn get alerteMinutes => integer().withDefault(const Constant(0))();
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column> get primaryKey => {key};
}

// --- BASE DE DONNÉES ---



@DriftDatabase(tables: [Clients, Prestations, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- REQUÊTES RÉACTIVES (STREAMS) ---

  // 1. Récupérer tous les clients
  Stream<List<Client>> watchAllClients() => select(clients).watch();

  // 2. Récupérer les prestations pour l'agenda (avec les infos clients)
  Stream<List<PrestationWithClient>> watchPrestations() {
    final query = select(prestations).join([
      innerJoin(clients, clients.id.equalsExp(prestations.clientId)),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return PrestationWithClient(
          row.readTable(prestations),
          row.readTable(clients),
        );
      }).toList();
    });
  }

  // --- ACTIONS CRUD ---

  Future<int> addClient(ClientsCompanion entry) => into(clients).insert(entry);
  Future updateClient(Client entry) => update(clients).replace(entry);
  Future deleteClient(int id) => (delete(clients)..where((t) => t.id.equals(id))).go();

  Future<int> addPrestation(PrestationsCompanion entry) => into(prestations).insert(entry);
}

// Classe de transfert pour l'agenda (Jointure)
class PrestationWithClient {
  final Prestation prestation;
  final Client client;
  PrestationWithClient(this.prestation, this.client);
}

// Configuration de la connexion (Mobile & Desktop)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'temps_track.sqlite'));
    return NativeDatabase(file);
  });
}