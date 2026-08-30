import 'package:freezed_annotation/freezed_annotation.dart';

part 'managed_wird.freezed.dart';
part 'managed_wird.g.dart';

@JsonEnum(valueField: 'value')
enum ManagedWirdStatus {
  draft('draft', 'مسودة'),
  assigned('assigned', 'مكلّف'),
  completed('completed', 'منتهٍ');

  const ManagedWirdStatus(this.value, this.arabicLabel);

  final String value;
  final String arabicLabel;
}

@freezed
abstract class ManagedWird with _$ManagedWird {
  const factory ManagedWird({
    required String id,
    @JsonKey(name: 'branch_id') required String branchId,
    @JsonKey(name: 'assigned_user_id') String? assignedUserId,
    required String title,
    String? details,
    @JsonKey(name: 'target_count') int? targetCount,
    required ManagedWirdStatus status,
    @JsonKey(name: 'assigned_at') DateTime? assignedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'wird_program_id') String? wirdProgramId,
    @JsonKey(name: 'dhikr_definition_id') String? dhikrDefinitionId,
    @JsonKey(name: 'dhikr_title_snapshot') String? dhikrTitleSnapshot,
    @JsonKey(name: 'dhikr_text_snapshot') String? dhikrTextSnapshot,
    @JsonKey(name: 'available_from') DateTime? availableFrom,
    @JsonKey(name: 'available_until') DateTime? availableUntil,
    @JsonKey(name: 'availability_timezone') String? availabilityTimezone,
  }) = _ManagedWird;

  factory ManagedWird.fromJson(Map<String, Object?> json) =>
      _$ManagedWirdFromJson(json);
}

bool isWirdAvailableOn(ManagedWird wird, DateTime day) {
  final date = DateTime(day.year, day.month, day.day);
  final from = wird.availableFrom;
  final until = wird.availableUntil;
  final normalizedFrom = from == null
      ? null
      : DateTime(from.year, from.month, from.day);
  final normalizedUntil = until == null
      ? null
      : DateTime(until.year, until.month, until.day);
  return (normalizedFrom == null || !date.isBefore(normalizedFrom)) &&
      (normalizedUntil == null || !date.isAfter(normalizedUntil));
}
