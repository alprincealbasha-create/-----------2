import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/employee_journey/data/supabase_employee_journey_repository.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_repository.dart';

final employeeJourneyRepositoryProvider = Provider<EmployeeJourneyRepository>((
  ref,
) {
  return SupabaseEmployeeJourneyRepository(ref.watch(supabaseClientProvider));
});
