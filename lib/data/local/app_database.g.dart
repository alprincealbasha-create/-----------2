// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DhikrSessionsTable extends DhikrSessions
    with TableInfo<$DhikrSessionsTable, DhikrSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DhikrSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _managedWirdIdMeta = const VerificationMeta(
    'managedWirdId',
  );
  @override
  late final GeneratedColumn<String> managedWirdId = GeneratedColumn<String>(
    'managed_wird_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (target > 0)',
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (count >= 0)',
    defaultValue: const CustomExpression('0'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('in_progress'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    managedWirdId,
    title,
    target,
    count,
    status,
    updatedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dhikr_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DhikrSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('managed_wird_id')) {
      context.handle(
        _managedWirdIdMeta,
        managedWirdId.isAcceptableOrUnknown(
          data['managed_wird_id']!,
          _managedWirdIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DhikrSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DhikrSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      managedWirdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}managed_wird_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $DhikrSessionsTable createAlias(String alias) {
    return $DhikrSessionsTable(attachedDatabase, alias);
  }
}

class DhikrSession extends DataClass implements Insertable<DhikrSession> {
  final String id;
  final String userId;
  final String? managedWirdId;
  final String title;
  final int target;
  final int count;
  final String status;
  final DateTime updatedAt;
  final DateTime? completedAt;
  const DhikrSession({
    required this.id,
    required this.userId,
    this.managedWirdId,
    required this.title,
    required this.target,
    required this.count,
    required this.status,
    required this.updatedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || managedWirdId != null) {
      map['managed_wird_id'] = Variable<String>(managedWirdId);
    }
    map['title'] = Variable<String>(title);
    map['target'] = Variable<int>(target);
    map['count'] = Variable<int>(count);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  DhikrSessionsCompanion toCompanion(bool nullToAbsent) {
    return DhikrSessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      managedWirdId: managedWirdId == null && nullToAbsent
          ? const Value.absent()
          : Value(managedWirdId),
      title: Value(title),
      target: Value(target),
      count: Value(count),
      status: Value(status),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory DhikrSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DhikrSession(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      managedWirdId: serializer.fromJson<String?>(json['managedWirdId']),
      title: serializer.fromJson<String>(json['title']),
      target: serializer.fromJson<int>(json['target']),
      count: serializer.fromJson<int>(json['count']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'managedWirdId': serializer.toJson<String?>(managedWirdId),
      'title': serializer.toJson<String>(title),
      'target': serializer.toJson<int>(target),
      'count': serializer.toJson<int>(count),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  DhikrSession copyWith({
    String? id,
    String? userId,
    Value<String?> managedWirdId = const Value.absent(),
    String? title,
    int? target,
    int? count,
    String? status,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => DhikrSession(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    managedWirdId: managedWirdId.present
        ? managedWirdId.value
        : this.managedWirdId,
    title: title ?? this.title,
    target: target ?? this.target,
    count: count ?? this.count,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  DhikrSession copyWithCompanion(DhikrSessionsCompanion data) {
    return DhikrSession(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      managedWirdId: data.managedWirdId.present
          ? data.managedWirdId.value
          : this.managedWirdId,
      title: data.title.present ? data.title.value : this.title,
      target: data.target.present ? data.target.value : this.target,
      count: data.count.present ? data.count.value : this.count,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DhikrSession(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('managedWirdId: $managedWirdId, ')
          ..write('title: $title, ')
          ..write('target: $target, ')
          ..write('count: $count, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    managedWirdId,
    title,
    target,
    count,
    status,
    updatedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DhikrSession &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.managedWirdId == this.managedWirdId &&
          other.title == this.title &&
          other.target == this.target &&
          other.count == this.count &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class DhikrSessionsCompanion extends UpdateCompanion<DhikrSession> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> managedWirdId;
  final Value<String> title;
  final Value<int> target;
  final Value<int> count;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const DhikrSessionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.managedWirdId = const Value.absent(),
    this.title = const Value.absent(),
    this.target = const Value.absent(),
    this.count = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DhikrSessionsCompanion.insert({
    required String id,
    required String userId,
    this.managedWirdId = const Value.absent(),
    required String title,
    required int target,
    this.count = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime updatedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       title = Value(title),
       target = Value(target),
       updatedAt = Value(updatedAt);
  static Insertable<DhikrSession> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? managedWirdId,
    Expression<String>? title,
    Expression<int>? target,
    Expression<int>? count,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (managedWirdId != null) 'managed_wird_id': managedWirdId,
      if (title != null) 'title': title,
      if (target != null) 'target': target,
      if (count != null) 'count': count,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DhikrSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String?>? managedWirdId,
    Value<String>? title,
    Value<int>? target,
    Value<int>? count,
    Value<String>? status,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return DhikrSessionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      managedWirdId: managedWirdId ?? this.managedWirdId,
      title: title ?? this.title,
      target: target ?? this.target,
      count: count ?? this.count,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (managedWirdId.present) {
      map['managed_wird_id'] = Variable<String>(managedWirdId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DhikrSessionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('managedWirdId: $managedWirdId, ')
          ..write('title: $title, ')
          ..write('target: $target, ')
          ..write('count: $count, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DhikrMutationsTable extends DhikrMutations
    with TableInfo<$DhikrMutationsTable, DhikrMutation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DhikrMutationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _operationIdMeta = const VerificationMeta(
    'operationId',
  );
  @override
  late final GeneratedColumn<String> operationId = GeneratedColumn<String>(
    'operation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaMeta = const VerificationMeta('delta');
  @override
  late final GeneratedColumn<int> delta = GeneratedColumn<int>(
    'delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    operationId,
    userId,
    sessionId,
    delta,
    createdAt,
    attemptCount,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dhikr_mutations';
  @override
  VerificationContext validateIntegrity(
    Insertable<DhikrMutation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('operation_id')) {
      context.handle(
        _operationIdMeta,
        operationId.isAcceptableOrUnknown(
          data['operation_id']!,
          _operationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('delta')) {
      context.handle(
        _deltaMeta,
        delta.isAcceptableOrUnknown(data['delta']!, _deltaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {operationId};
  @override
  DhikrMutation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DhikrMutation(
      operationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      delta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delta'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $DhikrMutationsTable createAlias(String alias) {
    return $DhikrMutationsTable(attachedDatabase, alias);
  }
}

class DhikrMutation extends DataClass implements Insertable<DhikrMutation> {
  final String operationId;
  final String userId;
  final String sessionId;
  final int delta;
  final DateTime createdAt;
  final int attemptCount;
  final DateTime? syncedAt;
  const DhikrMutation({
    required this.operationId,
    required this.userId,
    required this.sessionId,
    required this.delta,
    required this.createdAt,
    required this.attemptCount,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['operation_id'] = Variable<String>(operationId);
    map['user_id'] = Variable<String>(userId);
    map['session_id'] = Variable<String>(sessionId);
    map['delta'] = Variable<int>(delta);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  DhikrMutationsCompanion toCompanion(bool nullToAbsent) {
    return DhikrMutationsCompanion(
      operationId: Value(operationId),
      userId: Value(userId),
      sessionId: Value(sessionId),
      delta: Value(delta),
      createdAt: Value(createdAt),
      attemptCount: Value(attemptCount),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory DhikrMutation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DhikrMutation(
      operationId: serializer.fromJson<String>(json['operationId']),
      userId: serializer.fromJson<String>(json['userId']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      delta: serializer.fromJson<int>(json['delta']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'operationId': serializer.toJson<String>(operationId),
      'userId': serializer.toJson<String>(userId),
      'sessionId': serializer.toJson<String>(sessionId),
      'delta': serializer.toJson<int>(delta),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  DhikrMutation copyWith({
    String? operationId,
    String? userId,
    String? sessionId,
    int? delta,
    DateTime? createdAt,
    int? attemptCount,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => DhikrMutation(
    operationId: operationId ?? this.operationId,
    userId: userId ?? this.userId,
    sessionId: sessionId ?? this.sessionId,
    delta: delta ?? this.delta,
    createdAt: createdAt ?? this.createdAt,
    attemptCount: attemptCount ?? this.attemptCount,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  DhikrMutation copyWithCompanion(DhikrMutationsCompanion data) {
    return DhikrMutation(
      operationId: data.operationId.present
          ? data.operationId.value
          : this.operationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      delta: data.delta.present ? data.delta.value : this.delta,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DhikrMutation(')
          ..write('operationId: $operationId, ')
          ..write('userId: $userId, ')
          ..write('sessionId: $sessionId, ')
          ..write('delta: $delta, ')
          ..write('createdAt: $createdAt, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    operationId,
    userId,
    sessionId,
    delta,
    createdAt,
    attemptCount,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DhikrMutation &&
          other.operationId == this.operationId &&
          other.userId == this.userId &&
          other.sessionId == this.sessionId &&
          other.delta == this.delta &&
          other.createdAt == this.createdAt &&
          other.attemptCount == this.attemptCount &&
          other.syncedAt == this.syncedAt);
}

class DhikrMutationsCompanion extends UpdateCompanion<DhikrMutation> {
  final Value<String> operationId;
  final Value<String> userId;
  final Value<String> sessionId;
  final Value<int> delta;
  final Value<DateTime> createdAt;
  final Value<int> attemptCount;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const DhikrMutationsCompanion({
    this.operationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.delta = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DhikrMutationsCompanion.insert({
    required String operationId,
    required String userId,
    required String sessionId,
    this.delta = const Value.absent(),
    required DateTime createdAt,
    this.attemptCount = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : operationId = Value(operationId),
       userId = Value(userId),
       sessionId = Value(sessionId),
       createdAt = Value(createdAt);
  static Insertable<DhikrMutation> custom({
    Expression<String>? operationId,
    Expression<String>? userId,
    Expression<String>? sessionId,
    Expression<int>? delta,
    Expression<DateTime>? createdAt,
    Expression<int>? attemptCount,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (operationId != null) 'operation_id': operationId,
      if (userId != null) 'user_id': userId,
      if (sessionId != null) 'session_id': sessionId,
      if (delta != null) 'delta': delta,
      if (createdAt != null) 'created_at': createdAt,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DhikrMutationsCompanion copyWith({
    Value<String>? operationId,
    Value<String>? userId,
    Value<String>? sessionId,
    Value<int>? delta,
    Value<DateTime>? createdAt,
    Value<int>? attemptCount,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return DhikrMutationsCompanion(
      operationId: operationId ?? this.operationId,
      userId: userId ?? this.userId,
      sessionId: sessionId ?? this.sessionId,
      delta: delta ?? this.delta,
      createdAt: createdAt ?? this.createdAt,
      attemptCount: attemptCount ?? this.attemptCount,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (operationId.present) {
      map['operation_id'] = Variable<String>(operationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (delta.present) {
      map['delta'] = Variable<int>(delta.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DhikrMutationsCompanion(')
          ..write('operationId: $operationId, ')
          ..write('userId: $userId, ')
          ..write('sessionId: $sessionId, ')
          ..write('delta: $delta, ')
          ..write('createdAt: $createdAt, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DhikrSessionsTable dhikrSessions = $DhikrSessionsTable(this);
  late final $DhikrMutationsTable dhikrMutations = $DhikrMutationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dhikrSessions,
    dhikrMutations,
  ];
}

typedef $$DhikrSessionsTableCreateCompanionBuilder =
    DhikrSessionsCompanion Function({
      required String id,
      required String userId,
      Value<String?> managedWirdId,
      required String title,
      required int target,
      Value<int> count,
      Value<String> status,
      required DateTime updatedAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$DhikrSessionsTableUpdateCompanionBuilder =
    DhikrSessionsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String?> managedWirdId,
      Value<String> title,
      Value<int> target,
      Value<int> count,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$DhikrSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $DhikrSessionsTable> {
  $$DhikrSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get managedWirdId => $composableBuilder(
    column: $table.managedWirdId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DhikrSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DhikrSessionsTable> {
  $$DhikrSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get managedWirdId => $composableBuilder(
    column: $table.managedWirdId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DhikrSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DhikrSessionsTable> {
  $$DhikrSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get managedWirdId => $composableBuilder(
    column: $table.managedWirdId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$DhikrSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DhikrSessionsTable,
          DhikrSession,
          $$DhikrSessionsTableFilterComposer,
          $$DhikrSessionsTableOrderingComposer,
          $$DhikrSessionsTableAnnotationComposer,
          $$DhikrSessionsTableCreateCompanionBuilder,
          $$DhikrSessionsTableUpdateCompanionBuilder,
          (
            DhikrSession,
            BaseReferences<_$AppDatabase, $DhikrSessionsTable, DhikrSession>,
          ),
          DhikrSession,
          PrefetchHooks Function()
        > {
  $$DhikrSessionsTableTableManager(_$AppDatabase db, $DhikrSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DhikrSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DhikrSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DhikrSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> managedWirdId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DhikrSessionsCompanion(
                id: id,
                userId: userId,
                managedWirdId: managedWirdId,
                title: title,
                target: target,
                count: count,
                status: status,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                Value<String?> managedWirdId = const Value.absent(),
                required String title,
                required int target,
                Value<int> count = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DhikrSessionsCompanion.insert(
                id: id,
                userId: userId,
                managedWirdId: managedWirdId,
                title: title,
                target: target,
                count: count,
                status: status,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DhikrSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DhikrSessionsTable,
      DhikrSession,
      $$DhikrSessionsTableFilterComposer,
      $$DhikrSessionsTableOrderingComposer,
      $$DhikrSessionsTableAnnotationComposer,
      $$DhikrSessionsTableCreateCompanionBuilder,
      $$DhikrSessionsTableUpdateCompanionBuilder,
      (
        DhikrSession,
        BaseReferences<_$AppDatabase, $DhikrSessionsTable, DhikrSession>,
      ),
      DhikrSession,
      PrefetchHooks Function()
    >;
typedef $$DhikrMutationsTableCreateCompanionBuilder =
    DhikrMutationsCompanion Function({
      required String operationId,
      required String userId,
      required String sessionId,
      Value<int> delta,
      required DateTime createdAt,
      Value<int> attemptCount,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$DhikrMutationsTableUpdateCompanionBuilder =
    DhikrMutationsCompanion Function({
      Value<String> operationId,
      Value<String> userId,
      Value<String> sessionId,
      Value<int> delta,
      Value<DateTime> createdAt,
      Value<int> attemptCount,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$DhikrMutationsTableFilterComposer
    extends Composer<_$AppDatabase, $DhikrMutationsTable> {
  $$DhikrMutationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DhikrMutationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DhikrMutationsTable> {
  $$DhikrMutationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DhikrMutationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DhikrMutationsTable> {
  $$DhikrMutationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get delta =>
      $composableBuilder(column: $table.delta, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$DhikrMutationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DhikrMutationsTable,
          DhikrMutation,
          $$DhikrMutationsTableFilterComposer,
          $$DhikrMutationsTableOrderingComposer,
          $$DhikrMutationsTableAnnotationComposer,
          $$DhikrMutationsTableCreateCompanionBuilder,
          $$DhikrMutationsTableUpdateCompanionBuilder,
          (
            DhikrMutation,
            BaseReferences<_$AppDatabase, $DhikrMutationsTable, DhikrMutation>,
          ),
          DhikrMutation,
          PrefetchHooks Function()
        > {
  $$DhikrMutationsTableTableManager(
    _$AppDatabase db,
    $DhikrMutationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DhikrMutationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DhikrMutationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DhikrMutationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> operationId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> delta = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DhikrMutationsCompanion(
                operationId: operationId,
                userId: userId,
                sessionId: sessionId,
                delta: delta,
                createdAt: createdAt,
                attemptCount: attemptCount,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String operationId,
                required String userId,
                required String sessionId,
                Value<int> delta = const Value.absent(),
                required DateTime createdAt,
                Value<int> attemptCount = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DhikrMutationsCompanion.insert(
                operationId: operationId,
                userId: userId,
                sessionId: sessionId,
                delta: delta,
                createdAt: createdAt,
                attemptCount: attemptCount,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DhikrMutationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DhikrMutationsTable,
      DhikrMutation,
      $$DhikrMutationsTableFilterComposer,
      $$DhikrMutationsTableOrderingComposer,
      $$DhikrMutationsTableAnnotationComposer,
      $$DhikrMutationsTableCreateCompanionBuilder,
      $$DhikrMutationsTableUpdateCompanionBuilder,
      (
        DhikrMutation,
        BaseReferences<_$AppDatabase, $DhikrMutationsTable, DhikrMutation>,
      ),
      DhikrMutation,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DhikrSessionsTableTableManager get dhikrSessions =>
      $$DhikrSessionsTableTableManager(_db, _db.dhikrSessions);
  $$DhikrMutationsTableTableManager get dhikrMutations =>
      $$DhikrMutationsTableTableManager(_db, _db.dhikrMutations);
}
