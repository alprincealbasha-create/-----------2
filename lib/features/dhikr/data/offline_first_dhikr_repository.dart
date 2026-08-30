import 'dart:math';

import 'package:ward_al_rawdah/data/local/app_database.dart';
import 'package:ward_al_rawdah/features/dhikr/data/dhikr_sync_gateway.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_repository.dart';

typedef Now = DateTime Function();
typedef NextId = String Function();

class OfflineFirstDhikrRepository implements DhikrRepository {
  OfflineFirstDhikrRepository(
    this._database,
    this._gateway, {
    Now? now,
    NextId? nextId,
  }) : _now = now ?? DateTime.now,
       _nextId = nextId ?? _secureId;

  final AppDatabase _database;
  final DhikrSyncGateway _gateway;
  final Now _now;
  final NextId _nextId;

  @override
  Future<DhikrCounter?> loadCurrent(String userId) => _load(userId);

  @override
  Future<DhikrCounter> createCounter({
    required String userId,
    required String title,
    required int target,
    String? managedWirdId,
  }) async {
    final normalizedTitle = title.trim();
    if (normalizedTitle.isEmpty) {
      throw const DhikrFailure('عنوان الذكر مطلوب.');
    }
    if (target <= 0 || target > 100000) {
      throw const DhikrFailure('أدخل هدفًا بين 1 و100000.');
    }
    await _database.createDhikrSession(
      id: _nextId(),
      userId: userId,
      managedWirdId: managedWirdId,
      title: normalizedTitle,
      target: target,
      now: _now(),
    );
    return (await _load(userId))!;
  }

  @override
  Future<DhikrCounter> increment({
    required String userId,
    required String sessionId,
  }) async {
    await _database.incrementDhikr(
      userId: userId,
      sessionId: sessionId,
      operationId: _nextId(),
      now: _now(),
    );
    return (await _load(userId))!;
  }

  @override
  Future<DhikrCounter?> syncPending(String userId) async {
    var failed = false;
    final mutations = await _database.pendingMutations(userId);
    for (final mutation in mutations) {
      final session = await _database.sessionById(mutation.sessionId);
      try {
        await _gateway.applyIncrement(
          operationId: mutation.operationId,
          sessionId: mutation.sessionId,
          managedWirdId: session.managedWirdId,
          title: session.title,
          target: session.target,
          delta: mutation.delta,
          createdAt: mutation.createdAt,
        );
        await _database.markMutationSynced(mutation.operationId, _now());
      } catch (_) {
        failed = true;
        await _database.recordMutationFailure(mutation.operationId);
        break;
      }
    }
    return _load(userId, syncFailed: failed);
  }

  Future<DhikrCounter?> _load(String userId, {bool syncFailed = false}) async {
    final session = await _database.latestSession(userId);
    if (session == null) return null;
    final pending = await _database.pendingMutationCount(userId);
    final syncState = syncFailed
        ? DhikrSyncState.failed
        : pending > 0
        ? DhikrSyncState.pending
        : DhikrSyncState.synced;
    return DhikrCounter(
      id: session.id,
      managedWirdId: session.managedWirdId,
      title: session.title,
      target: session.target,
      count: session.count,
      completionState: session.status == 'completed'
          ? DhikrCompletionState.completed
          : DhikrCompletionState.inProgress,
      pendingSyncCount: pending,
      syncState: syncState,
      completedAt: session.completedAt,
    );
  }

  static String _secureId() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes
        .map((value) => value.toRadixString(16).padLeft(2, '0'))
        .join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20)}';
  }
}
