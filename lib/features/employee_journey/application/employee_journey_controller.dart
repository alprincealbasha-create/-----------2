import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/employee_journey/data/employee_journey_providers.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_state.dart';

final employeeJourneyProvider =
    AsyncNotifierProvider<EmployeeJourneyController, EmployeeJourneyState?>(
      EmployeeJourneyController.new,
    );

class EmployeeJourneyController extends AsyncNotifier<EmployeeJourneyState?> {
  @override
  Future<EmployeeJourneyState?> build() {
    return ref.read(employeeJourneyRepositoryProvider).loadHome();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(employeeJourneyRepositoryProvider).loadHome(),
    );
  }
}
