import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';

abstract interface class AuthRepository {
  String? get currentUserId;

  Stream<String?> get userIdChanges;

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  Future<AppRole> loadRole(String userId);
}

class SignInFailure implements Exception {
  const SignInFailure(this.userMessage);

  final String userMessage;
}

class RoleResolutionFailure implements Exception {
  const RoleResolutionFailure(this.userMessage);

  final String userMessage;
}
