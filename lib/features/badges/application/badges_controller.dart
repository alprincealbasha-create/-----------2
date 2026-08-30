import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/badges/data/badges_providers.dart';
import 'package:ward_al_rawdah/features/badges/domain/badge_models.dart';
import 'package:ward_al_rawdah/features/badges/domain/badges_repository.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';

final badgesProvider =
    AsyncNotifierProvider<BadgesController, BadgeManagementState>(
      BadgesController.new,
    );

class BadgesController extends AsyncNotifier<BadgeManagementState> {
  BadgesRepository get _repository => ref.read(badgesRepositoryProvider);

  @override
  Future<BadgeManagementState> build() {
    return _repository.load(_branchId(watch: true));
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.load(_branchId()));
  }

  Future<void> award({
    required String badgeId,
    required String branchUserId,
  }) async {
    await _repository.awardManualBadge(
      badgeId: badgeId,
      branchUserId: branchUserId,
    );
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
