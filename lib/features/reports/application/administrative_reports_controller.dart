import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';
import 'package:ward_al_rawdah/features/reports/data/administrative_reports_providers.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_report_models.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_reports_repository.dart';

final administrativeReportsProvider =
    AsyncNotifierProvider<
      AdministrativeReportsController,
      AdministrativeReportData
    >(AdministrativeReportsController.new);

class AdministrativeReportsController
    extends AsyncNotifier<AdministrativeReportData> {
  AdministrativeReportOptions? _lastOptions;
  AdministrativeReportFilters? _lastFilters;

  AdministrativeReportsRepository get _repository =>
      ref.read(administrativeReportsRepositoryProvider);

  @override
  Future<AdministrativeReportData> build() async {
    final organizationId = _organizationId(watch: true);
    if (organizationId == null) {
      throw const AdministrativeReportFailure('اختر مؤسسة أولًا.');
    }
    final now = DateTime.now();
    final filters = AdministrativeReportFilters(
      startDate: DateTime(now.year, now.month, 1),
      endDate: DateTime(now.year, now.month, now.day),
    );
    _lastFilters = filters;
    return _load(organizationId, filters);
  }

  Future<void> apply(AdministrativeReportFilters filters) async {
    final organizationId = _organizationId();
    if (organizationId == null) return;
    final options = state.value?.options ?? _lastOptions;
    _lastFilters = filters;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final rows = await _repository.getCompletionReport(
        organizationId: organizationId,
        filters: filters,
      );
      return AdministrativeReportData(
        options: options ?? await _repository.getOptions(organizationId),
        filters: filters,
        rows: rows,
      );
    });
  }

  Future<void> refresh() async {
    final filters = state.value?.filters ?? _lastFilters;
    final organizationId = _organizationId();
    if (filters == null || organizationId == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(organizationId, filters));
  }

  Future<AdministrativeReportData> _load(
    String organizationId,
    AdministrativeReportFilters filters,
  ) async {
    final options = await _repository.getOptions(organizationId);
    _lastOptions = options;
    _lastFilters = filters;
    final rows = await _repository.getCompletionReport(
      organizationId: organizationId,
      filters: filters,
    );
    return AdministrativeReportData(
      options: options,
      filters: filters,
      rows: rows,
    );
  }

  String? _organizationId({bool watch = false}) {
    final management = watch
        ? ref.watch(organizationManagementProvider)
        : ref.read(organizationManagementProvider);
    return management.value?.selectedOrganizationId;
  }
}
