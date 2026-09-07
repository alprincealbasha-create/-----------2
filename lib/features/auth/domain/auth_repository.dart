import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';

abstract interface class AuthRepository {
  String? get currentUserId;

  Stream<String?> get userIdChanges;

  Future<void> signIn({required String email, required String password});

  Future<void> signInStudent({
    required String organizationCode,
    required String studentCode,
    required String pin,
  });

  Future<void> signOut();

  Future<AuthUser> loadAuthorizationContext(String userId);
}

class StudentSignInFailure extends SignInFailure {
  const StudentSignInFailure(super.userMessage);
}

class SignInFailure implements Exception {
  const SignInFailure(this.userMessage);

  final String userMessage;
}

class RoleResolutionFailure implements Exception {
  const RoleResolutionFailure(this.userMessage);

  final String userMessage;
}

class SignOutFailure implements Exception {
  const SignOutFailure(this.userMessage);

  final String userMessage;
}
