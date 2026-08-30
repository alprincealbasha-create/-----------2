import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class DhikrSyncGateway {
  Future<void> applyIncrement({
    required String operationId,
    required String sessionId,
    String? managedWirdId,
    required String title,
    required int target,
    required int delta,
    required DateTime createdAt,
  });
}

class SupabaseDhikrSyncGateway implements DhikrSyncGateway {
  SupabaseDhikrSyncGateway(this._client);

  final SupabaseClient _client;

  @override
  Future<void> applyIncrement({
    required String operationId,
    required String sessionId,
    String? managedWirdId,
    required String title,
    required int target,
    required int delta,
    required DateTime createdAt,
  }) async {
    if (managedWirdId != null) {
      await _client.rpc(
        'apply_assigned_wird_increment',
        params: {'p_operation_id': operationId, 'p_wird_id': managedWirdId},
      );
    } else {
      await _client.rpc(
        'apply_dhikr_increment',
        params: {
          'p_operation_id': operationId,
          'p_session_id': sessionId,
          'p_title': title,
          'p_target': target,
          'p_delta': delta,
          'p_client_created_at': createdAt.toUtc().toIso8601String(),
        },
      );
    }
  }
}
