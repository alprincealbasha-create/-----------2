import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/wird_assignments/data/wird_assignment_providers.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_models.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_repository.dart';

final wirdManagementProvider =
    AsyncNotifierProvider<WirdManagementController, WirdManagementData>(
      WirdManagementController.new,
    );
final todayWirdsProvider =
    AsyncNotifierProvider<TodayWirdsController, List<TodayWird>>(
      TodayWirdsController.new,
    );

class WirdManagementController extends AsyncNotifier<WirdManagementData> {
  WirdAssignmentRepository get _repository =>
      ref.read(wirdAssignmentRepositoryProvider);
  String get _organizationId => switch (ref.read(authControllerProvider)) {
    AuthAuthenticated(:final user) => user.organizationId,
    _ => throw const WirdAssignmentFailure('تعذر تحديد المؤسسة الحالية.'),
  };

  @override
  Future<WirdManagementData> build() =>
      _repository.loadManagementData(_organizationId);

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repository.loadManagementData(_organizationId),
    );
  }

  Future<void> create(WirdDraft draft) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final count = await _repository.createWird(_organizationId, draft);
      final loaded = await _repository.loadManagementData(_organizationId);
      return WirdManagementData(
        wirds: loaded.wirds,
        dhikr: loaded.dhikr,
        branches: loaded.branches,
        classes: loaded.classes,
        users: loaded.users,
        lastMaterializedCount: count,
      );
    });
  }

  Future<void> saveChanges(WirdContent wird) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository.updateWird(_organizationId, wird);
      return _repository.loadManagementData(_organizationId);
    });
  }
}

class TodayWirdsController extends AsyncNotifier<List<TodayWird>> {
  WirdAssignmentRepository get _repository =>
      ref.read(wirdAssignmentRepositoryProvider);
  @override
  Future<List<TodayWird>> build() => _repository.listToday();
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository.listToday);
  }
}
