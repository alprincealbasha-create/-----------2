import 'dart:async';

import 'package:ward_al_rawdah/features/auth/domain/auth_repository.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.currentUserId, this.role = AppRole.student});

  final StreamController<String?> _userIds =
      StreamController<String?>.broadcast();

  @override
  String? currentUserId;

  AppRole role;
  Object? signInError;
  Object? roleError;
  var signInCalls = 0;
  var signOutCalls = 0;
  var studentSignInCalls = 0;

  @override
  Stream<String?> get userIdChanges => _userIds.stream;

  @override
  Future<AuthUser> loadAuthorizationContext(String userId) async {
    if (roleError case final error?) {
      throw error;
    }
    return AuthUser(
      id: userId,
      organizationId: 'organization-1',
      branchId: role == AppRole.organizationAdmin ? null : 'branch-1',
      classId: role == AppRole.student ? 'class-1' : null,
      role: role,
    );
  }

  @override
  Future<void> signInStudent({
    required String organizationCode,
    required String studentCode,
    required String pin,
  }) async {
    studentSignInCalls++;
    if (signInError case final error?) throw error;
    currentUserId = 'signed-in-student';
    _userIds.add(currentUserId);
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    signInCalls++;
    if (signInError case final error?) {
      throw error;
    }
    currentUserId = 'signed-in-user';
    _userIds.add(currentUserId);
  }

  @override
  Future<void> signOut() async {
    signOutCalls++;
    currentUserId = null;
    _userIds.add(null);
  }

  void emitUser(String? userId) {
    currentUserId = userId;
    _userIds.add(userId);
  }

  Future<void> dispose() => _userIds.close();
}
