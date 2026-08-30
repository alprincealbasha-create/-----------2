import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_program_models.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_programs_repository.dart';

class SupabaseWirdProgramsRepository implements WirdProgramsRepository {
  SupabaseWirdProgramsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<WirdProgramCreationState> load(String organizationId) =>
      _guard('تعذر تحميل بيانات إنشاء الورد.', () async {
        final branchesRows = await _client
            .from('branches')
            .select('id, organization_id, name, city')
            .eq('organization_id', organizationId)
            .isFilter('deleted_at', null)
            .order('name');
        final branches = branchesRows.map(Branch.fromJson).toList();
        final branchIds = branches.map((item) => item.id).toList();
        final classRows = branchIds.isEmpty
            ? const <Map<String, dynamic>>[]
            : await _client
                  .from('classes')
                  .select('id, branch_id, name')
                  .inFilter('branch_id', branchIds)
                  .isFilter('deleted_at', null)
                  .order('name');
        final dhikrRows = await _client
            .from('dhikr_definitions')
            .select(
              'id, title, display_text, description, default_target, status, '
              'created_by, source_reference, content_version, '
              'content_checksum, reviewed_by, reviewed_at',
            )
            .eq('status', 'approved')
            .order('title');
        final userRows = branchIds.isEmpty
            ? const <Map<String, dynamic>>[]
            : await _client
                  .from('branch_users')
                  .select(
                    'id, branch_id, class_id, profile_id, user_type, '
                    'full_name, birth_date',
                  )
                  .inFilter('branch_id', branchIds)
                  .isFilter('deleted_at', null)
                  .order('full_name');
        final programRows = await _client
            .from('wird_programs')
            .select(
              'id, organization_id, name, dhikr_definition_id, '
              'dhikr_title_snapshot, dhikr_text_snapshot, target_count, '
              'starts_on, ends_on, audience_name, scope_type',
            )
            .eq('organization_id', organizationId)
            .order('created_at', ascending: false);
        return WirdProgramCreationState(
          programs: programRows.map(WirdProgram.fromJson).toList(),
          dhikrDefinitions: dhikrRows.map(DhikrDefinition.fromJson).toList(),
          branches: branches,
          classes: classRows.map(SchoolClass.fromJson).toList(),
          users: userRows.map(ManagedUser.fromJson).toList(),
        );
      });

  @override
  Future<int> create({
    required String organizationId,
    required WirdProgramRequest request,
  }) => _guard('تعذر إنشاء الورد وتكليف الجمهور.', () async {
    _validate(request);
    final result = await _client.rpc(
      'create_wird_program_v2',
      params: {
        'p_organization_id': organizationId,
        'p_name': request.name.trim(),
        'p_dhikr_definition_id': request.dhikrDefinitionId,
        'p_target_count': request.targetCount,
        'p_starts_on': _dateOnly(request.startsOn),
        'p_ends_on': _dateOnly(request.endsOn),
        'p_audience_name': request.audienceName.trim(),
        'p_scope_type': request.scope.value,
        'p_branch_ids': request.branchIds.toList(),
        'p_class_ids': request.classIds.toList(),
        'p_role_values': request.roles.map((role) => role.value).toList(),
        'p_user_ids': request.userIds.toList(),
      },
    );
    final rows = result as List<dynamic>;
    if (rows.isEmpty) return 0;
    final row = Map<String, Object?>.from(rows.first as Map);
    return (row['assigned_count'] as num?)?.toInt() ?? 0;
  });

  void _validate(WirdProgramRequest request) {
    if (request.name.trim().isEmpty) {
      throw const WirdProgramFailure('اسم الورد مطلوب.');
    }
    if (request.audienceName.trim().isEmpty) {
      throw const WirdProgramFailure('اسم الجمهور مطلوب.');
    }
    if (request.targetCount < 1 || request.targetCount > 100000) {
      throw const WirdProgramFailure('أدخل هدفًا بين 1 و100000.');
    }
    if (request.endsOn.isBefore(request.startsOn)) {
      throw const WirdProgramFailure('تاريخ النهاية يسبق تاريخ البداية.');
    }
    final validScope = switch (request.scope) {
      WirdAssignmentScope.organization =>
        request.branchIds.isEmpty &&
            request.classIds.isEmpty &&
            request.roles.isEmpty &&
            request.userIds.isEmpty,
      WirdAssignmentScope.branch =>
        request.branchIds.length == 1 &&
            request.classIds.isEmpty &&
            request.roles.isEmpty &&
            request.userIds.isEmpty,
      WirdAssignmentScope.multipleBranches =>
        request.branchIds.length >= 2 &&
            request.classIds.isEmpty &&
            request.roles.isEmpty &&
            request.userIds.isEmpty,
      WirdAssignmentScope.schoolClass =>
        request.classIds.length == 1 &&
            request.branchIds.isEmpty &&
            request.roles.isEmpty &&
            request.userIds.isEmpty,
      WirdAssignmentScope.role =>
        request.roles.isNotEmpty &&
            request.branchIds.isEmpty &&
            request.classIds.isEmpty &&
            request.userIds.isEmpty,
      WirdAssignmentScope.user =>
        request.userIds.length == 1 &&
            request.branchIds.isEmpty &&
            request.classIds.isEmpty &&
            request.roles.isEmpty,
    };
    if (!validScope) {
      throw const WirdProgramFailure('اختيار نطاق التكليف غير مكتمل.');
    }
  }

  Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on WirdProgramFailure {
      rethrow;
    } catch (_) {
      throw WirdProgramFailure(message);
    }
  }

  String _dateOnly(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}-$month-$day';
  }
}
