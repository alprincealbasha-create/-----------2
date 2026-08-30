import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/data/branch_dashboard_providers.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_daily_metrics.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';

final branchDashboardProvider =
    AsyncNotifierProvider<BranchDashboardController, BranchDailyMetrics>(
      BranchDashboardController.new,
    );

class BranchDashboardController extends AsyncNotifier<BranchDailyMetrics> {
  @override
  Future<BranchDailyMetrics> build() async {
    final management = ref.watch(organizationManagementProvider);
    final branchId = switch (management) {
      AsyncData(:final value) => value.selectedBranchId,
      _ => null,
    };
    if (branchId == null) return const BranchDailyMetrics();
    return _load(branchId);
  }

  Future<void> refresh() async {
    final management = ref.read(organizationManagementProvider);
    final branchId = switch (management) {
      AsyncData(:final value) => value.selectedBranchId,
      _ => null,
    };
    if (branchId == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(branchId));
  }

  Future<BranchDailyMetrics> _load(String branchId) {
    final now = ref.read(branchDashboardClockProvider)();
    final dayStart = DateTime(now.year, now.month, now.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return ref
        .read(branchDashboardRepositoryProvider)
        .loadDailyMetrics(
          branchId: branchId,
          dayStart: dayStart,
          dayEnd: dayEnd,
        );
  }
}
