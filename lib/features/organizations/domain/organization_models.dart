import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_models.freezed.dart';
part 'organization_models.g.dart';

@freezed
abstract class Organization with _$Organization {
  const factory Organization({required String id, required String name}) =
      _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
}

@freezed
abstract class Branch with _$Branch {
  const factory Branch({
    required String id,
    @JsonKey(name: 'organization_id') required String organizationId,
    required String name,
    String? city,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
}

@freezed
abstract class SchoolClass with _$SchoolClass {
  const factory SchoolClass({
    required String id,
    @JsonKey(name: 'branch_id') required String branchId,
    required String name,
  }) = _SchoolClass;

  factory SchoolClass.fromJson(Map<String, dynamic> json) =>
      _$SchoolClassFromJson(json);
}

@freezed
abstract class ChildRecord with _$ChildRecord {
  const factory ChildRecord({
    required String id,
    @JsonKey(name: 'class_id') required String classId,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'birth_date') DateTime? birthDate,
  }) = _ChildRecord;

  factory ChildRecord.fromJson(Map<String, dynamic> json) =>
      _$ChildRecordFromJson(json);
}
