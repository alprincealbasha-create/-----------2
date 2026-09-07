import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/data/local/app_database.dart';

void main() {
  test('logout cleanup removes only fully synchronized user data', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    final now = DateTime.utc(2026, 9, 6);
    await database.createDhikrSession(
      id: 'session-1',
      userId: 'student-1',
      title: 'test',
      target: 2,
      now: now,
    );
    await database.incrementDhikr(
      userId: 'student-1',
      sessionId: 'session-1',
      operationId: 'operation-1',
      now: now,
    );
    await database.markMutationSynced('operation-1', now);

    await database.clearSyncedUserData('student-1');

    expect(await database.latestSession('student-1'), isNull);
    expect(await database.pendingMutations('student-1'), isEmpty);
  });

  test('logout cleanup never discards pending progress', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    final now = DateTime.utc(2026, 9, 6);
    await database.createDhikrSession(
      id: 'session-1',
      userId: 'student-1',
      title: 'test',
      target: 2,
      now: now,
    );
    await database.incrementDhikr(
      userId: 'student-1',
      sessionId: 'session-1',
      operationId: 'operation-1',
      now: now,
    );

    await expectLater(
      database.clearSyncedUserData('student-1'),
      throwsStateError,
    );
    expect(await database.latestSession('student-1'), isNotNull);
    expect(await database.pendingMutationCount('student-1'), 1);
  });
}
