import 'package:freezed_annotation/freezed_annotation.dart';

part 'integrity_models.freezed.dart';

enum IntegrityFlagType {
  unusuallyFastActivity(
    'unusually_fast_activity',
    'نشاط سريع بصورة غير معتادة',
  ),
  excessiveActivity('excessive_activity', 'نشاط مرتفع بصورة غير معتادة'),
  syncAnomaly('sync_anomaly', 'مشكلة محتملة في المزامنة');

  const IntegrityFlagType(this.value, this.arabicLabel);

  final String value;
  final String arabicLabel;

  static IntegrityFlagType parse(String value) =>
      IntegrityFlagType.values.firstWhere((item) => item.value == value);
}

enum IntegrityFlagStatus {
  open('open', 'تحتاج مراجعة'),
  reviewed('reviewed', 'تمت المراجعة'),
  dismissed('dismissed', 'تم الاستبعاد');

  const IntegrityFlagStatus(this.value, this.arabicLabel);

  final String value;
  final String arabicLabel;

  static IntegrityFlagStatus parse(String value) =>
      IntegrityFlagStatus.values.firstWhere((item) => item.value == value);
}

@freezed
abstract class IntegrityFlag with _$IntegrityFlag {
  const factory IntegrityFlag({
    required String id,
    required String branchUserId,
    required String userName,
    required IntegrityFlagType type,
    required IntegrityFlagStatus status,
    required int observedCount,
    required int thresholdCount,
    required DateTime windowStartedAt,
    required DateTime windowEndedAt,
    required DateTime detectedAt,
  }) = _IntegrityFlag;

  factory IntegrityFlag.fromRpc(Map<String, Object?> row) {
    return IntegrityFlag(
      id: row['flag_id']! as String,
      branchUserId: row['branch_user_id']! as String,
      userName: row['user_name']! as String,
      type: IntegrityFlagType.parse(row['flag_type']! as String),
      status: IntegrityFlagStatus.parse(row['flag_status']! as String),
      observedCount: (row['observed_count']! as num).toInt(),
      thresholdCount: (row['threshold_count']! as num).toInt(),
      windowStartedAt: DateTime.parse(row['window_started_at']! as String),
      windowEndedAt: DateTime.parse(row['window_ended_at']! as String),
      detectedAt: DateTime.parse(row['detected_at']! as String),
    );
  }
}
