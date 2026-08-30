import 'package:freezed_annotation/freezed_annotation.dart';

part 'dhikr_counter.freezed.dart';

enum DhikrCompletionState { inProgress, completed }

enum DhikrSyncState { synced, pending, failed }

@freezed
abstract class DhikrCounter with _$DhikrCounter {
  const DhikrCounter._();

  const factory DhikrCounter({
    required String id,
    String? managedWirdId,
    required String title,
    required int target,
    required int count,
    required DhikrCompletionState completionState,
    required int pendingSyncCount,
    required DhikrSyncState syncState,
    DateTime? completedAt,
  }) = _DhikrCounter;

  double get progress => target <= 0 ? 0 : (count / target).clamp(0, 1);
}
