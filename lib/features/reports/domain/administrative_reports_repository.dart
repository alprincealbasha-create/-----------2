import 'package:ward_al_rawdah/features/reports/domain/administrative_report_models.dart';

abstract interface class AdministrativeReportsRepository {
  Future<AdministrativeReportOptions> getOptions(String organizationId);

  Future<List<AdministrativeReportRow>> getCompletionReport({
    required String organizationId,
    required AdministrativeReportFilters filters,
  });
}

class AdministrativeReportFailure implements Exception {
  const AdministrativeReportFailure(this.userMessage);

  final String userMessage;
}
