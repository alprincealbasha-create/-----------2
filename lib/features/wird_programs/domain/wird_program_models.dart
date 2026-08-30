import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

part 'wird_program_models.freezed.dart';
part 'wird_program_models.g.dart';

@JsonEnum(valueField: 'value')
enum WirdAssignmentScope {
  organization('organization', 'جميع المؤسسة'),
  branch('branch', 'فرع واحد'),
  multipleBranches('multiple_branches', 'عدة فروع'),
  schoolClass('class', 'صف'),
  role('role', 'دور'),
  user('user', 'مستخدم');

  const WirdAssignmentScope(this.value, this.arabicLabel);

  final String value;
  final String arabicLabel;
}

@freezed
abstract class WirdProgram with _$WirdProgram {
  const factory WirdProgram({
    required String id,
    @JsonKey(name: 'organization_id') required String organizationId,
    required String name,
    @JsonKey(name: 'dhikr_definition_id') required String dhikrDefinitionId,
    @JsonKey(name: 'dhikr_title_snapshot') required String dhikrTitleSnapshot,
    @JsonKey(name: 'dhikr_text_snapshot') required String dhikrTextSnapshot,
    @JsonKey(name: 'target_count') required int targetCount,
    @JsonKey(name: 'starts_on') required DateTime startsOn,
    @JsonKey(name: 'ends_on') required DateTime endsOn,
    @JsonKey(name: 'audience_name') required String audienceName,
    @JsonKey(name: 'scope_type') required WirdAssignmentScope scopeType,
  }) = _WirdProgram;

  factory WirdProgram.fromJson(Map<String, Object?> json) =>
      _$WirdProgramFromJson(json);
}

@freezed
abstract class WirdProgramCreationState with _$WirdProgramCreationState {
  const factory WirdProgramCreationState({
    @Default(<WirdProgram>[]) List<WirdProgram> programs,
    @Default(<DhikrDefinition>[]) List<DhikrDefinition> dhikrDefinitions,
    @Default(<Branch>[]) List<Branch> branches,
    @Default(<SchoolClass>[]) List<SchoolClass> classes,
    @Default(<ManagedUser>[]) List<ManagedUser> users,
    int? lastAssignedCount,
  }) = _WirdProgramCreationState;
}

class WirdProgramRequest {
  const WirdProgramRequest({
    required this.name,
    required this.dhikrDefinitionId,
    required this.targetCount,
    required this.startsOn,
    required this.endsOn,
    required this.audienceName,
    required this.scope,
    required this.branchIds,
    required this.classIds,
    required this.roles,
    required this.userIds,
  });

  final String name;
  final String dhikrDefinitionId;
  final int targetCount;
  final DateTime startsOn;
  final DateTime endsOn;
  final String audienceName;
  final WirdAssignmentScope scope;
  final Set<String> branchIds;
  final Set<String> classIds;
  final Set<ManagedUserType> roles;
  final Set<String> userIds;
}
