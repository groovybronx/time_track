import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../data/local/database.dart';
import '../../../main.dart'; // Nécessaire pour accéder au databaseProvider défini dans main.dart

/// Provider qui expose la liste des clients en temps réel.
/// Dès qu'un client est ajouté ou modifié en base de données,
/// tous les widgets qui écoutent ce provider se mettent à jour automatiquement.
final clientsListProvider = StreamProvider<List<Client>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllClients();
});

/// Provider pour accéder au contrôleur des clients.
/// On l'utilise pour appeler les méthodes add, update et delete.
final clientsControllerProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return ClientsController(db);
});

/// Le contrôleur qui encapsule la logique métier liée aux clients.
class ClientsController {
  final AppDatabase _db;

  ClientsController(this._db);

  /// Ajoute un nouveau client dans la base de données.
  Future<void> addClient({
    required String societe,
    String? nomContact,
    String? email,
    String? telephone,
    String? notes,
    double? tarifHt,
    required String colorToken,
  }) async {
    await _db.addClient(
      ClientsCompanion.insert(
        societe: societe,
        nomContact: Value(nomContact),
        email: Value(email),
        telephone: Value(telephone),
        notes: Value(notes),
        tarifHt: Value(tarifHt ?? 0.0),
        colorToken: Value(colorToken),
      ),
    );
  }

  /// Met à jour les informations d'un client existant.
  Future<void> updateClient(Client client) async {
    await _db.updateClient(client);
  }

  /// Supprime un client définitivement.
  /// Note : Grâce à KeyAction.cascade dans database.dart, cela supprimera
  /// aussi toutes ses prestations liées.
  Future<void> removeClient(int id) async {
    await _db.deleteClient(id);
  }
}