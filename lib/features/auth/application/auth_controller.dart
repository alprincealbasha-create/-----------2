import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_repository.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  var _requestNumber = 0;
  var _disposed = false;

  @override
  AuthState build() {
    final repository = ref.watch(authRepositoryProvider);
    final subscription = repository.userIdChanges.listen(
      _resolveUser,
      onError: (_, _) => _showAuthorizationFailure(),
    );

    ref.onDispose(() {
      _disposed = true;
      unawaited(subscription.cancel());
    });

    final bootstrapRequest = _requestNumber;
    unawaited(
      Future<void>.microtask(() async {
        if (!_disposed && bootstrapRequest == _requestNumber) {
          await _resolveUser(repository.currentUserId);
        }
      }),
    );
    return const AuthState.loading();
  }

  Future<void> signIn({required String email, required String password}) async {
    final request = ++_requestNumber;
    state = const AuthState.loading();

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.signIn(email: email, password: password);
      if (request == _requestNumber) {
        await _resolveUser(repository.currentUserId);
      }
    } on SignInFailure catch (error) {
      if (!_disposed && request == _requestNumber) {
        state = AuthState.unauthenticated(message: error.userMessage);
      }
    } catch (_) {
      if (!_disposed && request == _requestNumber) {
        state = const AuthState.unauthenticated(
          message: 'تعذر تسجيل الدخول. حاول مرة أخرى.',
        );
      }
    }
  }

  Future<void> signInStudent({
    required String organizationCode,
    required String studentCode,
    required String pin,
  }) async {
    final request = ++_requestNumber;
    state = const AuthState.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.signInStudent(
        organizationCode: organizationCode,
        studentCode: studentCode,
        pin: pin,
      );
      if (request == _requestNumber) {
        await _resolveUser(repository.currentUserId);
      }
    } on SignInFailure catch (error) {
      if (!_disposed && request == _requestNumber) {
        state = AuthState.unauthenticated(message: error.userMessage);
      }
    } catch (_) {
      if (!_disposed && request == _requestNumber) {
        state = const AuthState.unauthenticated(
          message: 'تعذر تسجيل الدخول. حاول مرة أخرى.',
        );
      }
    }
  }

  Future<void> signOut() async {
    final previousState = state;
    ++_requestNumber;
    state = const AuthState.loading();

    try {
      await ref.read(authRepositoryProvider).signOut();
      if (!_disposed) {
        state = const AuthState.unauthenticated();
      }
    } catch (_) {
      if (!_disposed) {
        state = previousState;
      }
    }
  }

  Future<void> retryRoleResolution() async {
    state = const AuthState.loading();
    await _resolveUser(ref.read(authRepositoryProvider).currentUserId);
  }

  Future<void> _resolveUser(String? userId) async {
    final request = ++_requestNumber;
    if (userId == null) {
      if (!_disposed) {
        state = const AuthState.unauthenticated();
      }
      return;
    }

    if (!_disposed) {
      state = const AuthState.loading();
    }

    try {
      final user = await ref
          .read(authRepositoryProvider)
          .loadAuthorizationContext(userId);
      if (!_disposed && request == _requestNumber) {
        state = AuthState.authenticated(user);
      }
    } on RoleResolutionFailure catch (error) {
      if (!_disposed && request == _requestNumber) {
        state = AuthState.authorizationFailure(error.userMessage);
      }
    } catch (_) {
      if (!_disposed && request == _requestNumber) {
        _showAuthorizationFailure();
      }
    }
  }

  void _showAuthorizationFailure() {
    if (!_disposed) {
      state = const AuthState.authorizationFailure(
        'تعذر التحقق من صلاحية الحساب. أعد المحاولة.',
      );
    }
  }
}
