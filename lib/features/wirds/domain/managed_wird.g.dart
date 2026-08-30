// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managed_wird.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ManagedWird _$ManagedWirdFromJson(Map<String, dynamic> json) => _ManagedWird(
  id: json['id'] as String,
  branchId: json['branch_id'] as String,
  assignedUserId: json['assigned_user_id'] as String?,
  title: json['title'] as String,
  details: json['details'] as String?,
  targetCount: (json['target_count'] as num?)?.toInt(),
  status: $enumDecode(_$ManagedWirdStatusEnumMap, json['status']),
  assignedAt: json['assigned_at'] == null
      ? null
      : DateTime.parse(json['assigned_at'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
  wirdProgramId: json['wird_program_id'] as String?,
  dhikrDefinitionId: json['dhikr_definition_id'] as String?,
  dhikrTitleSnapshot: json['dhikr_title_snapshot'] as String?,
  dhikrTextSnapshot: json['dhikr_text_snapshot'] as String?,
  availableFrom: json['available_from'] == null
      ? null
      : DateTime.parse(json['available_from'] as String),
  availableUntil: json['available_until'] == null
      ? null
      : DateTime.parse(json['available_until'] as String),
  availabilityTimezone: json['availability_timezone'] as String?,
);

Map<String, dynamic> _$ManagedWirdToJson(_ManagedWird instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'assigned_user_id': instance.assignedUserId,
      'title': instance.title,
      'details': instance.details,
      'target_count': instance.targetCount,
      'status': _$ManagedWirdStatusEnumMap[instance.status]!,
      'assigned_at': instance.assignedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'wird_program_id': instance.wirdProgramId,
      'dhikr_definition_id': instance.dhikrDefinitionId,
      'dhikr_title_snapshot': instance.dhikrTitleSnapshot,
      'dhikr_text_snapshot': instance.dhikrTextSnapshot,
      'available_from': instance.availableFrom?.toIso8601String(),
      'available_until': instance.availableUntil?.toIso8601String(),
      'availability_timezone': instance.availabilityTimezone,
    };

const _$ManagedWirdStatusEnumMap = {
  ManagedWirdStatus.draft: 'draft',
  ManagedWirdStatus.assigned: 'assigned',
  ManagedWirdStatus.completed: 'completed',
};
