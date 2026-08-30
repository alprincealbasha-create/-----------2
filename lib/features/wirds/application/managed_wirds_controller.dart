import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';
import 'package:ward_al_rawdah/features/wirds/data/managed_wirds_providers.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wirds_repository.dart';

final managedWirdsProvider =
    AsyncNotifierProvider<ManagedWirdsController, List<ManagedWird>>(
      ManagedWirdsController.new,
    );

class ManagedWirdsController extends AsyncNotifier<List<ManagedWird>> {
  ManagedWirdsRepository get _repository =>
      ref.read(managedWirdsRepositoryProvider);

  @override
  Future<List<ManagedWird>> build() async {
    final management = ref.watch(organizationManagementProvider);
    final branchId = switch (management) {
      AsyncData(:final value) => value.selectedBranchId,
      _ => null,
    };
    return branchId == null ? const [] : _repository.listWirds(branchId);
  }

  Future<void> refresh() => _replaceWith(_repository.listWirds(_branchId));

  Future<void> createWird({
    required String title,
    required int targetCount,
    String? details,
  }) => _replaceWith(() async {
    final branchId = _branchId;
    await _repository.createWird(
      branchId: branchId,
      title: title,
      targetCount: targetCount,
      details: details,
    );
    return _repository.listWirds(branchId);
  }());

  Future<void> updateWird(ManagedWird wird) => _replaceWith(() async {
    await _repository.updateWird(wird);
    return _repository.listWirds(wird.branchId);
  }());

  Future<void> assignWird(ManagedWird wird, String userId) =>
      _replaceWith(() async {
        await _repository.assignWird(wird: wird, userId: userId);
        return _repository.listWirds(wird.branchId);
      }());

  Future<void> completeWird(ManagedWird wird) => _replaceWith(() async {
    await _repository.completeWird(wird);
    return _repository.listWirds(wird.branchId);
  }());

  String get _branchId {
    final management = ref.read(organizationManagementProvider);
    final branchId = switch (management) {
      AsyncData(:final value) => value.selectedBranchId,
      _ => null,
    };
    if (branchId == null) {
      throw const WirdManagementFailure('اختر فرعًا أولًا.');
    }
    return branchId;
  }

  Future<void> _replaceWith(Future<List<ManagedWird>> operation) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => operation);
  }
}
