import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_models.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_repository.dart';

class SupabaseIntegrityRepository implements IntegrityRepository {
  SupabaseIntegrityRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<IntegrityFlag>> listFlags(String branchId) async {
    try {
      final result = await _client.rpc(
        'get_branch_integrity_flags',
        params: {'p_branch_id': branchId},
      );
      return (result as List<dynamic>)
          .map(
            (row) =>
                IntegrityFlag.fromRpc(Map<String, Object?>.from(row as Map)),
          )
          .toList(growable: false);
    } catch (_) {
      throw const IntegrityFailure('تعذر تحميل مؤشرات النزاهة.');
    }
  }

  @override
  Future<void> reviewFlag({
    required String flagId,
    required IntegrityFlagStatus status,
  }) async {
    if (status == IntegrityFlagStatus.open) {
      throw const IntegrityFailure('اختر نتيجة المراجعة.');
    }
    try {
      await _client.rpc<void>(
        'review_integrity_flag',
        params: {'p_flag_id': flagId, 'p_status': status.value},
      );
    } catch (_) {
      throw const IntegrityFailure('تعذر حفظ نتيجة المراجعة.');
    }
  }
}
