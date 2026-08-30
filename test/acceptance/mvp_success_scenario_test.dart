import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/data/local/app_database.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_daily_metrics.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_branch_metrics.dart';
import 'package:ward_al_rawdah/features/dhikr/data/dhikr_sync_gateway.dart';
import 'package:ward_al_rawdah/features/dhikr/data/offline_first_dhikr_repository.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';

void main() {
  test(
    'MVP success: setup, child completes 100 taps, both dashboards see it',
    () async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);
      final backend = _MvpAcceptanceBackend();

      final organizationId = backend.createOrganization('مؤسسة الاختبار');
      final branchId = backend.createBranch(organizationId, 'فرع دمشق');
      final classId = backend.createClass(branchId, 'تمهيدي A');
      final childId = backend.addChild(classId, 'طفل الاختبار');
      final dhikrId = backend.createApprovedDhikr('ذكر معتمد للاختبار');
      final wirdId = backend.createAndAssignWird(
        organizationId: organizationId,
        dhikrId: dhikrId,
        childId: childId,
        target: 100,
      );

      expect(backend.signInChild(childId), isTrue);

      final repository = OfflineFirstDhikrRepository(
        database,
        backend,
        now: () => DateTime.utc(2026, 8, 26, 9),
        nextId: _sequentialUuid(),
      );
      final counter = await repository.createCounter(
        userId: childId,
        title: 'ورد الاختبار',
        target: 100,
        managedWirdId: wirdId,
      );
      for (var tap = 0; tap < 100; tap += 1) {
        await repository.increment(userId: childId, sessionId: counter.id);
      }

      final localCompletion = await repository.loadCurrent(childId);
      expect(localCompletion?.count, 100);
      expect(localCompletion?.completionState, DhikrCompletionState.completed);
      expect(localCompletion?.pendingSyncCount, 100);

      final synced = await repository.syncPending(childId);
      expect(synced?.pendingSyncCount, 0);
      expect(backend.savedCount(wirdId), 100);
      expect(backend.isCompleted(wirdId), isTrue);

      final branchResult = backend.branchMetrics(branchId);
      expect(branchResult.participatingUsers, 1);
      expect(branchResult.completedUsers, 1);
      expect(branchResult.totalRecordedDhikr, 100);
      expect(branchResult.completionRate, 100);

      final centralResult = backend.centralMetrics(organizationId).single;
      expect(centralResult.branchName, 'فرع دمشق');
      expect(centralResult.participatingUsers, 1);
      expect(centralResult.completedUsers, 1);
      expect(centralResult.totalRecordedDhikr, 100);
      expect(centralResult.completionRate, 100);
    },
  );
}

class _MvpAcceptanceBackend implements DhikrSyncGateway {
  final _organizations = <String, String>{};
  final _branches = <String, ({String organizationId, String name})>{};
  final _classes = <String, String>{};
  final _children = <String, String>{};
  final _dhikrs = <String>{};
  final _wirds = <String, _RemoteWird>{};
  final _appliedOperations = <String>{};
  var _nextId = 0;

  String createOrganization(String name) {
    final id = _id();
    _organizations[id] = name;
    return id;
  }

  String createBranch(String organizationId, String name) {
    expect(_organizations, contains(organizationId));
    final id = _id();
    _branches[id] = (organizationId: organizationId, name: name);
    return id;
  }

  String createClass(String branchId, String name) {
    expect(_branches, contains(branchId));
    final id = _id();
    _classes[id] = branchId;
    return id;
  }

  String addChild(String classId, String name) {
    expect(_classes, contains(classId));
    final id = _id();
    _children[id] = classId;
    return id;
  }

  String createApprovedDhikr(String title) {
    final id = _id();
    _dhikrs.add(id);
    return id;
  }

  String createAndAssignWird({
    required String organizationId,
    required String dhikrId,
    required String childId,
    required int target,
  }) {
    expect(_organizations, contains(organizationId));
    expect(_dhikrs, contains(dhikrId));
    expect(_children, contains(childId));
    final classId = _children[childId]!;
    final branchId = _classes[classId]!;
    expect(_branches[branchId]!.organizationId, organizationId);
    final id = _id();
    _wirds[id] = _RemoteWird(
      organizationId: organizationId,
      branchId: branchId,
      childId: childId,
      target: target,
    );
    return id;
  }

  bool signInChild(String childId) => _children.containsKey(childId);

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
    final wird = _wirds[managedWirdId];
    if (wird == null) throw StateError('Unknown assignment');
    if (_appliedOperations.add(operationId)) {
      wird.count = (wird.count + delta).clamp(0, wird.target);
    }
  }

  int savedCount(String wirdId) => _wirds[wirdId]!.count;

  bool isCompleted(String wirdId) {
    final wird = _wirds[wirdId]!;
    return wird.count == wird.target;
  }

  BranchDailyMetrics branchMetrics(String branchId) {
    final wirds = _wirds.values.where(
      (item) => item.branchId == branchId && item.count > 0,
    );
    final participants = wirds.map((item) => item.childId).toSet();
    final completed = wirds
        .where((item) => item.count == item.target)
        .map((item) => item.childId)
        .toSet();
    final total = wirds.fold<int>(0, (sum, item) => sum + item.count);
    return BranchDailyMetrics(
      participatingUsers: participants.length,
      completedUsers: completed.length,
      completionRate: participants.isEmpty
          ? 0
          : completed.length * 100 / participants.length,
      totalRecordedDhikr: total,
      participatingChildren: participants.length,
    );
  }

  List<CentralBranchMetrics> centralMetrics(String organizationId) {
    return _branches.entries
        .where((entry) => entry.value.organizationId == organizationId)
        .map((entry) {
          final metrics = branchMetrics(entry.key);
          final eligible = _children.keys.where((childId) {
            final classId = _children[childId]!;
            return _classes[classId] == entry.key;
          }).length;
          return CentralBranchMetrics(
            branchId: entry.key,
            branchName: entry.value.name,
            eligibleUsers: eligible,
            participatingUsers: metrics.participatingUsers,
            completedUsers: metrics.completedUsers,
            participationRate: eligible == 0
                ? 0
                : metrics.participatingUsers * 100 / eligible,
            completionRate: metrics.completionRate,
            totalRecordedDhikr: metrics.totalRecordedDhikr,
          );
        })
        .toList(growable: false);
  }

  String _id() => 'entity-${++_nextId}';
}

class _RemoteWird {
  _RemoteWird({
    required this.organizationId,
    required this.branchId,
    required this.childId,
    required this.target,
  });

  final String organizationId;
  final String branchId;
  final String childId;
  final int target;
  int count = 0;
}

String Function() _sequentialUuid() {
  var value = 0;
  return () {
    value += 1;
    return '00000000-0000-4000-8000-${value.toString().padLeft(12, '0')}';
  };
}
