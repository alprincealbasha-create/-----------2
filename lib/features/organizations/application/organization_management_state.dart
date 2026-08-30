import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

part 'organization_management_state.freezed.dart';

@freezed
abstract class OrganizationManagementState with _$OrganizationManagementState {
  const factory OrganizationManagementState({
    @Default(<Organization>[]) List<Organization> organizations,
    @Default(<Branch>[]) List<Branch> branches,
    @Default(<SchoolClass>[]) List<SchoolClass> classes,
    @Default(<ChildRecord>[]) List<ChildRecord> children,
    String? selectedOrganizationId,
    String? selectedBranchId,
    String? selectedClassId,
  }) = _OrganizationManagementState;
}
