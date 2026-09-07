// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
  id: json['id'] as String,
  organizationId: json['organization_id'] as String,
  role: json['role'] as String,
  status: json['status'] as String,
  branchId: json['branch_id'] as String?,
  classId: json['class_id'] as String?,
);

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization_id': instance.organizationId,
      'branch_id': instance.branchId,
      'class_id': instance.classId,
      'role': instance.role,
      'status': instance.status,
    };
