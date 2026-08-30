import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/badges/domain/badge_models.dart';
import 'package:ward_al_rawdah/features/badges/domain/badges_repository.dart';

class SupabaseBadgesRepository implements BadgesRepository {
  SupabaseBadgesRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<BadgeManagementState> load(String? branchId) async {
    try {
      final rows = await _client
          .from('badge_definitions')
          .select('id, name, emoji, description')
          .eq('award_type', 'manual')
          .eq('is_enabled', true)
          .order('display_order');
      final manualBadges = rows
          .map(
            (row) =>
                ManualBadgeDefinition.fromJson(Map<String, Object?>.from(row)),
          )
          .toList(growable: false);
      if (branchId == null) {
        return BadgeManagementState(manualBadges: manualBadges);
      }
      final rewardResult = await _client.rpc(
        'get_branch_child_rewards',
        params: {'p_branch_id': branchId},
      );
      final rewardRows = rewardResult as List<dynamic>;
      return BadgeManagementState(
        manualBadges: manualBadges,
        childRewards: rewardRows
            .map(
              (row) => ChildRewardOverview.fromRpc(
                Map<String, Object?>.from(row as Map),
              ),
            )
            .toList(growable: false),
      );
    } catch (_) {
      throw const BadgeManagementFailure('تعذر تحميل الأوسمة الإدارية.');
    }
  }

  @override
  Future<void> awardManualBadge({
    required String badgeId,
    required String branchUserId,
  }) async {
    try {
      await _client.rpc<void>(
        'award_manual_badge',
        params: {'p_badge_id': badgeId, 'p_branch_user_id': branchUserId},
      );
    } catch (_) {
      throw const BadgeManagementFailure('تعذر منح الوسام.');
    }
  }
}
