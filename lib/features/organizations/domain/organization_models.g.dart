// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Organization _$OrganizationFromJson(Map<String, dynamic> json) =>
    _Organization(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$OrganizationToJson(_Organization instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_Branch _$BranchFromJson(Map<String, dynamic> json) => _Branch(
  id: json['id'] as String,
  organizationId: json['organization_id'] as String,
  name: json['name'] as String,
  city: json['city'] as String?,
);

Map<String, dynamic> _$BranchToJson(_Branch instance) => <String, dynamic>{
  'id': instance.id,
  'organization_id': instance.organizationId,
  'name': instance.name,
  'city': instance.city,
};

_SchoolClass _$SchoolClassFromJson(Map<String, dynamic> json) => _SchoolClass(
  id: json['id'] as String,
  branchId: json['branch_id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$SchoolClassToJson(_SchoolClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'name': instance.name,
    };

_ChildRecord _$ChildRecordFromJson(Map<String, dynamic> json) => _ChildRecord(
  id: json['id'] as String,
  classId: json['class_id'] as String,
  fullName: json['full_name'] as String,
  birthDate: json['birth_date'] == null
      ? null
      : DateTime.parse(json['birth_date'] as String),
);

Map<String, dynamic> _$ChildRecordToJson(_ChildRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class_id': instance.classId,
      'full_name': instance.fullName,
      'birth_date': instance.birthDate?.toIso8601String(),
    };
