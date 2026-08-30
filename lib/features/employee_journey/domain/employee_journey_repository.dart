import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_state.dart';

abstract interface class EmployeeJourneyRepository {
  Future<EmployeeJourneyState?> loadHome();
}

class EmployeeJourneyFailure implements Exception {
  const EmployeeJourneyFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
