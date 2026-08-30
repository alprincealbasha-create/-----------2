import 'package:ward_al_rawdah/features/central_dashboard/domain/central_branch_metrics.dart';

abstract interface class CentralDashboardRepository {
  Future<List<CentralBranchMetrics>> loadDailyMetrics({
    required String organizationId,
    required DateTime dayStart,
    required DateTime dayEnd,
  });
}

class CentralDashboardFailure implements Exception {
  const CentralDashboardFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
