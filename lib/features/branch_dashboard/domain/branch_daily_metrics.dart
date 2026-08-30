import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch_daily_metrics.freezed.dart';

@freezed
abstract class BranchDailyMetrics with _$BranchDailyMetrics {
  const factory BranchDailyMetrics({
    @Default(0) int participatingUsers,
    @Default(0) int completedUsers,
    @Default(0) double completionRate,
    @Default(0) int totalRecordedDhikr,
    @Default(0) int participatingChildren,
    @Default(0) int participatingStaff,
  }) = _BranchDailyMetrics;

  factory BranchDailyMetrics.fromRpc(Map<String, Object?> row) {
    return BranchDailyMetrics(
      participatingUsers: (row['participating_users'] as num?)?.toInt() ?? 0,
      completedUsers: (row['completed_users'] as num?)?.toInt() ?? 0,
      completionRate: (row['completion_rate'] as num?)?.toDouble() ?? 0,
      totalRecordedDhikr: (row['total_recorded_dhikr'] as num?)?.toInt() ?? 0,
      participatingChildren:
          (row['participating_children'] as num?)?.toInt() ?? 0,
      participatingStaff: (row['participating_staff'] as num?)?.toInt() ?? 0,
    );
  }
}
