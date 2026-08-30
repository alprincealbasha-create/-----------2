import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/integrity/data/integrity_providers.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_models.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_repository.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';

final integrityProvider =
    AsyncNotifierProvider<IntegrityController, List<IntegrityFlag>>(
      IntegrityController.new,
    );

class IntegrityController extends AsyncNotifier<List<IntegrityFlag>> {
  IntegrityRepository get _repository => ref.read(integrityRepositoryProvider);

  @override
  Future<List<IntegrityFlag>> build() async {
    final branchId = _branchId(watch: true);
    return branchId == null ? const [] : _repository.listFlags(branchId);
  }

  Future<void> refresh() async {
    final branchId = _branchId();
    if (branchId == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.listFlags(branchId));
  }

  Future<void> review({
    required String flagId,
    required IntegrityFlagStatus status,
  }) async {
    await _repository.reviewFlag(flagId: flagId, status: status);
    await refresh();
  }

  String? _branchId({bool watch = false}) {
    final management = watch
        ? ref.watch(organizationManagementProvider)
        : ref.read(organizationManagementProvider);
    return switch (management) {
      AsyncData(:final value) => value.selectedBranchId,
      _ => null,
    };
  }
}
