import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthLoading;

  const factory AuthState.unauthenticated({String? message}) =
      AuthUnauthenticated;

  const factory AuthState.authenticated(AuthUser user) = AuthAuthenticated;

  const factory AuthState.authorizationFailure(String message) =
      AuthAuthorizationFailure;
}
