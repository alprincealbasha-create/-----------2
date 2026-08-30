import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch_user_models.freezed.dart';
part 'branch_user_models.g.dart';

@JsonEnum(valueField: 'value')
enum ManagedUserType {
  child('child', 'طفل', true),
  teacher('teacher', 'معلم', true),
  administrator('administrator', 'إداري', false),
  branchManager('branch_manager', 'مدير فرع', false);

  const ManagedUserType(this.value, this.arabicLabel, this.requiresClass);

  final String value;
  final String arabicLabel;
  final bool requiresClass;
}

@freezed
abstract class ManagedUser with _$ManagedUser {
  const factory ManagedUser({
    required String id,
    @JsonKey(name: 'branch_id') required String branchId,
    @JsonKey(name: 'class_id') String? classId,
    @JsonKey(name: 'profile_id') String? profileId,
    @JsonKey(name: 'user_type') required ManagedUserType userType,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'birth_date') DateTime? birthDate,
  }) = _ManagedUser;

  factory ManagedUser.fromJson(Map<String, Object?> json) =>
      _$ManagedUserFromJson(json);
}
