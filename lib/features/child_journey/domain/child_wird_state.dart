import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

part 'child_wird_state.freezed.dart';

@freezed
abstract class EarnedBadge with _$EarnedBadge {
  const factory EarnedBadge({
    required String code,
    required String name,
    required String emoji,
    required String description,
  }) = _EarnedBadge;
}

@freezed
abstract class ChildReward with _$ChildReward {
  const factory ChildReward({
    @Default(0) int points,
    @Default(0) int completedWirds,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(<EarnedBadge>[]) List<EarnedBadge> badges,
    String? badge,
  }) = _ChildReward;
}

@freezed
abstract class ChildWirdState with _$ChildWirdState {
  const factory ChildWirdState({
    ManagedWird? wird,
    @Default(ChildReward()) ChildReward reward,
  }) = _ChildWirdState;
}
