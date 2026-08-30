import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_repository.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';

import 'fake_auth_repository.dart';

void main() {
  test('restores an existing session and resolves its role', () async {
    final repository = FakeAuthRepository(
      currentUserId: 'member-1',
      role: AppRole.member,
    );
    final container = _container(repository);
    addTearDown(container.dispose);
    addTearDown(repository.dispose);

    container.read(authControllerProvider);
    await pumpEventQueue();

    expect(
      container.read(authControllerProvider),
      const AuthState.authenticated(
        AuthUser(id: 'member-1', role: AppRole.member),
      ),
    );
  });

  test('starts unauthenticated when no session exists', () async {
    final repository = FakeAuthRepository();
    final container = _container(repository);
    addTearDown(container.dispose);
    addTearDown(repository.dispose);

    container.read(authControllerProvider);
    await pumpEventQueue();

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(),
    );
  });

  test('signs in and resolves the admin role', () async {
    final repository = FakeAuthRepository(role: AppRole.admin);
    final container = _container(repository);
    addTearDown(container.dispose);
    addTearDown(repository.dispose);
    await pumpEventQueue();

    await container
        .read(authControllerProvider.notifier)
        .signIn(email: 'admin@example.com', password: 'secret1');
    await pumpEventQueue();

    expect(repository.signInCalls, 1);
    expect(
      container.read(authControllerProvider),
      const AuthState.authenticated(
        AuthUser(id: 'signed-in-user', role: AppRole.admin),
      ),
    );
  });

  test('keeps a safe unauthenticated state on sign-in failure', () async {
    final repository = FakeAuthRepository()
      ..signInError = const SignInFailure('بيانات الدخول غير صحيحة');
    final container = _container(repository);
    addTearDown(container.dispose);
    addTearDown(repository.dispose);
    await pumpEventQueue();

    await container
        .read(authControllerProvider.notifier)
        .signIn(email: 'user@example.com', password: 'wrong1');

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(message: 'بيانات الدخول غير صحيحة'),
    );
  });

  test('denies routing when the role cannot be resolved', () async {
    final repository = FakeAuthRepository(currentUserId: 'user-1')
      ..roleError = const RoleResolutionFailure('تعذر تحديد الدور');
    final container = _container(repository);
    addTearDown(container.dispose);
    addTearDown(repository.dispose);

    container.read(authControllerProvider);
    await pumpEventQueue();

    expect(
      container.read(authControllerProvider),
      const AuthState.authorizationFailure('تعذر تحديد الدور'),
    );
  });

  test('reacts to session sign-out events', () async {
    final repository = FakeAuthRepository(currentUserId: 'user-1');
    final container = _container(repository);
    addTearDown(container.dispose);
    addTearDown(repository.dispose);
    container.read(authControllerProvider);
    await pumpEventQueue();

    repository.emitUser(null);
    await pumpEventQueue();

    expect(
      container.read(authControllerProvider),
      const AuthState.unauthenticated(),
    );
  });
}

ProviderContainer _container(FakeAuthRepository repository) {
  return ProviderContainer(
    overrides: [authRepositoryProvider.overrideWithValue(repository)],
  );
}
