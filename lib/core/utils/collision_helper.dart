import '../../data/local/database.dart';

class PositionedTimeEntry {
  final TimeEntryWithClient data; // Contient l'entry et le client
  final double top;
  final double height;
  final double left;
  final double width;

  PositionedTimeEntry({
    required this.data,
    required this.top,
    required this.height,
    required this.left,
    required this.width,
  });
}

class CollisionHelper {
  static List<PositionedTimeEntry> getPositionedEntries(
    List<TimeEntryWithClient> items,
    double hourHeight,
  ) {
    if (items.isEmpty) return [];

    // 1. Trier par heure de début
    final sorted = List<TimeEntryWithClient>.from(items)
      ..sort((a, b) => a.entry.startAt.compareTo(b.entry.startAt));

    final List<PositionedTimeEntry> positionedEntries = [];
    final List<List<TimeEntryWithClient>> clusters = [];

    // 2. Grouper par "clusters" de collision
    for (var item in sorted) {
      bool addedToCluster = false;
      for (var cluster in clusters) {
        // Si l'entrée chevauche n'importe quelle entrée du cluster, elle en fait partie
        if (cluster.any((e) => _overlaps(e.entry, item.entry))) {
          cluster.add(item);
          addedToCluster = true;
          break;
        }
      }
      if (!addedToCluster) {
        clusters.add([item]);
      }
    }

    // 3. Calculer les colonnes pour chaque cluster
    for (var cluster in clusters) {
      positionedEntries.addAll(_processCluster(cluster, hourHeight));
    }

    return positionedEntries;
  }

  static List<PositionedTimeEntry> _processCluster(
    List<TimeEntryWithClient> cluster,
    double hourHeight,
  ) {
    // Liste de colonnes, chaque colonne contient une liste d'entrées
    List<List<TimeEntryWithClient>> columns = [];

    for (var item in cluster) {
      bool placed = false;
      for (var column in columns) {
        // Si l'entrée ne chevauche aucune entrée déjà dans cette colonne
        if (!column.any((e) => _overlaps(e.entry, item.entry))) {
          column.add(item);
          placed = true;
          break;
        }
      }
      if (!placed) {
        columns.add([item]);
      }
    }

    // Convertir les colonnes en coordonnées réelles
    final double columnWidth = 1.0 / columns.length;
    final List<PositionedTimeEntry> results = [];

    for (int i = 0; i < columns.length; i++) {
      for (var item in columns[i]) {
        final startHour = item.entry.startAt.hour + (item.entry.startAt.minute / 60.0);
        final endAt = item.entry.endAt ?? DateTime.now();
        final endHour = endAt.hour + (endAt.minute / 60.0);

        results.add(PositionedTimeEntry(
          data: item,
          top: startHour * hourHeight,
          // On s'assure d'une hauteur minimum (ex: 15 min) pour que le bloc soit visible
          height: (endHour - startHour).clamp(0.25, 24.0) * hourHeight,
          left: i * columnWidth,
          width: columnWidth,
        ));
      }
    }

    return results;
  }

  static bool _overlaps(TimeEntry a, TimeEntry b) {
    final endA = a.endAt ?? DateTime.now();
    final endB = b.endAt ?? DateTime.now();
    // Deux tâches se chevauchent si l'une commence avant que l'autre ne finisse
    return a.startAt.isBefore(endB) && endA.isAfter(b.startAt);
  }
}