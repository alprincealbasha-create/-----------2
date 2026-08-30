import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_daily_metrics.dart';

abstract interface class BranchDashboardRepository {
  Future<BranchDailyMetrics> loadDailyMetrics({
    required String branchId,
    required DateTime dayStart,
    required DateTime dayEnd,
  });
}

class BranchDashboardFailure implements Exception {
  const BranchDashboardFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
