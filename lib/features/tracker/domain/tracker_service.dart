import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import '../../../data/local/database.dart';

class TrackerService extends ChangeNotifier {
  final AppDatabase _db;

  // État Interne
  Timer? _timer;
  DateTime? _startTime;
  String _currentTaskName = "";
  int? _currentClientId;

  // Valeurs exposées à l'UI
  Duration _elapsedTime = Duration.zero;
  bool _isRunning = false;

  TrackerService(this._db);

  // Getters pour l'UI
  bool get isRunning => _isRunning;
  Duration get elapsedTime => _elapsedTime;
  String get currentTaskName => _currentTaskName;

  /// 1. DÉMARRER LE CHRONO
  void startTracking({required String taskName, required int clientId}) {
    if (_isRunning) return;

    _currentTaskName = taskName;
    _currentClientId = clientId;
    _startTime = DateTime.now();
    _isRunning = true;
    _elapsedTime = Duration.zero;

    // Mise à jour chaque seconde
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedTime = DateTime.now().difference(_startTime!);
      notifyListeners(); // Prévient l'UI qu'il faut se redessiner

      // LOGIQUE TODO : Vérifier ici si dépassement pour envoyer notification
    });

    notifyListeners();
  }

  /// 2. ARRÊTER ET ENREGISTRER
  Future<void> stopTracking() async {
    if (!_isRunning || _startTime == null || _currentClientId == null) return;

    final endTime = DateTime.now();
    _timer?.cancel();

    // ENREGISTREMENT DANS SQLITE
    await _db.addPrestation(PrestationsCompanion(
      nomTache: Value(_currentTaskName),
      clientId: Value(_currentClientId!),
      dateDebut: Value(_startTime!),
      dateFin: Value(endTime),
      // On peut ajouter ici les flags autoStart/Stop par défaut depuis les Settings
    ));

    // Réinitialisation
    _isRunning = false;
    _elapsedTime = Duration.zero;
    _startTime = null;

    notifyListeners();
  }

  /// 3. ANNULER (Sans enregistrer)
  void cancelTracking() {
    _timer?.cancel();
    _isRunning = false;
    _elapsedTime = Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}