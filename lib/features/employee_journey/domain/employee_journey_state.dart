import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

part 'employee_journey_state.freezed.dart';

@freezed
abstract class EmployeeJourneyState with _$EmployeeJourneyState {
  const factory EmployeeJourneyState({
    required ManagedUser employee,
    ManagedWird? currentWird,
    @Default(0) int currentCount,
    @Default(<ManagedWird>[]) List<ManagedWird> history,
    SchoolClass? schoolClass,
    @Default(<ManagedUser>[]) List<ManagedUser> classChildren,
  }) = _EmployeeJourneyState;
}
