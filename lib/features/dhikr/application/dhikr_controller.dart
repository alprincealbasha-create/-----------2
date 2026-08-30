import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/dhikr/data/dhikr_providers.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_repository.dart';

final dhikrControllerProvider =
    AsyncNotifierProvider<DhikrController, DhikrCounter?>(DhikrController.new);

class DhikrController extends AsyncNotifier<DhikrCounter?> {
  bool _syncing = false;

  DhikrRepository get _repository => ref.read(dhikrRepositoryProvider);

  @override
  Future<DhikrCounter?> build() async {
    ref.listen(connectivityChangesProvider, (_, next) {
      final results = next.value;
      if (results != null && !results.contains(ConnectivityResult.none)) {
        unawaited(sync());
      }
    });
    final current = await _repository.loadCurrent(_userId);
    if ((current?.pendingSyncCount ?? 0) > 0) {
      unawaited(Future<void>.microtask(sync));
    }
    return current;
  }

  Future<void> createCounter({
    required String title,
    required int target,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repository.createCounter(
        userId: _userId,
        title: title,
        target: target,
      ),
    );
  }

  Future<void> openManagedWird({
    required String wirdId,
    required String title,
    required int target,
  }) async {
    final current = state.value;
    if (current?.managedWirdId == wirdId) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repository.createCounter(
        userId: _userId,
        title: title,
        target: target,
        managedWirdId: wirdId,
      ),
    );
  }

  Future<void> increment() async {
    final current = state.value;
    if (current == null ||
        current.completionState == DhikrCompletionState.completed) {
      return;
    }
    try {
      final updated = await _repository.increment(
        userId: _userId,
        sessionId: current.id,
      );
      state = AsyncData(updated);
      unawaited(sync());
    } on DhikrFailure catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> sync() async {
    if (_syncing) return;
    final userId = _currentUserId;
    if (userId == null) return;
    _syncing = true;
    var retry = false;
    try {
      final updated = await _repository.syncPending(userId);
      if (updated != null) {
        state = AsyncData(updated);
        retry = updated.syncState == DhikrSyncState.pending;
      }
    } finally {
      _syncing = false;
    }
    if (retry) unawaited(sync());
  }

  String get _userId {
    return _currentUserId ??
        (throw const DhikrFailure('يجب تسجيل الدخول أولًا.'));
  }

  String? get _currentUserId => switch (ref.read(authControllerProvider)) {
    AuthAuthenticated(:final user) => user.id,
    _ => null,
  };
}
