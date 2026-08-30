import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileDto {
  const ProfileDto({required this.id, required this.role});

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  final String id;
  final String role;

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}
