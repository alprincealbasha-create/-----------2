// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wird_program_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WirdProgram _$WirdProgramFromJson(Map<String, dynamic> json) => _WirdProgram(
  id: json['id'] as String,
  organizationId: json['organization_id'] as String,
  name: json['name'] as String,
  dhikrDefinitionId: json['dhikr_definition_id'] as String,
  dhikrTitleSnapshot: json['dhikr_title_snapshot'] as String,
  dhikrTextSnapshot: json['dhikr_text_snapshot'] as String,
  targetCount: (json['target_count'] as num).toInt(),
  startsOn: DateTime.parse(json['starts_on'] as String),
  endsOn: DateTime.parse(json['ends_on'] as String),
  audienceName: json['audience_name'] as String,
  scopeType: $enumDecode(_$WirdAssignmentScopeEnumMap, json['scope_type']),
);

Map<String, dynamic> _$WirdProgramToJson(_WirdProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization_id': instance.organizationId,
      'name': instance.name,
      'dhikr_definition_id': instance.dhikrDefinitionId,
      'dhikr_title_snapshot': instance.dhikrTitleSnapshot,
      'dhikr_text_snapshot': instance.dhikrTextSnapshot,
      'target_count': instance.targetCount,
      'starts_on': instance.startsOn.toIso8601String(),
      'ends_on': instance.endsOn.toIso8601String(),
      'audience_name': instance.audienceName,
      'scope_type': _$WirdAssignmentScopeEnumMap[instance.scopeType]!,
    };

const _$WirdAssignmentScopeEnumMap = {
  WirdAssignmentScope.organization: 'organization',
  WirdAssignmentScope.branch: 'branch',
  WirdAssignmentScope.multipleBranches: 'multiple_branches',
  WirdAssignmentScope.schoolClass: 'class',
  WirdAssignmentScope.role: 'role',
  WirdAssignmentScope.user: 'user',
};
