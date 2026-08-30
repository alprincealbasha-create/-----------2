import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';
import 'package:ward_al_rawdah/features/wird_programs/data/wird_programs_providers.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_program_models.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_programs_repository.dart';

final wirdProgramsProvider =
    AsyncNotifierProvider<WirdProgramsController, WirdProgramCreationState>(
      WirdProgramsController.new,
    );

class WirdProgramsController extends AsyncNotifier<WirdProgramCreationState> {
  WirdProgramsRepository get _repository =>
      ref.read(wirdProgramsRepositoryProvider);

  @override
  Future<WirdProgramCreationState> build() async {
    final organizationId = _organizationId(watch: true);
    return organizationId == null
        ? const WirdProgramCreationState()
        : _repository.load(organizationId);
  }

  Future<void> refresh() async {
    final organizationId = _organizationId();
    if (organizationId == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.load(organizationId));
  }

  Future<void> create(WirdProgramRequest request) async {
    final organizationId = _organizationId();
    if (organizationId == null) {
      throw const WirdProgramFailure('اختر مؤسسة أولًا.');
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final assignedCount = await _repository.create(
        organizationId: organizationId,
        request: request,
      );
      final loaded = await _repository.load(organizationId);
      return loaded.copyWith(lastAssignedCount: assignedCount);
    });
  }

  String? _organizationId({bool watch = false}) {
    final management = watch
        ? ref.watch(organizationManagementProvider)
        : ref.read(organizationManagementProvider);
    return switch (management) {
      AsyncData(:final value) => value.selectedOrganizationId,
      _ => null,
    };
  }
}
