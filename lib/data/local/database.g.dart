// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _societeMeta = const VerificationMeta(
    'societe',
  );
  @override
  late final GeneratedColumn<String> societe = GeneratedColumn<String>(
    'societe',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomContactMeta = const VerificationMeta(
    'nomContact',
  );
  @override
  late final GeneratedColumn<String> nomContact = GeneratedColumn<String>(
    'nom_contact',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telephoneMeta = const VerificationMeta(
    'telephone',
  );
  @override
  late final GeneratedColumn<String> telephone = GeneratedColumn<String>(
    'telephone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tarifHtMeta = const VerificationMeta(
    'tarifHt',
  );
  @override
  late final GeneratedColumn<double> tarifHt = GeneratedColumn<double>(
    'tarif_ht',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _colorTokenMeta = const VerificationMeta(
    'colorToken',
  );
  @override
  late final GeneratedColumn<String> colorToken = GeneratedColumn<String>(
    'color_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('blue-500'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    societe,
    nomContact,
    email,
    telephone,
    notes,
    tarifHt,
    colorToken,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('societe')) {
      context.handle(
        _societeMeta,
        societe.isAcceptableOrUnknown(data['societe']!, _societeMeta),
      );
    } else if (isInserting) {
      context.missing(_societeMeta);
    }
    if (data.containsKey('nom_contact')) {
      context.handle(
        _nomContactMeta,
        nomContact.isAcceptableOrUnknown(data['nom_contact']!, _nomContactMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('telephone')) {
      context.handle(
        _telephoneMeta,
        telephone.isAcceptableOrUnknown(data['telephone']!, _telephoneMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('tarif_ht')) {
      context.handle(
        _tarifHtMeta,
        tarifHt.isAcceptableOrUnknown(data['tarif_ht']!, _tarifHtMeta),
      );
    }
    if (data.containsKey('color_token')) {
      context.handle(
        _colorTokenMeta,
        colorToken.isAcceptableOrUnknown(data['color_token']!, _colorTokenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      societe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}societe'],
      )!,
      nomContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom_contact'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      telephone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telephone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      tarifHt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tarif_ht'],
      )!,
      colorToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_token'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String societe;
  final String? nomContact;
  final String? email;
  final String? telephone;
  final String? notes;
  final double tarifHt;
  final String colorToken;
  const Client({
    required this.id,
    required this.societe,
    this.nomContact,
    this.email,
    this.telephone,
    this.notes,
    required this.tarifHt,
    required this.colorToken,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['societe'] = Variable<String>(societe);
    if (!nullToAbsent || nomContact != null) {
      map['nom_contact'] = Variable<String>(nomContact);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || telephone != null) {
      map['telephone'] = Variable<String>(telephone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['tarif_ht'] = Variable<double>(tarifHt);
    map['color_token'] = Variable<String>(colorToken);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      societe: Value(societe),
      nomContact: nomContact == null && nullToAbsent
          ? const Value.absent()
          : Value(nomContact),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      telephone: telephone == null && nullToAbsent
          ? const Value.absent()
          : Value(telephone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      tarifHt: Value(tarifHt),
      colorToken: Value(colorToken),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      societe: serializer.fromJson<String>(json['societe']),
      nomContact: serializer.fromJson<String?>(json['nomContact']),
      email: serializer.fromJson<String?>(json['email']),
      telephone: serializer.fromJson<String?>(json['telephone']),
      notes: serializer.fromJson<String?>(json['notes']),
      tarifHt: serializer.fromJson<double>(json['tarifHt']),
      colorToken: serializer.fromJson<String>(json['colorToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'societe': serializer.toJson<String>(societe),
      'nomContact': serializer.toJson<String?>(nomContact),
      'email': serializer.toJson<String?>(email),
      'telephone': serializer.toJson<String?>(telephone),
      'notes': serializer.toJson<String?>(notes),
      'tarifHt': serializer.toJson<double>(tarifHt),
      'colorToken': serializer.toJson<String>(colorToken),
    };
  }

  Client copyWith({
    int? id,
    String? societe,
    Value<String?> nomContact = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> telephone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    double? tarifHt,
    String? colorToken,
  }) => Client(
    id: id ?? this.id,
    societe: societe ?? this.societe,
    nomContact: nomContact.present ? nomContact.value : this.nomContact,
    email: email.present ? email.value : this.email,
    telephone: telephone.present ? telephone.value : this.telephone,
    notes: notes.present ? notes.value : this.notes,
    tarifHt: tarifHt ?? this.tarifHt,
    colorToken: colorToken ?? this.colorToken,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      societe: data.societe.present ? data.societe.value : this.societe,
      nomContact: data.nomContact.present
          ? data.nomContact.value
          : this.nomContact,
      email: data.email.present ? data.email.value : this.email,
      telephone: data.telephone.present ? data.telephone.value : this.telephone,
      notes: data.notes.present ? data.notes.value : this.notes,
      tarifHt: data.tarifHt.present ? data.tarifHt.value : this.tarifHt,
      colorToken: data.colorToken.present
          ? data.colorToken.value
          : this.colorToken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('societe: $societe, ')
          ..write('nomContact: $nomContact, ')
          ..write('email: $email, ')
          ..write('telephone: $telephone, ')
          ..write('notes: $notes, ')
          ..write('tarifHt: $tarifHt, ')
          ..write('colorToken: $colorToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    societe,
    nomContact,
    email,
    telephone,
    notes,
    tarifHt,
    colorToken,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.societe == this.societe &&
          other.nomContact == this.nomContact &&
          other.email == this.email &&
          other.telephone == this.telephone &&
          other.notes == this.notes &&
          other.tarifHt == this.tarifHt &&
          other.colorToken == this.colorToken);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> societe;
  final Value<String?> nomContact;
  final Value<String?> email;
  final Value<String?> telephone;
  final Value<String?> notes;
  final Value<double> tarifHt;
  final Value<String> colorToken;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.societe = const Value.absent(),
    this.nomContact = const Value.absent(),
    this.email = const Value.absent(),
    this.telephone = const Value.absent(),
    this.notes = const Value.absent(),
    this.tarifHt = const Value.absent(),
    this.colorToken = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String societe,
    this.nomContact = const Value.absent(),
    this.email = const Value.absent(),
    this.telephone = const Value.absent(),
    this.notes = const Value.absent(),
    this.tarifHt = const Value.absent(),
    this.colorToken = const Value.absent(),
  }) : societe = Value(societe);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? societe,
    Expression<String>? nomContact,
    Expression<String>? email,
    Expression<String>? telephone,
    Expression<String>? notes,
    Expression<double>? tarifHt,
    Expression<String>? colorToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (societe != null) 'societe': societe,
      if (nomContact != null) 'nom_contact': nomContact,
      if (email != null) 'email': email,
      if (telephone != null) 'telephone': telephone,
      if (notes != null) 'notes': notes,
      if (tarifHt != null) 'tarif_ht': tarifHt,
      if (colorToken != null) 'color_token': colorToken,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<String>? societe,
    Value<String?>? nomContact,
    Value<String?>? email,
    Value<String?>? telephone,
    Value<String?>? notes,
    Value<double>? tarifHt,
    Value<String>? colorToken,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      societe: societe ?? this.societe,
      nomContact: nomContact ?? this.nomContact,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      notes: notes ?? this.notes,
      tarifHt: tarifHt ?? this.tarifHt,
      colorToken: colorToken ?? this.colorToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (societe.present) {
      map['societe'] = Variable<String>(societe.value);
    }
    if (nomContact.present) {
      map['nom_contact'] = Variable<String>(nomContact.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (telephone.present) {
      map['telephone'] = Variable<String>(telephone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (tarifHt.present) {
      map['tarif_ht'] = Variable<double>(tarifHt.value);
    }
    if (colorToken.present) {
      map['color_token'] = Variable<String>(colorToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('societe: $societe, ')
          ..write('nomContact: $nomContact, ')
          ..write('email: $email, ')
          ..write('telephone: $telephone, ')
          ..write('notes: $notes, ')
          ..write('tarifHt: $tarifHt, ')
          ..write('colorToken: $colorToken')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id) ON DELETE CASCADE',
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('—'),
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
  static const VerificationMeta _autoStartMeta = const VerificationMeta(
    'autoStart',
  );
  @override
  late final GeneratedColumn<bool> autoStart = GeneratedColumn<bool>(
    'auto_start',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_start" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _autoStopMeta = const VerificationMeta(
    'autoStop',
  );
  @override
  late final GeneratedColumn<bool> autoStop = GeneratedColumn<bool>(
    'auto_stop',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_stop" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _alerteMinutesMeta = const VerificationMeta(
    'alerteMinutes',
  );
  @override
  late final GeneratedColumn<int> alerteMinutes = GeneratedColumn<int>(
    'alerte_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    taskName,
    clientName,
    startAt,
    endAt,
    autoStart,
    autoStop,
    alerteMinutes,
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
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
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
    if (data.containsKey('auto_start')) {
      context.handle(
        _autoStartMeta,
        autoStart.isAcceptableOrUnknown(data['auto_start']!, _autoStartMeta),
      );
    }
    if (data.containsKey('auto_stop')) {
      context.handle(
        _autoStopMeta,
        autoStop.isAcceptableOrUnknown(data['auto_stop']!, _autoStopMeta),
      );
    }
    if (data.containsKey('alerte_minutes')) {
      context.handle(
        _alerteMinutesMeta,
        alerteMinutes.isAcceptableOrUnknown(
          data['alerte_minutes']!,
          _alerteMinutesMeta,
        ),
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
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      ),
      taskName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_name'],
      )!,
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      ),
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      ),
      autoStart: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_start'],
      )!,
      autoStop: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_stop'],
      )!,
      alerteMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alerte_minutes'],
      )!,
    );
  }

  @override
  $TimeEntriesTable createAlias(String alias) {
    return $TimeEntriesTable(attachedDatabase, alias);
  }
}

class TimeEntry extends DataClass implements Insertable<TimeEntry> {
  final int id;
  final int? clientId;
  final String taskName;
  final String? clientName;
  final DateTime startAt;
  final DateTime? endAt;
  final bool autoStart;
  final bool autoStop;
  final int alerteMinutes;
  const TimeEntry({
    required this.id,
    this.clientId,
    required this.taskName,
    this.clientName,
    required this.startAt,
    this.endAt,
    required this.autoStart,
    required this.autoStop,
    required this.alerteMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<int>(clientId);
    }
    map['task_name'] = Variable<String>(taskName);
    if (!nullToAbsent || clientName != null) {
      map['client_name'] = Variable<String>(clientName);
    }
    map['start_at'] = Variable<DateTime>(startAt);
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<DateTime>(endAt);
    }
    map['auto_start'] = Variable<bool>(autoStart);
    map['auto_stop'] = Variable<bool>(autoStop);
    map['alerte_minutes'] = Variable<int>(alerteMinutes);
    return map;
  }

  TimeEntriesCompanion toCompanion(bool nullToAbsent) {
    return TimeEntriesCompanion(
      id: Value(id),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      taskName: Value(taskName),
      clientName: clientName == null && nullToAbsent
          ? const Value.absent()
          : Value(clientName),
      startAt: Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
      autoStart: Value(autoStart),
      autoStop: Value(autoStop),
      alerteMinutes: Value(alerteMinutes),
    );
  }

  factory TimeEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeEntry(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int?>(json['clientId']),
      taskName: serializer.fromJson<String>(json['taskName']),
      clientName: serializer.fromJson<String?>(json['clientName']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime?>(json['endAt']),
      autoStart: serializer.fromJson<bool>(json['autoStart']),
      autoStop: serializer.fromJson<bool>(json['autoStop']),
      alerteMinutes: serializer.fromJson<int>(json['alerteMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int?>(clientId),
      'taskName': serializer.toJson<String>(taskName),
      'clientName': serializer.toJson<String?>(clientName),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime?>(endAt),
      'autoStart': serializer.toJson<bool>(autoStart),
      'autoStop': serializer.toJson<bool>(autoStop),
      'alerteMinutes': serializer.toJson<int>(alerteMinutes),
    };
  }

  TimeEntry copyWith({
    int? id,
    Value<int?> clientId = const Value.absent(),
    String? taskName,
    Value<String?> clientName = const Value.absent(),
    DateTime? startAt,
    Value<DateTime?> endAt = const Value.absent(),
    bool? autoStart,
    bool? autoStop,
    int? alerteMinutes,
  }) => TimeEntry(
    id: id ?? this.id,
    clientId: clientId.present ? clientId.value : this.clientId,
    taskName: taskName ?? this.taskName,
    clientName: clientName.present ? clientName.value : this.clientName,
    startAt: startAt ?? this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
    autoStart: autoStart ?? this.autoStart,
    autoStop: autoStop ?? this.autoStop,
    alerteMinutes: alerteMinutes ?? this.alerteMinutes,
  );
  TimeEntry copyWithCompanion(TimeEntriesCompanion data) {
    return TimeEntry(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      taskName: data.taskName.present ? data.taskName.value : this.taskName,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      autoStart: data.autoStart.present ? data.autoStart.value : this.autoStart,
      autoStop: data.autoStop.present ? data.autoStop.value : this.autoStop,
      alerteMinutes: data.alerteMinutes.present
          ? data.alerteMinutes.value
          : this.alerteMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntry(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('taskName: $taskName, ')
          ..write('clientName: $clientName, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('autoStart: $autoStart, ')
          ..write('autoStop: $autoStop, ')
          ..write('alerteMinutes: $alerteMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    taskName,
    clientName,
    startAt,
    endAt,
    autoStart,
    autoStop,
    alerteMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeEntry &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.taskName == this.taskName &&
          other.clientName == this.clientName &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.autoStart == this.autoStart &&
          other.autoStop == this.autoStop &&
          other.alerteMinutes == this.alerteMinutes);
}

class TimeEntriesCompanion extends UpdateCompanion<TimeEntry> {
  final Value<int> id;
  final Value<int?> clientId;
  final Value<String> taskName;
  final Value<String?> clientName;
  final Value<DateTime> startAt;
  final Value<DateTime?> endAt;
  final Value<bool> autoStart;
  final Value<bool> autoStop;
  final Value<int> alerteMinutes;
  const TimeEntriesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.taskName = const Value.absent(),
    this.clientName = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.autoStart = const Value.absent(),
    this.autoStop = const Value.absent(),
    this.alerteMinutes = const Value.absent(),
  });
  TimeEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    required String taskName,
    this.clientName = const Value.absent(),
    required DateTime startAt,
    this.endAt = const Value.absent(),
    this.autoStart = const Value.absent(),
    this.autoStop = const Value.absent(),
    this.alerteMinutes = const Value.absent(),
  }) : taskName = Value(taskName),
       startAt = Value(startAt);
  static Insertable<TimeEntry> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? taskName,
    Expression<String>? clientName,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<bool>? autoStart,
    Expression<bool>? autoStop,
    Expression<int>? alerteMinutes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (taskName != null) 'task_name': taskName,
      if (clientName != null) 'client_name': clientName,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (autoStart != null) 'auto_start': autoStart,
      if (autoStop != null) 'auto_stop': autoStop,
      if (alerteMinutes != null) 'alerte_minutes': alerteMinutes,
    });
  }

  TimeEntriesCompanion copyWith({
    Value<int>? id,
    Value<int?>? clientId,
    Value<String>? taskName,
    Value<String?>? clientName,
    Value<DateTime>? startAt,
    Value<DateTime?>? endAt,
    Value<bool>? autoStart,
    Value<bool>? autoStop,
    Value<int>? alerteMinutes,
  }) {
    return TimeEntriesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      taskName: taskName ?? this.taskName,
      clientName: clientName ?? this.clientName,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      autoStart: autoStart ?? this.autoStart,
      autoStop: autoStop ?? this.autoStop,
      alerteMinutes: alerteMinutes ?? this.alerteMinutes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
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
    if (autoStart.present) {
      map['auto_start'] = Variable<bool>(autoStart.value);
    }
    if (autoStop.present) {
      map['auto_stop'] = Variable<bool>(autoStop.value);
    }
    if (alerteMinutes.present) {
      map['alerte_minutes'] = Variable<int>(alerteMinutes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('taskName: $taskName, ')
          ..write('clientName: $clientName, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('autoStart: $autoStart, ')
          ..write('autoStop: $autoStop, ')
          ..write('alerteMinutes: $alerteMinutes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $TimeEntriesTable timeEntries = $TimeEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [clients, timeEntries];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clients',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('time_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      required String societe,
      Value<String?> nomContact,
      Value<String?> email,
      Value<String?> telephone,
      Value<String?> notes,
      Value<double> tarifHt,
      Value<String> colorToken,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<String> societe,
      Value<String?> nomContact,
      Value<String?> email,
      Value<String?> telephone,
      Value<String?> notes,
      Value<double> tarifHt,
      Value<String> colorToken,
    });

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TimeEntriesTable, List<TimeEntry>>
  _timeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntries,
    aliasName: $_aliasNameGenerator(db.clients.id, db.timeEntries.clientId),
  );

  $$TimeEntriesTableProcessedTableManager get timeEntriesRefs {
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
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

  ColumnFilters<String> get societe => $composableBuilder(
    column: $table.societe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nomContact => $composableBuilder(
    column: $table.nomContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telephone => $composableBuilder(
    column: $table.telephone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tarifHt => $composableBuilder(
    column: $table.tarifHt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> timeEntriesRefs(
    Expression<bool> Function($$TimeEntriesTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
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

  ColumnOrderings<String> get societe => $composableBuilder(
    column: $table.societe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nomContact => $composableBuilder(
    column: $table.nomContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telephone => $composableBuilder(
    column: $table.telephone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tarifHt => $composableBuilder(
    column: $table.tarifHt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get societe =>
      $composableBuilder(column: $table.societe, builder: (column) => column);

  GeneratedColumn<String> get nomContact => $composableBuilder(
    column: $table.nomContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get telephone =>
      $composableBuilder(column: $table.telephone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get tarifHt =>
      $composableBuilder(column: $table.tarifHt, builder: (column) => column);

  GeneratedColumn<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => column,
  );

  Expression<T> timeEntriesRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({bool timeEntriesRefs})
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> societe = const Value.absent(),
                Value<String?> nomContact = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> telephone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double> tarifHt = const Value.absent(),
                Value<String> colorToken = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                societe: societe,
                nomContact: nomContact,
                email: email,
                telephone: telephone,
                notes: notes,
                tarifHt: tarifHt,
                colorToken: colorToken,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String societe,
                Value<String?> nomContact = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> telephone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double> tarifHt = const Value.absent(),
                Value<String> colorToken = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                societe: societe,
                nomContact: nomContact,
                email: email,
                telephone: telephone,
                notes: notes,
                tarifHt: tarifHt,
                colorToken: colorToken,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({timeEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (timeEntriesRefs) db.timeEntries],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (timeEntriesRefs)
                    await $_getPrefetchedData<Client, $ClientsTable, TimeEntry>(
                      currentTable: table,
                      referencedTable: $$ClientsTableReferences
                          ._timeEntriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$ClientsTableReferences(
                        db,
                        table,
                        p0,
                      ).timeEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clientId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({bool timeEntriesRefs})
    >;
typedef $$TimeEntriesTableCreateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<int> id,
      Value<int?> clientId,
      required String taskName,
      Value<String?> clientName,
      required DateTime startAt,
      Value<DateTime?> endAt,
      Value<bool> autoStart,
      Value<bool> autoStop,
      Value<int> alerteMinutes,
    });
typedef $$TimeEntriesTableUpdateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<int> id,
      Value<int?> clientId,
      Value<String> taskName,
      Value<String?> clientName,
      Value<DateTime> startAt,
      Value<DateTime?> endAt,
      Value<bool> autoStart,
      Value<bool> autoStop,
      Value<int> alerteMinutes,
    });

final class $$TimeEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $TimeEntriesTable, TimeEntry> {
  $$TimeEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias(
        $_aliasNameGenerator(db.timeEntries.clientId, db.clients.id),
      );

  $$ClientsTableProcessedTableManager? get clientId {
    final $_column = $_itemColumn<int>('client_id');
    if ($_column == null) return null;
    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

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

  ColumnFilters<bool> get autoStart => $composableBuilder(
    column: $table.autoStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoStop => $composableBuilder(
    column: $table.autoStop,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alerteMinutes => $composableBuilder(
    column: $table.alerteMinutes,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  ColumnOrderings<bool> get autoStart => $composableBuilder(
    column: $table.autoStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoStop => $composableBuilder(
    column: $table.autoStop,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alerteMinutes => $composableBuilder(
    column: $table.alerteMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  GeneratedColumn<bool> get autoStart =>
      $composableBuilder(column: $table.autoStart, builder: (column) => column);

  GeneratedColumn<bool> get autoStop =>
      $composableBuilder(column: $table.autoStop, builder: (column) => column);

  GeneratedColumn<int> get alerteMinutes => $composableBuilder(
    column: $table.alerteMinutes,
    builder: (column) => column,
  );

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
          (TimeEntry, $$TimeEntriesTableReferences),
          TimeEntry,
          PrefetchHooks Function({bool clientId})
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
                Value<int?> clientId = const Value.absent(),
                Value<String> taskName = const Value.absent(),
                Value<String?> clientName = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime?> endAt = const Value.absent(),
                Value<bool> autoStart = const Value.absent(),
                Value<bool> autoStop = const Value.absent(),
                Value<int> alerteMinutes = const Value.absent(),
              }) => TimeEntriesCompanion(
                id: id,
                clientId: clientId,
                taskName: taskName,
                clientName: clientName,
                startAt: startAt,
                endAt: endAt,
                autoStart: autoStart,
                autoStop: autoStop,
                alerteMinutes: alerteMinutes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> clientId = const Value.absent(),
                required String taskName,
                Value<String?> clientName = const Value.absent(),
                required DateTime startAt,
                Value<DateTime?> endAt = const Value.absent(),
                Value<bool> autoStart = const Value.absent(),
                Value<bool> autoStop = const Value.absent(),
                Value<int> alerteMinutes = const Value.absent(),
              }) => TimeEntriesCompanion.insert(
                id: id,
                clientId: clientId,
                taskName: taskName,
                clientName: clientName,
                startAt: startAt,
                endAt: endAt,
                autoStart: autoStart,
                autoStop: autoStop,
                alerteMinutes: alerteMinutes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimeEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$TimeEntriesTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$TimeEntriesTableReferences
                                    ._clientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
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
      (TimeEntry, $$TimeEntriesTableReferences),
      TimeEntry,
      PrefetchHooks Function({bool clientId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$TimeEntriesTableTableManager get timeEntries =>
      $$TimeEntriesTableTableManager(_db, _db.timeEntries);
}
