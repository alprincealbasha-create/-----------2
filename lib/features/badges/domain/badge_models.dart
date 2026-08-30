import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_models.freezed.dart';

@freezed
abstract class ManualBadgeDefinition with _$ManualBadgeDefinition {
  const factory ManualBadgeDefinition({
    required String id,
    required String name,
    required String emoji,
    required String description,
  }) = _ManualBadgeDefinition;

  factory ManualBadgeDefinition.fromJson(Map<String, Object?> row) {
    return ManualBadgeDefinition(
      id: row['id']! as String,
      name: row['name']! as String,
      emoji: row['emoji']! as String,
      description: row['description']! as String,
    );
  }
}

@freezed
abstract class ChildRewardOverview with _$ChildRewardOverview {
  const factory ChildRewardOverview({
    required String childId,
    required String childName,
    String? className,
    @Default(0) int completedWirds,
    @Default(0) int points,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(<RewardBadgeSummary>[]) List<RewardBadgeSummary> badges,
  }) = _ChildRewardOverview;

  factory ChildRewardOverview.fromRpc(Map<String, Object?> row) {
    final badges = (row['earned_badges'] as List<dynamic>? ?? const [])
        .map(
          (item) => RewardBadgeSummary.fromJson(
            Map<String, Object?>.from(item as Map),
          ),
        )
        .toList(growable: false);
    return ChildRewardOverview(
      childId: row['child_id']! as String,
      childName: row['child_name']! as String,
      className: row['class_name'] as String?,
      completedWirds: (row['completed_wirds'] as num?)?.toInt() ?? 0,
      points: (row['points'] as num?)?.toInt() ?? 0,
      currentStreak: (row['current_streak'] as num?)?.toInt() ?? 0,
      bestStreak: (row['best_streak'] as num?)?.toInt() ?? 0,
      badges: badges,
    );
  }
}

@freezed
abstract class RewardBadgeSummary with _$RewardBadgeSummary {
  const factory RewardBadgeSummary({
    required String code,
    required String name,
    required String emoji,
    required String description,
  }) = _RewardBadgeSummary;

  factory RewardBadgeSummary.fromJson(Map<String, Object?> row) {
    return RewardBadgeSummary(
      code: row['code']! as String,
      name: row['name']! as String,
      emoji: row['emoji']! as String,
      description: row['description']! as String,
    );
  }
}

@freezed
abstract class BadgeManagementState with _$BadgeManagementState {
  const factory BadgeManagementState({
    @Default(<ManualBadgeDefinition>[])
    List<ManualBadgeDefinition> manualBadges,
    @Default(<ChildRewardOverview>[]) List<ChildRewardOverview> childRewards,
  }) = _BadgeManagementState;
}
