// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TimeEntriesTable extends TimeEntries
    with TableInfo<$TimeEntriesTable, TimeEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _taskNameMeta = const VerificationMeta(
    'taskName',
  );
  @override
  late final GeneratedColumn<String> taskName = GeneratedColumn<String>(
    'task_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientNameMeta = const VerificationMeta(
    'clientName',
  );
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
    'client_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Sans client'),
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskName,
    clientName,
    startAt,
    endAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_name')) {
      context.handle(
        _taskNameMeta,
        taskName.isAcceptableOrUnknown(data['task_name']!, _taskNameMeta),
      );
    } else if (isInserting) {
      context.missing(_taskNameMeta);
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_name'],
      )!,
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      ),
    );
  }

  @override
  $TimeEntriesTable createAlias(String alias) {
    return $TimeEntriesTable(attachedDatabase, alias);
  }
}

class TimeEntry extends DataClass implements Insertable<TimeEntry> {
  final int id;
  final String taskName;
  final String clientName;
  final DateTime startAt;
  final DateTime? endAt;
  const TimeEntry({
    required this.id,
    required this.taskName,
    required this.clientName,
    required this.startAt,
    this.endAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_name'] = Variable<String>(taskName);
    map['client_name'] = Variable<String>(clientName);
    map['start_at'] = Variable<DateTime>(startAt);
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<DateTime>(endAt);
    }
    return map;
  }

  TimeEntriesCompanion toCompanion(bool nullToAbsent) {
    return TimeEntriesCompanion(
      id: Value(id),
      taskName: Value(taskName),
      clientName: Value(clientName),
      startAt: Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
    );
  }

  factory TimeEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeEntry(
      id: serializer.fromJson<int>(json['id']),
      taskName: serializer.fromJson<String>(json['taskName']),
      clientName: serializer.fromJson<String>(json['clientName']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime?>(json['endAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskName': serializer.toJson<String>(taskName),
      'clientName': serializer.toJson<String>(clientName),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime?>(endAt),
    };
  }

  TimeEntry copyWith({
    int? id,
    String? taskName,
    String? clientName,
    DateTime? startAt,
    Value<DateTime?> endAt = const Value.absent(),
  }) => TimeEntry(
    id: id ?? this.id,
    taskName: taskName ?? this.taskName,
    clientName: clientName ?? this.clientName,
    startAt: startAt ?? this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
  );
  TimeEntry copyWithCompanion(TimeEntriesCompanion data) {
    return TimeEntry(
      id: data.id.present ? data.id.value : this.id,
      taskName: data.taskName.present ? data.taskName.value : this.taskName,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntry(')
          ..write('id: $id, ')
          ..write('taskName: $taskName, ')
          ..write('clientName: $clientName, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskName, clientName, startAt, endAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeEntry &&
          other.id == this.id &&
          other.taskName == this.taskName &&
          other.clientName == this.clientName &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt);
}

class TimeEntriesCompanion extends UpdateCompanion<TimeEntry> {
  final Value<int> id;
  final Value<String> taskName;
  final Value<String> clientName;
  final Value<DateTime> startAt;
  final Value<DateTime?> endAt;
  const TimeEntriesCompanion({
    this.id = const Value.absent(),
    this.taskName = const Value.absent(),
    this.clientName = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
  });
  TimeEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String taskName,
    this.clientName = const Value.absent(),
    required DateTime startAt,
    this.endAt = const Value.absent(),
  }) : taskName = Value(taskName),
       startAt = Value(startAt);
  static Insertable<TimeEntry> custom({
    Expression<int>? id,
    Expression<String>? taskName,
    Expression<String>? clientName,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskName != null) 'task_name': taskName,
      if (clientName != null) 'client_name': clientName,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
    });
  }

  TimeEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? taskName,
    Value<String>? clientName,
    Value<DateTime>? startAt,
    Value<DateTime?>? endAt,
  }) {
    return TimeEntriesCompanion(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      clientName: clientName ?? this.clientName,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskName.present) {
      map['task_name'] = Variable<String>(taskName.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('taskName: $taskName, ')
          ..write('clientName: $clientName, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TimeEntriesTable timeEntries = $TimeEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [timeEntries];
}

typedef $$TimeEntriesTableCreateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<int> id,
      required String taskName,
      Value<String> clientName,
      required DateTime startAt,
      Value<DateTime?> endAt,
    });
typedef $$TimeEntriesTableUpdateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<int> id,
      Value<String> taskName,
      Value<String> clientName,
      Value<DateTime> startAt,
      Value<DateTime?> endAt,
    });

class $$TimeEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskName => $composableBuilder(
    column: $table.taskName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimeEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskName => $composableBuilder(
    column: $table.taskName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimeEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskName =>
      $composableBuilder(column: $table.taskName, builder: (column) => column);

  GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);
}

class $$TimeEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeEntriesTable,
          TimeEntry,
          $$TimeEntriesTableFilterComposer,
          $$TimeEntriesTableOrderingComposer,
          $$TimeEntriesTableAnnotationComposer,
          $$TimeEntriesTableCreateCompanionBuilder,
          $$TimeEntriesTableUpdateCompanionBuilder,
          (
            TimeEntry,
            BaseReferences<_$AppDatabase, $TimeEntriesTable, TimeEntry>,
          ),
          TimeEntry,
          PrefetchHooks Function()
        > {
  $$TimeEntriesTableTableManager(_$AppDatabase db, $TimeEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> taskName = const Value.absent(),
                Value<String> clientName = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime?> endAt = const Value.absent(),
              }) => TimeEntriesCompanion(
                id: id,
                taskName: taskName,
                clientName: clientName,
                startAt: startAt,
                endAt: endAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String taskName,
                Value<String> clientName = const Value.absent(),
                required DateTime startAt,
                Value<DateTime?> endAt = const Value.absent(),
              }) => TimeEntriesCompanion.insert(
                id: id,
                taskName: taskName,
                clientName: clientName,
                startAt: startAt,
                endAt: endAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimeEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeEntriesTable,
      TimeEntry,
      $$TimeEntriesTableFilterComposer,
      $$TimeEntriesTableOrderingComposer,
      $$TimeEntriesTableAnnotationComposer,
      $$TimeEntriesTableCreateCompanionBuilder,
      $$TimeEntriesTableUpdateCompanionBuilder,
      (TimeEntry, BaseReferences<_$AppDatabase, $TimeEntriesTable, TimeEntry>),
      TimeEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TimeEntriesTableTableManager get timeEntries =>
      $$TimeEntriesTableTableManager(_db, _db.timeEntries);
}
