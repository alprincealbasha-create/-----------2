import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_models.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_repository.dart';

class SupabaseWirdAssignmentRepository implements WirdAssignmentRepository {
  SupabaseWirdAssignmentRepository(this._client);
  final SupabaseClient _client;

  @override
  Future<WirdManagementData> loadManagementData(
    String organizationId,
  ) => _guard('تعذر تحميل بيانات الأوراد.', () async {
    final results = await Future.wait([
      _client
          .from('wirds')
          .select(
            'id,dhikr_id,title,description,target_count,start_at,end_at,status',
          )
          .order('created_at', ascending: false),
      _client
          .from('dhikr_definitions')
          .select(
            'id,owner_branch_id,title,display_text,description,default_target,status,created_by,source_reference,content_version,content_checksum,reviewed_by,reviewed_at',
          )
          .eq('status', 'approved')
          .order('title'),
      _client
          .from('branches')
          .select('id,name')
          .eq('organization_id', organizationId)
          .eq('status', 'active')
          .order('name'),
      _client
          .from('classes')
          .select('id,branch_id,name')
          .eq('organization_id', organizationId)
          .eq('status', 'active')
          .order('name'),
      _client
          .from('profiles')
          .select('id,branch_id,display_name,role')
          .eq('organization_id', organizationId)
          .eq('status', 'active')
          .order('display_name'),
    ]);
    return WirdManagementData(
      wirds: (results[0] as List)
          .map(
            (row) =>
                WirdContent.fromJson(Map<String, dynamic>.from(row as Map)),
          )
          .toList(),
      dhikr: (results[1] as List)
          .map(
            (row) =>
                DhikrDefinition.fromJson(Map<String, Object?>.from(row as Map)),
          )
          .toList(),
      branches: (results[2] as List).map((row) {
        final value = Map<String, dynamic>.from(row as Map);
        return AudienceBranch(
          id: value['id'] as String,
          name: value['name'] as String,
        );
      }).toList(),
      classes: (results[3] as List).map((row) {
        final value = Map<String, dynamic>.from(row as Map);
        return AudienceClass(
          id: value['id'] as String,
          branchId: value['branch_id'] as String,
          name: value['name'] as String,
        );
      }).toList(),
      users: (results[4] as List).map((row) {
        final value = Map<String, dynamic>.from(row as Map);
        return AudienceUser(
          id: value['id'] as String,
          branchId: value['branch_id'] as String?,
          name: value['display_name'] as String,
          role: value['role'] as String,
        );
      }).toList(),
    );
  });

  @override
  Future<int> createWird(String organizationId, WirdDraft draft) =>
      _guard('تعذر إنشاء الورد وتكليفه.', () async {
        _validateDraft(draft);
        final result = await _client.rpc(
          'create_wird_with_assignments',
          params: {
            'p_organization_id': organizationId,
            'p_dhikr_id': draft.dhikrId,
            'p_title': draft.title.trim(),
            'p_description': _optional(draft.description),
            'p_target_count': draft.targetCount,
            'p_start_on': _dateOnly(draft.startAt),
            'p_end_on': _dateOnly(draft.endAt),
            'p_assignments': draft.assignments
                .map((item) => item.toJson())
                .toList(),
          },
        );
        final rows = result as List;
        return rows.isEmpty
            ? 0
            : ((rows.first as Map)['materialized_count'] as num).toInt();
      });

  @override
  Future<void> updateWird(String organizationId, WirdContent wird) =>
      _guard('تعذر تحديث الورد.', () async {
        await _client.rpc(
          'save_wird',
          params: {
            'p_id': wird.id,
            'p_organization_id': organizationId,
            'p_dhikr_id': wird.dhikrId,
            'p_title': wird.title.trim(),
            'p_description': _optional(wird.description),
            'p_target_count': wird.targetCount,
            'p_start_at': wird.startAt.toUtc().toIso8601String(),
            'p_end_at': wird.endAt.toUtc().toIso8601String(),
            'p_status': wird.status.value,
          },
        );
      });

  @override
  Future<List<TodayWird>> listToday() =>
      _guard('تعذر تحميل ورد اليوم.', () async {
        final rows = await _client.rpc('list_todays_wirds') as List;
        return rows
            .map(
              (row) =>
                  TodayWird.fromJson(Map<String, dynamic>.from(row as Map)),
            )
            .toList();
      });

  void _validateDraft(WirdDraft draft) {
    if (draft.title.trim().isEmpty ||
        draft.targetCount < 1 ||
        draft.targetCount > 100000 ||
        draft.endAt.isBefore(draft.startAt) ||
        draft.assignments.isEmpty) {
      throw const WirdAssignmentFailure(
        'أكمل بيانات الورد ونطاق التكليف بصورة صحيحة.',
      );
    }
  }

  String? _optional(String? value) =>
      value == null || value.trim().isEmpty ? null : value.trim();

  String _dateOnly(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on WirdAssignmentFailure {
      rethrow;
    } catch (_) {
      throw WirdAssignmentFailure(message);
    }
  }
}
