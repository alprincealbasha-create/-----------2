import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_branch_metrics.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_dashboard_repository.dart';

class SupabaseCentralDashboardRepository implements CentralDashboardRepository {
  SupabaseCentralDashboardRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<CentralBranchMetrics>> loadDailyMetrics({
    required String organizationId,
    required DateTime dayStart,
    required DateTime dayEnd,
  }) async {
    try {
      final result = await _client.rpc(
        'get_central_daily_metrics',
        params: {
          'p_organization_id': organizationId,
          'p_day_start': dayStart.toUtc().toIso8601String(),
          'p_day_end': dayEnd.toUtc().toIso8601String(),
        },
      );
      return rankCentralBranches(
        (result as List<dynamic>).map(
          (row) => CentralBranchMetrics.fromRpc(
            Map<String, Object?>.from(row as Map),
          ),
        ),
      );
    } catch (_) {
      throw const CentralDashboardFailure(
        'تعذر تحميل مؤشرات الإدارة المركزية.',
      );
    }
  }
}
