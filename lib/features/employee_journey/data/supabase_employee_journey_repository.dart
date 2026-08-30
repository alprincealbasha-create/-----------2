import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_repository.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_state.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

class SupabaseEmployeeJourneyRepository implements EmployeeJourneyRepository {
  SupabaseEmployeeJourneyRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<EmployeeJourneyState?> loadHome() async {
    try {
      final profileId = _client.auth.currentUser?.id;
      if (profileId == null) {
        throw const EmployeeJourneyFailure('يجب تسجيل الدخول أولًا.');
      }
      final employeeRow = await _client
          .from('branch_users')
          .select(
            'id, branch_id, class_id, profile_id, user_type, full_name, '
            'birth_date',
          )
          .eq('profile_id', profileId)
          .isFilter('deleted_at', null)
          .maybeSingle();
      if (employeeRow == null) return null;

      final employee = ManagedUser.fromJson(employeeRow);
      if (employee.userType == ManagedUserType.child) return null;

      final wirdRows = await _client
          .from('managed_wirds')
          .select(
            'id, branch_id, assigned_user_id, title, details, target_count, '
            'status, assigned_at, completed_at, wird_program_id, '
            'dhikr_definition_id, dhikr_title_snapshot, '
            'dhikr_text_snapshot, available_from, available_until, '
            'availability_timezone',
          )
          .eq('assigned_user_id', employee.id)
          .inFilter('status', ['assigned', 'completed'])
          .isFilter('deleted_at', null)
          .order('assigned_at', ascending: false)
          .limit(30);
      final wirds = wirdRows.map(ManagedWird.fromJson).toList(growable: false);
      final current = _firstAssigned(wirds, DateTime.now());
      final history = wirds
          .where((wird) => wird.status == ManagedWirdStatus.completed)
          .toList(growable: false);
      var currentCount = 0;
      if (current != null) {
        final progress = await _client
            .from('managed_wird_progress')
            .select('count')
            .eq('wird_id', current.id)
            .maybeSingle();
        currentCount = progress?['count'] as int? ?? 0;
      }

      SchoolClass? schoolClass;
      var children = const <ManagedUser>[];
      if (employee.userType == ManagedUserType.teacher &&
          employee.classId != null) {
        final classRow = await _client
            .from('classes')
            .select('id, branch_id, name')
            .eq('id', employee.classId!)
            .maybeSingle();
        if (classRow != null) schoolClass = SchoolClass.fromJson(classRow);
        final childRows = await _client
            .from('branch_users')
            .select(
              'id, branch_id, class_id, profile_id, user_type, full_name, '
              'birth_date',
            )
            .eq('class_id', employee.classId!)
            .eq('user_type', ManagedUserType.child.value)
            .isFilter('deleted_at', null)
            .order('full_name');
        children = childRows.map(ManagedUser.fromJson).toList(growable: false);
      }

      return EmployeeJourneyState(
        employee: employee,
        currentWird: current,
        currentCount: currentCount,
        history: history,
        schoolClass: schoolClass,
        classChildren: children,
      );
    } on EmployeeJourneyFailure {
      rethrow;
    } catch (_) {
      throw const EmployeeJourneyFailure('تعذر تحميل بيانات الموظف.');
    }
  }

  ManagedWird? _firstAssigned(List<ManagedWird> wirds, DateTime today) {
    for (final wird in wirds) {
      if (wird.status == ManagedWirdStatus.assigned &&
          isWirdAvailableOn(wird, today)) {
        return wird;
      }
    }
    return null;
  }
}
