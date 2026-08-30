import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class DhikrSessions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get managedWirdId => text().nullable()();
  TextColumn get title => text().withLength(min: 1, max: 160)();
  IntColumn get target =>
      integer().customConstraint('NOT NULL CHECK (target > 0)')();
  IntColumn get count =>
      integer().customConstraint('NOT NULL DEFAULT 0 CHECK (count >= 0)')();
  TextColumn get status => text().withDefault(const Constant('in_progress'))();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DhikrMutations extends Table {
  TextColumn get operationId => text()();
  TextColumn get userId => text()();
  TextColumn get sessionId => text()();
  IntColumn get delta => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {operationId};
}

@DriftDatabase(tables: [DhikrSessions, DhikrMutations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'ward_al_rawdah'));

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(dhikrSessions, dhikrSessions.managedWirdId);
      }
    },
  );

  Future<DhikrSession?> latestSession(String userId) {
    final query = select(dhikrSessions)
      ..where((row) => row.userId.equals(userId))
      ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)])
      ..limit(1);
    return query.getSingleOrNull();
  }

  Future<int> pendingMutationCount(String userId) async {
    final countExpression = dhikrMutations.operationId.count();
    final query = selectOnly(dhikrMutations)
      ..addColumns([countExpression])
      ..where(
        dhikrMutations.userId.equals(userId) & dhikrMutations.syncedAt.isNull(),
      );
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Future<void> createDhikrSession({
    required String id,
    required String userId,
    String? managedWirdId,
    required String title,
    required int target,
    required DateTime now,
  }) {
    return into(dhikrSessions).insert(
      DhikrSessionsCompanion.insert(
        id: id,
        userId: userId,
        managedWirdId: Value(managedWirdId),
        title: title,
        target: target,
        updatedAt: now,
      ),
    );
  }

  Future<void> incrementDhikr({
    required String userId,
    required String sessionId,
    required String operationId,
    required DateTime now,
  }) => transaction(() async {
    final session =
        await (select(dhikrSessions)..where(
              (row) => row.id.equals(sessionId) & row.userId.equals(userId),
            ))
            .getSingle();
    if (session.count >= session.target) return;

    final nextCount = session.count + 1;
    final completed = nextCount >= session.target;
    await (update(
          dhikrSessions,
        )..where((row) => row.id.equals(sessionId) & row.userId.equals(userId)))
        .write(
          DhikrSessionsCompanion(
            count: Value(nextCount),
            status: Value(completed ? 'completed' : 'in_progress'),
            updatedAt: Value(now),
            completedAt: Value(completed ? now : null),
          ),
        );
    await into(dhikrMutations).insert(
      DhikrMutationsCompanion.insert(
        operationId: operationId,
        userId: session.userId,
        sessionId: sessionId,
        createdAt: now,
      ),
    );
  });

  Future<List<DhikrMutation>> pendingMutations(String userId) {
    final query = select(dhikrMutations)
      ..where((row) => row.userId.equals(userId) & row.syncedAt.isNull())
      ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]);
    return query.get();
  }

  Future<DhikrSession> sessionById(String sessionId) {
    return (select(
      dhikrSessions,
    )..where((row) => row.id.equals(sessionId))).getSingle();
  }

  Future<void> markMutationSynced(String operationId, DateTime now) {
    return (update(dhikrMutations)
          ..where((row) => row.operationId.equals(operationId)))
        .write(DhikrMutationsCompanion(syncedAt: Value(now)));
  }

  Future<void> recordMutationFailure(String operationId) async {
    final mutation = await (select(
      dhikrMutations,
    )..where((row) => row.operationId.equals(operationId))).getSingle();
    await (update(
      dhikrMutations,
    )..where((row) => row.operationId.equals(operationId))).write(
      DhikrMutationsCompanion(attemptCount: Value(mutation.attemptCount + 1)),
    );
  }
}
