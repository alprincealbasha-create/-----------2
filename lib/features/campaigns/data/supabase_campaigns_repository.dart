import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaign_models.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaigns_repository.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';

class SupabaseCampaignsRepository implements CampaignsRepository {
  SupabaseCampaignsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<CampaignManagementState> load(String organizationId) =>
      _guard('تعذر تحميل الحملات.', () async {
        final result = await _client.rpc(
          'get_campaign_dashboard',
          params: {'p_organization_id': organizationId},
        );
        final dhikrRows = await _client
            .from('dhikr_definitions')
            .select(
              'id, title, display_text, description, default_target, status, '
              'created_by, source_reference, content_version, '
              'content_checksum, reviewed_by, reviewed_at',
            )
            .eq('status', 'approved')
            .order('title');
        return CampaignManagementState(
          campaigns: (result as List<dynamic>)
              .map(
                (row) => CampaignDashboardItem.fromRpc(
                  Map<String, Object?>.from(row as Map),
                ),
              )
              .toList(growable: false),
          dhikrDefinitions: dhikrRows
              .map(DhikrDefinition.fromJson)
              .toList(growable: false),
        );
      });

  @override
  Future<void> create({
    required String organizationId,
    required String name,
    required String dhikrDefinitionId,
    required int targetCount,
  }) => _guard('تعذر إنشاء الحملة.', () async {
    if (name.trim().isEmpty) {
      throw const CampaignFailure('اسم الحملة مطلوب.');
    }
    if (targetCount < 1 || targetCount > 1000000000) {
      throw const CampaignFailure('أدخل هدفًا بين 1 و1000000000.');
    }
    await _client.rpc(
      'create_campaign',
      params: {
        'p_organization_id': organizationId,
        'p_name': name.trim(),
        'p_dhikr_definition_id': dhikrDefinitionId,
        'p_target_count': targetCount,
      },
    );
  });

  Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on CampaignFailure {
      rethrow;
    } catch (_) {
      throw CampaignFailure(message);
    }
  }
}
