import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

part 'administrative_report_models.freezed.dart';

enum ReportCompletionStatus {
  notStarted('not_started', 'لم يبدأ'),
  inProgress('in_progress', 'قيد الإنجاز'),
  completed('completed', 'مكتمل');

  const ReportCompletionStatus(this.value, this.arabicLabel);

  final String value;
  final String arabicLabel;

  static ReportCompletionStatus parse(String value) => values.firstWhere(
    (item) => item.value == value,
    orElse: () => throw const FormatException('Unknown completion status'),
  );
}

enum AdministrativeReportView {
  daily('تقرير يومي'),
  branch('تقرير الفرع'),
  user('تقرير المستخدم');

  const AdministrativeReportView(this.arabicLabel);

  final String arabicLabel;
}

@freezed
abstract class ReportFilterOption with _$ReportFilterOption {
  const factory ReportFilterOption({
    required String id,
    required String label,
    String? branchId,
    String? classId,
    ManagedUserType? role,
  }) = _ReportFilterOption;

  factory ReportFilterOption.fromRpc(Map<String, Object?> row) {
    final roleValue = row['role'] as String?;
    return ReportFilterOption(
      id: row['id'] as String,
      label: row['label'] as String,
      branchId: row['branch_id'] as String?,
      classId: row['class_id'] as String?,
      role: roleValue == null
          ? null
          : ManagedUserType.values.firstWhere(
              (item) => item.value == roleValue,
            ),
    );
  }
}

@freezed
abstract class AdministrativeReportOptions with _$AdministrativeReportOptions {
  const factory AdministrativeReportOptions({
    @Default(<ReportFilterOption>[]) List<ReportFilterOption> branches,
    @Default(<ReportFilterOption>[]) List<ReportFilterOption> classes,
    @Default(<ReportFilterOption>[]) List<ReportFilterOption> users,
    @Default(<ReportFilterOption>[]) List<ReportFilterOption> wirds,
    @Default(<ReportFilterOption>[]) List<ReportFilterOption> dhikrs,
  }) = _AdministrativeReportOptions;

  factory AdministrativeReportOptions.fromRpc(Map<String, Object?> json) {
    List<ReportFilterOption> parse(String key) => (json[key] as List<dynamic>)
        .map(
          (item) => ReportFilterOption.fromRpc(
            Map<String, Object?>.from(item as Map),
          ),
        )
        .toList(growable: false);
    return AdministrativeReportOptions(
      branches: parse('branches'),
      classes: parse('classes'),
      users: parse('users'),
      wirds: parse('wirds'),
      dhikrs: parse('dhikrs'),
    );
  }
}

@freezed
abstract class AdministrativeReportFilters with _$AdministrativeReportFilters {
  const factory AdministrativeReportFilters({
    required DateTime startDate,
    required DateTime endDate,
    @Default(AdministrativeReportView.daily) AdministrativeReportView view,
    String? branchId,
    String? classId,
    ManagedUserType? role,
    String? userId,
    String? wirdId,
    String? dhikrId,
    ReportCompletionStatus? completionStatus,
  }) = _AdministrativeReportFilters;
}

@freezed
abstract class AdministrativeReportRow with _$AdministrativeReportRow {
  const factory AdministrativeReportRow({
    required String assignmentId,
    required DateTime activityDate,
    required String branchId,
    required String branchName,
    String? classId,
    String? className,
    required String userId,
    required String userName,
    required ManagedUserType userRole,
    String? wirdId,
    required String wirdName,
    String? dhikrId,
    required String dhikrTitle,
    required int currentCount,
    required int targetCount,
    required ReportCompletionStatus completionStatus,
    DateTime? completedAt,
  }) = _AdministrativeReportRow;

  factory AdministrativeReportRow.fromRpc(Map<String, Object?> row) {
    return AdministrativeReportRow(
      assignmentId: row['assignment_id'] as String,
      activityDate: DateTime.parse(row['activity_date'] as String),
      branchId: row['branch_id'] as String,
      branchName: row['branch_name'] as String,
      classId: row['class_id'] as String?,
      className: row['class_name'] as String?,
      userId: row['user_id'] as String,
      userName: row['user_name'] as String,
      userRole: ManagedUserType.values.firstWhere(
        (item) => item.value == row['user_role'],
      ),
      wirdId: row['wird_id'] as String?,
      wirdName: row['wird_name'] as String,
      dhikrId: row['dhikr_id'] as String?,
      dhikrTitle: row['dhikr_title'] as String,
      currentCount: row['current_count'] as int,
      targetCount: row['target_count'] as int,
      completionStatus: ReportCompletionStatus.parse(
        row['completion_status'] as String,
      ),
      completedAt: row['completed_at'] == null
          ? null
          : DateTime.parse(row['completed_at'] as String),
    );
  }
}

@freezed
abstract class AdministrativeReportData with _$AdministrativeReportData {
  const factory AdministrativeReportData({
    required AdministrativeReportOptions options,
    required AdministrativeReportFilters filters,
    @Default(<AdministrativeReportRow>[]) List<AdministrativeReportRow> rows,
  }) = _AdministrativeReportData;
}
