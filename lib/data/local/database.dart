import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class TimeEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get taskName => text()();

  TextColumn get clientName =>
      text().withDefault(const Constant('Sans client'))();

  DateTimeColumn get startAt => dateTime()();

  DateTimeColumn get endAt => dateTime().nullable()();
}

@DriftDatabase(tables: [TimeEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'time_track.sqlite'));

  @override
  int get schemaVersion => 1;

  Stream<List<TimeEntry>> watchRecentEntries({int limit = 20}) {
    final query = select(timeEntries)
      ..orderBy([(t) => OrderingTerm.desc(t.startAt)])
      ..limit(limit);

    return query.watch();
  }

  Stream<TimeEntry?> watchActiveEntry() {
    final query = select(timeEntries)
      ..where((t) => t.endAt.isNull())
      ..orderBy([(t) => OrderingTerm.desc(t.startAt)])
      ..limit(1);

    return query.watchSingleOrNull();
  }

  Future<int> startEntry({
    required String taskName,
    required String clientName,
    DateTime? startAt,
  }) {
    return into(timeEntries).insert(
      TimeEntriesCompanion.insert(
        taskName: taskName,
        clientName: Value(clientName),
        startAt: startAt ?? DateTime.now(),
      ),
    );
  }

  Future<int> stopEntry({required int id, DateTime? endAt}) {
    return (update(timeEntries)..where((t) => t.id.equals(id))).write(
      TimeEntriesCompanion(endAt: Value(endAt ?? DateTime.now())),
    );
  }
}
