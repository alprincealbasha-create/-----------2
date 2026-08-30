// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ManagedUser _$ManagedUserFromJson(Map<String, dynamic> json) => _ManagedUser(
  id: json['id'] as String,
  branchId: json['branch_id'] as String,
  classId: json['class_id'] as String?,
  profileId: json['profile_id'] as String?,
  userType: $enumDecode(_$ManagedUserTypeEnumMap, json['user_type']),
  fullName: json['full_name'] as String,
  birthDate: json['birth_date'] == null
      ? null
      : DateTime.parse(json['birth_date'] as String),
);

Map<String, dynamic> _$ManagedUserToJson(_ManagedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'class_id': instance.classId,
      'profile_id': instance.profileId,
      'user_type': _$ManagedUserTypeEnumMap[instance.userType]!,
      'full_name': instance.fullName,
      'birth_date': instance.birthDate?.toIso8601String(),
    };

const _$ManagedUserTypeEnumMap = {
  ManagedUserType.child: 'child',
  ManagedUserType.teacher: 'teacher',
  ManagedUserType.administrator: 'administrator',
  ManagedUserType.branchManager: 'branch_manager',
};
