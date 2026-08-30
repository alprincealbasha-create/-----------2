import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_repository.dart';
import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_state.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

class SupabaseChildWirdRepository implements ChildWirdRepository {
  SupabaseChildWirdRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<ChildWirdState> loadHome() async {
    try {
      final today = _dateOnly(DateTime.now());
      final wirdRow = await _client
          .from('managed_wirds')
          .select(
            'id, branch_id, assigned_user_id, title, details, target_count, '
            'status, assigned_at, completed_at, wird_program_id, '
            'dhikr_definition_id, dhikr_title_snapshot, '
            'dhikr_text_snapshot, available_from, available_until, '
            'availability_timezone',
          )
          .inFilter('status', ['assigned', 'completed'])
          .isFilter('deleted_at', null)
          .or('available_from.is.null,available_from.lte.$today')
          .or('available_until.is.null,available_until.gte.$today')
          .order('assigned_at', ascending: false)
          .limit(1)
          .maybeSingle();
      final rewardRow = await _client
          .from('child_reward_summaries')
          .select('points, completed_wirds, current_streak, best_streak, badge')
          .limit(1)
          .maybeSingle();
      final badgeRows = await _client
          .from('badge_awards')
          .select(
            'awarded_at, badge_definitions!inner('
            'code, name, emoji, description)',
          )
          .order('awarded_at', ascending: true);

      return ChildWirdState(
        wird: wirdRow == null ? null : ManagedWird.fromJson(wirdRow),
        reward: rewardRow == null
            ? const ChildReward()
            : ChildReward(
                points: rewardRow['points'] as int? ?? 0,
                completedWirds: rewardRow['completed_wirds'] as int? ?? 0,
                currentStreak: rewardRow['current_streak'] as int? ?? 0,
                bestStreak: rewardRow['best_streak'] as int? ?? 0,
                badges: badgeRows
                    .map((row) {
                      final badge =
                          row['badge_definitions'] as Map<String, dynamic>;
                      return EarnedBadge(
                        code: badge['code'] as String,
                        name: badge['name'] as String,
                        emoji: badge['emoji'] as String,
                        description: badge['description'] as String,
                      );
                    })
                    .toList(growable: false),
                badge: rewardRow['badge'] as String?,
              ),
      );
    } catch (_) {
      throw const ChildWirdFailure('تعذر تحميل ورد اليوم.');
    }
  }

  String _dateOnly(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}-$month-$day';
  }
}
