import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';
import 'package:ward_al_rawdah/features/dhikr/application/dhikr_controller.dart';
import 'package:ward_al_rawdah/features/dhikr/data/dhikr_providers.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_repository.dart';

void main() {
  test(
    'syncs a persisted queue immediately after controller restart',
    () async {
      final repository = _RestartRepository();
      final container = ProviderContainer(
        overrides: [
          authControllerProvider.overrideWith(_AuthenticatedController.new),
          dhikrRepositoryProvider.overrideWithValue(repository),
          connectivityChangesProvider.overrideWith(
            (ref) => const Stream<List<ConnectivityResult>>.empty(),
          ),
        ],
      );
      addTearDown(container.dispose);

      final restored = await container.read(dhikrControllerProvider.future);
      expect(restored?.count, 42);
      expect(restored?.pendingSyncCount, 2);

      await pumpEventQueue();
      expect(repository.syncCalls, 1);
      expect(
        container.read(dhikrControllerProvider).value?.pendingSyncCount,
        0,
      );
    },
  );
}

class _AuthenticatedController extends AuthController {
  @override
  AuthState build() => const AuthState.authenticated(
    AuthUser(id: 'user-1', role: AppRole.member),
  );
}

class _RestartRepository implements DhikrRepository {
  int syncCalls = 0;

  DhikrCounter get _pending => const DhikrCounter(
    id: 'session-1',
    title: 'عداد محفوظ',
    target: 100,
    count: 42,
    completionState: DhikrCompletionState.inProgress,
    pendingSyncCount: 2,
    syncState: DhikrSyncState.pending,
  );

  @override
  Future<DhikrCounter?> loadCurrent(String userId) async => _pending;

  @override
  Future<DhikrCounter?> syncPending(String userId) async {
    syncCalls += 1;
    return _pending.copyWith(
      pendingSyncCount: 0,
      syncState: DhikrSyncState.synced,
    );
  }

  @override
  Future<DhikrCounter> createCounter({
    required String userId,
    required String title,
    required int target,
    String? managedWirdId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<DhikrCounter> increment({
    required String userId,
    required String sessionId,
  }) {
    throw UnimplementedError();
  }
}
