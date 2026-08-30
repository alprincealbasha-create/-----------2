import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_daily_metrics.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_dashboard_repository.dart';

class SupabaseBranchDashboardRepository implements BranchDashboardRepository {
  SupabaseBranchDashboardRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<BranchDailyMetrics> loadDailyMetrics({
    required String branchId,
    required DateTime dayStart,
    required DateTime dayEnd,
  }) async {
    try {
      final result = await _client.rpc(
        'get_branch_daily_metrics',
        params: {
          'p_branch_id': branchId,
          'p_day_start': dayStart.toUtc().toIso8601String(),
          'p_day_end': dayEnd.toUtc().toIso8601String(),
        },
      );
      final rows = result as List<dynamic>;
      if (rows.isEmpty) return const BranchDailyMetrics();
      return BranchDailyMetrics.fromRpc(
        Map<String, Object?>.from(rows.first as Map),
      );
    } catch (_) {
      throw const BranchDashboardFailure('تعذر تحميل مؤشرات اليوم.');
    }
  }
}
