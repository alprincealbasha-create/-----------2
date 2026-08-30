import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/central_dashboard/data/central_dashboard_providers.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_branch_metrics.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';

final centralDashboardProvider =
    AsyncNotifierProvider<
      CentralDashboardController,
      List<CentralBranchMetrics>
    >(CentralDashboardController.new);

class CentralDashboardController
    extends AsyncNotifier<List<CentralBranchMetrics>> {
  @override
  Future<List<CentralBranchMetrics>> build() async {
    final management = ref.watch(organizationManagementProvider);
    final organizationId = switch (management) {
      AsyncData(:final value) => value.selectedOrganizationId,
      _ => null,
    };
    if (organizationId == null) return const [];
    return _load(organizationId);
  }

  Future<void> refresh() async {
    final management = ref.read(organizationManagementProvider);
    final organizationId = switch (management) {
      AsyncData(:final value) => value.selectedOrganizationId,
      _ => null,
    };
    if (organizationId == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(organizationId));
  }

  Future<List<CentralBranchMetrics>> _load(String organizationId) {
    final now = ref.read(centralDashboardClockProvider)();
    final dayStart = DateTime(now.year, now.month, now.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return ref
        .read(centralDashboardRepositoryProvider)
        .loadDailyMetrics(
          organizationId: organizationId,
          dayStart: dayStart,
          dayEnd: dayEnd,
        );
  }
}
