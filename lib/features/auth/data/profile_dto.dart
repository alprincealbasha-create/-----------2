import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileDto {
  const ProfileDto({
    required this.id,
    required this.organizationId,
    required this.role,
    required this.status,
    this.branchId,
    this.classId,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  final String id;
  final String organizationId;
  final String? branchId;
  final String? classId;
  final String role;
  final String status;

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}
