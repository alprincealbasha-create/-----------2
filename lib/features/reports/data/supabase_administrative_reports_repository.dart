import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_report_models.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_reports_repository.dart';

class SupabaseAdministrativeReportsRepository
    implements AdministrativeReportsRepository {
  SupabaseAdministrativeReportsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<AdministrativeReportOptions> getOptions(String organizationId) async {
    try {
      final result = await _client.rpc(
        'get_administrative_report_filter_options',
        params: {'p_organization_id': organizationId},
      );
      return AdministrativeReportOptions.fromRpc(
        Map<String, Object?>.from(result as Map),
      );
    } catch (_) {
      throw const AdministrativeReportFailure('تعذر تحميل خيارات التقارير.');
    }
  }

  @override
  Future<List<AdministrativeReportRow>> getCompletionReport({
    required String organizationId,
    required AdministrativeReportFilters filters,
  }) async {
    try {
      final result = await _client.rpc(
        'get_administrative_completion_report',
        params: {
          'p_organization_id': organizationId,
          'p_start_date': _date(filters.startDate),
          'p_end_date': _date(filters.endDate),
          'p_branch_id': filters.branchId,
          'p_class_id': filters.classId,
          'p_role': filters.role?.value,
          'p_user_id': filters.userId,
          'p_wird_id': filters.wirdId,
          'p_dhikr_id': filters.dhikrId,
          'p_completion_status': filters.completionStatus?.value,
        },
      );
      return (result as List<dynamic>)
          .map(
            (row) => AdministrativeReportRow.fromRpc(
              Map<String, Object?>.from(row as Map),
            ),
          )
          .toList(growable: false);
    } catch (_) {
      throw const AdministrativeReportFailure('تعذر تحميل التقرير.');
    }
  }

  String _date(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';
}
