import 'package:freezed_annotation/freezed_annotation.dart';

part 'central_branch_metrics.freezed.dart';

@freezed
abstract class CentralBranchMetrics with _$CentralBranchMetrics {
  const factory CentralBranchMetrics({
    required String branchId,
    required String branchName,
    String? branchCity,
    @Default(0) int eligibleUsers,
    @Default(0) int participatingUsers,
    @Default(0) int completedUsers,
    @Default(0) double participationRate,
    @Default(0) double completionRate,
    @Default(0) int totalRecordedDhikr,
  }) = _CentralBranchMetrics;

  factory CentralBranchMetrics.fromRpc(Map<String, Object?> row) {
    return CentralBranchMetrics(
      branchId: row['branch_id']! as String,
      branchName: row['branch_name']! as String,
      branchCity: row['branch_city'] as String?,
      eligibleUsers: (row['eligible_users'] as num?)?.toInt() ?? 0,
      participatingUsers: (row['participating_users'] as num?)?.toInt() ?? 0,
      completedUsers: (row['completed_users'] as num?)?.toInt() ?? 0,
      participationRate: (row['participation_rate'] as num?)?.toDouble() ?? 0,
      completionRate: (row['completion_rate'] as num?)?.toDouble() ?? 0,
      totalRecordedDhikr: (row['total_recorded_dhikr'] as num?)?.toInt() ?? 0,
    );
  }
}

List<CentralBranchMetrics> rankCentralBranches(
  Iterable<CentralBranchMetrics> branches,
) {
  final ranked = branches.toList(growable: false);
  ranked.sort((left, right) {
    final byCompletion = right.completionRate.compareTo(left.completionRate);
    if (byCompletion != 0) return byCompletion;
    final byParticipation = right.participationRate.compareTo(
      left.participationRate,
    );
    if (byParticipation != 0) return byParticipation;
    return left.branchName.compareTo(right.branchName);
  });
  return ranked;
}
