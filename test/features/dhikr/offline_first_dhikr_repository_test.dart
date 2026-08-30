import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/data/local/app_database.dart';
import 'package:ward_al_rawdah/features/dhikr/data/dhikr_sync_gateway.dart';
import 'package:ward_al_rawdah/features/dhikr/data/offline_first_dhikr_repository.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';

void main() {
  late AppDatabase database;
  late FakeDhikrSyncGateway gateway;
  late _IdSequence ids;
  late OfflineFirstDhikrRepository repository;
  final now = DateTime.utc(2026, 8, 25, 12);

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    gateway = FakeDhikrSyncGateway();
    ids = _IdSequence();
    repository = OfflineFirstDhikrRepository(
      database,
      gateway,
      now: () => now,
      nextId: ids.next,
    );
  });

  tearDown(() => database.close());

  test('persists a private counter locally', () async {
    await repository.createCounter(
      userId: 'user-1',
      title: 'ذكر خاص',
      target: 5,
    );
    await repository.increment(userId: 'user-1', sessionId: ids.firstId);

    final reloadedRepository = OfflineFirstDhikrRepository(
      database,
      gateway,
      now: () => now,
      nextId: ids.next,
    );
    final counter = await reloadedRepository.loadCurrent('user-1');

    expect(counter?.count, 1);
    expect(counter?.pendingSyncCount, 1);
    expect(counter?.syncState, DhikrSyncState.pending);
  });

  test(
    'required scenario: 20 online plus 30 offline restores 50 and syncs 50',
    () async {
      await database.close();
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      addTearDown(() {
        driftRuntimeOptions.dontWarnAboutMultipleDatabases = false;
      });
      final directory = await Directory.systemTemp.createTemp(
        'ward_offline_restart_',
      );
      addTearDown(() => directory.delete(recursive: true));
      final file = File(
        '${directory.path}${Platform.pathSeparator}ward.sqlite',
      );
      final persistentGateway = FakeDhikrSyncGateway();
      final persistentIds = _IdSequence();

      final firstDatabase = AppDatabase.forTesting(NativeDatabase(file));
      final firstRepository = OfflineFirstDhikrRepository(
        firstDatabase,
        persistentGateway,
        now: () => now,
        nextId: persistentIds.next,
      );
      final created = await firstRepository.createCounter(
        userId: 'user-1',
        title: 'عداد محفوظ',
        target: 100,
      );
      for (var tap = 0; tap < 20; tap += 1) {
        await firstRepository.increment(
          userId: 'user-1',
          sessionId: created.id,
        );
      }
      final initialSync = await firstRepository.syncPending('user-1');
      expect(initialSync?.count, 20);
      expect(initialSync?.target, 100);
      expect(initialSync?.pendingSyncCount, 0);
      expect(persistentGateway.remoteCount, 20);

      persistentGateway.isOffline = true;
      for (var tap = 0; tap < 30; tap += 1) {
        await firstRepository.increment(
          userId: 'user-1',
          sessionId: created.id,
        );
      }
      final offline = await firstRepository.syncPending('user-1');
      expect(offline?.count, 50);
      expect(offline?.target, 100);
      expect(offline?.pendingSyncCount, 30);
      expect(persistentGateway.remoteCount, 20);
      await firstDatabase.close();

      final restartedDatabase = AppDatabase.forTesting(NativeDatabase(file));
      final restartedRepository = OfflineFirstDhikrRepository(
        restartedDatabase,
        persistentGateway,
        now: () => now,
        nextId: persistentIds.next,
      );
      final restored = await restartedRepository.loadCurrent('user-1');
      expect(restored?.count, 50);
      expect(restored?.target, 100);
      expect(restored?.pendingSyncCount, 30);
      expect(restored?.syncState, DhikrSyncState.pending);

      persistentGateway.isOffline = false;
      final synced = await restartedRepository.syncPending('user-1');
      expect(synced?.count, 50);
      expect(synced?.target, 100);
      expect(synced?.pendingSyncCount, 0);
      expect(persistentGateway.remoteCount, 50);
      await restartedDatabase.close();

      final secondRestartDatabase = AppDatabase.forTesting(
        NativeDatabase(file),
      );
      final secondRestartRepository = OfflineFirstDhikrRepository(
        secondRestartDatabase,
        persistentGateway,
        now: () => now,
        nextId: persistentIds.next,
      );
      final finalState = await secondRestartRepository.loadCurrent('user-1');
      expect(finalState?.count, 50);
      expect(finalState?.target, 100);
      expect(finalState?.pendingSyncCount, 0);
      expect(persistentGateway.remoteCount, 50);
      await secondRestartDatabase.close();
    },
  );

  test('completes at the target and never exceeds it', () async {
    final counter = await repository.createCounter(
      userId: 'user-1',
      title: 'ذكر خاص',
      target: 2,
    );

    await repository.increment(userId: 'user-1', sessionId: counter.id);
    await repository.increment(userId: 'user-1', sessionId: counter.id);
    final completed = await repository.increment(
      userId: 'user-1',
      sessionId: counter.id,
    );

    expect(completed.count, 2);
    expect(completed.completionState, DhikrCompletionState.completed);
    expect(completed.completedAt?.toUtc(), now);
    expect(completed.pendingSyncCount, 2);
  });

  test(
    'retries the same operation without a duplicate remote increment',
    () async {
      final counter = await repository.createCounter(
        userId: 'user-1',
        title: 'ذكر خاص',
        target: 3,
      );
      await repository.increment(userId: 'user-1', sessionId: counter.id);
      gateway.failAfterApplyingOnce = true;

      final failed = await repository.syncPending('user-1');
      expect(failed?.syncState, DhikrSyncState.failed);
      expect(failed?.pendingSyncCount, 1);

      final synced = await repository.syncPending('user-1');
      expect(synced?.syncState, DhikrSyncState.synced);
      expect(synced?.pendingSyncCount, 0);
      expect(gateway.remoteCount, 1);
      expect(gateway.calls, 2);
    },
  );

  test('keeps local counters isolated by account', () async {
    final first = await repository.createCounter(
      userId: 'user-1',
      title: 'عداد أول',
      target: 2,
    );
    await repository.createCounter(
      userId: 'user-2',
      title: 'عداد ثان',
      target: 4,
    );

    expect((await repository.loadCurrent('user-1'))?.title, 'عداد أول');
    expect((await repository.loadCurrent('user-2'))?.title, 'عداد ثان');
    expect(
      () => repository.increment(userId: 'user-2', sessionId: first.id),
      throwsA(anything),
    );
  });

  test('keeps the managed wird link through local storage and sync', () async {
    final counter = await repository.createCounter(
      userId: 'user-1',
      title: 'سبحان الله',
      target: 2,
      managedWirdId: '10000000-0000-4000-8000-000000000001',
    );
    await repository.increment(userId: 'user-1', sessionId: counter.id);
    await repository.syncPending('user-1');

    final reloaded = await repository.loadCurrent('user-1');
    expect(reloaded?.managedWirdId, '10000000-0000-4000-8000-000000000001');
    expect(gateway.lastManagedWirdId, reloaded?.managedWirdId);
  });

  test('rejects invalid title and target', () async {
    expect(
      () => repository.createCounter(userId: 'user-1', title: ' ', target: 1),
      throwsA(anything),
    );
    expect(
      () => repository.createCounter(
        userId: 'user-1',
        title: 'ذكر خاص',
        target: 0,
      ),
      throwsA(anything),
    );
  });
}

class FakeDhikrSyncGateway implements DhikrSyncGateway {
  final Set<String> _appliedOperations = {};
  bool failAfterApplyingOnce = false;
  int remoteCount = 0;
  int calls = 0;
  String? lastManagedWirdId;
  bool isOffline = false;

  @override
  Future<void> applyIncrement({
    required String operationId,
    required String sessionId,
    String? managedWirdId,
    required String title,
    required int target,
    required int delta,
    required DateTime createdAt,
  }) async {
    calls += 1;
    lastManagedWirdId = managedWirdId;
    if (isOffline) throw Exception('offline');
    if (_appliedOperations.add(operationId)) remoteCount += delta;
    if (failAfterApplyingOnce) {
      failAfterApplyingOnce = false;
      throw Exception('response lost after remote commit');
    }
  }
}

class _IdSequence {
  var _value = 0;
  late final String firstId;

  String next() {
    _value += 1;
    final id = '00000000-0000-4000-8000-${_value.toString().padLeft(12, '0')}';
    if (_value == 1) firstId = id;
    return id;
  }
}
