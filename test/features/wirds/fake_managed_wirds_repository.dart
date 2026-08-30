import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wirds_repository.dart';

class FakeManagedWirdsRepository implements ManagedWirdsRepository {
  FakeManagedWirdsRepository({required this.userBranches});

  final Map<String, String> userBranches;
  final Map<String, ManagedWird> wirds = {};
  var _nextId = 1;

  @override
  Future<List<ManagedWird>> listWirds(String branchId) async => wirds.values
      .where((wird) => wird.branchId == branchId)
      .toList(growable: false);

  @override
  Future<ManagedWird> createWird({
    required String branchId,
    required String title,
    required int targetCount,
    String? details,
  }) async {
    final wird = ManagedWird(
      id: 'wird-${_nextId++}',
      branchId: branchId,
      title: _title(title),
      targetCount: _target(targetCount),
      details: details,
      status: ManagedWirdStatus.draft,
    );
    wirds[wird.id] = wird;
    return wird;
  }

  @override
  Future<ManagedWird> updateWird(ManagedWird wird) async {
    final current = _require(wird.id);
    if (current.status == ManagedWirdStatus.completed) {
      throw const WirdManagementFailure('لا يمكن تعديل ورد منتهٍ.');
    }
    final updated = current.copyWith(
      title: _title(wird.title),
      details: wird.details,
      targetCount: _target(wird.targetCount),
    );
    wirds[wird.id] = updated;
    return updated;
  }

  @override
  Future<ManagedWird> assignWird({
    required ManagedWird wird,
    required String userId,
  }) async {
    final current = _require(wird.id);
    if (current.status == ManagedWirdStatus.completed) {
      throw const WirdManagementFailure('لا يمكن تكليف ورد منتهٍ.');
    }
    if (userBranches[userId] != current.branchId) {
      throw const WirdManagementFailure('المستخدم ليس في الفرع نفسه.');
    }
    final updated = current.copyWith(
      assignedUserId: userId,
      status: ManagedWirdStatus.assigned,
      assignedAt: DateTime.utc(2026, 8, 25),
    );
    wirds[wird.id] = updated;
    return updated;
  }

  @override
  Future<ManagedWird> completeWird(ManagedWird wird) async {
    final current = _require(wird.id);
    if (current.status != ManagedWirdStatus.assigned) {
      throw const WirdManagementFailure('يجب تكليف الورد قبل إنهائه.');
    }
    final updated = current.copyWith(
      status: ManagedWirdStatus.completed,
      completedAt: DateTime.utc(2026, 8, 26),
    );
    wirds[wird.id] = updated;
    return updated;
  }

  ManagedWird _require(String id) {
    final wird = wirds[id];
    if (wird == null) {
      throw const WirdManagementFailure('الورد غير موجود.');
    }
    return wird;
  }

  String _title(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw const WirdManagementFailure('عنوان الورد مطلوب.');
    }
    return normalized;
  }

  int _target(int? value) {
    if (value == null || value < 1 || value > 100000) {
      throw const WirdManagementFailure('الهدف غير صالح.');
    }
    return value;
  }
}
