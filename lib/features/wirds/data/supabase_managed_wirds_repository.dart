import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wirds_repository.dart';

class SupabaseManagedWirdsRepository implements ManagedWirdsRepository {
  SupabaseManagedWirdsRepository(this._client);

  final SupabaseClient _client;

  static const _fields =
      'id, branch_id, assigned_user_id, title, details, status, '
      'target_count, assigned_at, completed_at, wird_program_id, '
      'dhikr_definition_id, dhikr_title_snapshot, dhikr_text_snapshot, '
      'available_from, available_until, availability_timezone';

  @override
  Future<List<ManagedWird>> listWirds(String branchId) =>
      _guard('تعذر تحميل أوراد الفرع.', () async {
        final rows = await _client
            .from('managed_wirds')
            .select(_fields)
            .eq('branch_id', branchId)
            .isFilter('deleted_at', null)
            .order('updated_at', ascending: false);
        return rows.map(ManagedWird.fromJson).toList(growable: false);
      });

  @override
  Future<ManagedWird> createWird({
    required String branchId,
    required String title,
    required int targetCount,
    String? details,
  }) => _guard('تعذر إنشاء الورد.', () async {
    final row = await _client
        .from('managed_wirds')
        .insert({
          'branch_id': branchId,
          'title': _requiredTitle(title),
          'target_count': _requiredTarget(targetCount),
          'details': _optionalDetails(details),
        })
        .select(_fields)
        .single();
    return ManagedWird.fromJson(row);
  });

  @override
  Future<ManagedWird> updateWird(ManagedWird wird) {
    if (wird.status == ManagedWirdStatus.completed) {
      throw const WirdManagementFailure('لا يمكن تعديل ورد منتهٍ.');
    }
    return _guard('تعذر تعديل الورد.', () async {
      final row = await _client
          .from('managed_wirds')
          .update({
            'title': _requiredTitle(wird.title),
            'details': _optionalDetails(wird.details),
            'target_count': _requiredTarget(wird.targetCount),
          })
          .eq('id', wird.id)
          .select(_fields)
          .single();
      return ManagedWird.fromJson(row);
    });
  }

  @override
  Future<ManagedWird> assignWird({
    required ManagedWird wird,
    required String userId,
  }) {
    if (wird.status == ManagedWirdStatus.completed) {
      throw const WirdManagementFailure('لا يمكن تكليف ورد منتهٍ.');
    }
    return _guard('تعذر تكليف الورد.', () async {
      final row = await _client
          .from('managed_wirds')
          .update({
            'assigned_user_id': userId,
            'status': ManagedWirdStatus.assigned.value,
          })
          .eq('id', wird.id)
          .select(_fields)
          .single();
      return ManagedWird.fromJson(row);
    });
  }

  @override
  Future<ManagedWird> completeWird(ManagedWird wird) {
    if (wird.status != ManagedWirdStatus.assigned) {
      throw const WirdManagementFailure('يجب تكليف الورد قبل إنهائه.');
    }
    return _guard('تعذر إنهاء الورد.', () async {
      final row = await _client
          .from('managed_wirds')
          .update({'status': ManagedWirdStatus.completed.value})
          .eq('id', wird.id)
          .select(_fields)
          .single();
      return ManagedWird.fromJson(row);
    });
  }

  Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on WirdManagementFailure {
      rethrow;
    } catch (_) {
      throw WirdManagementFailure(message);
    }
  }

  String _requiredTitle(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw const WirdManagementFailure('عنوان الورد مطلوب.');
    }
    return normalized;
  }

  String? _optionalDetails(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  int _requiredTarget(int? value) {
    if (value == null || value < 1 || value > 100000) {
      throw const WirdManagementFailure('أدخل هدفًا بين 1 و100000.');
    }
    return value;
  }
}
