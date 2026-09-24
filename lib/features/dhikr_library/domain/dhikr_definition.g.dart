// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dhikr_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DhikrDefinition _$DhikrDefinitionFromJson(Map<String, dynamic> json) =>
    _DhikrDefinition(
      id: json['id'] as String,
      ownerBranchId: json['owner_branch_id'] as String?,
      title: json['title'] as String,
      displayText: json['display_text'] as String,
      description: json['description'] as String?,
      defaultTarget: (json['default_target'] as num).toInt(),
      status: $enumDecode(_$DhikrDefinitionStatusEnumMap, json['status']),
      createdBy: json['created_by'] as String,
      sourceReference: json['source_reference'] as String?,
      contentVersion: (json['content_version'] as num?)?.toInt() ?? 1,
      contentChecksum: json['content_checksum'] as String?,
      reviewedBy: json['reviewed_by'] as String?,
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
    );

Map<String, dynamic> _$DhikrDefinitionToJson(_DhikrDefinition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_branch_id': instance.ownerBranchId,
      'title': instance.title,
      'display_text': instance.displayText,
      'description': instance.description,
      'default_target': instance.defaultTarget,
      'status': _$DhikrDefinitionStatusEnumMap[instance.status]!,
      'created_by': instance.createdBy,
      'source_reference': instance.sourceReference,
      'content_version': instance.contentVersion,
      'content_checksum': instance.contentChecksum,
      'reviewed_by': instance.reviewedBy,
      'reviewed_at': instance.reviewedAt?.toIso8601String(),
    };

const _$DhikrDefinitionStatusEnumMap = {
  DhikrDefinitionStatus.draft: 'draft',
  DhikrDefinitionStatus.inReview: 'in_review',
  DhikrDefinitionStatus.approved: 'approved',
  DhikrDefinitionStatus.archived: 'archived',
};
