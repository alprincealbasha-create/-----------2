import 'dart:async';

import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.currentUserId, this.role = AppRole.member});

  final StreamController<String?> _userIds =
      StreamController<String?>.broadcast();

  @override
  String? currentUserId;

  AppRole role;
  Object? signInError;
  Object? roleError;
  var signInCalls = 0;
  var signOutCalls = 0;

  @override
  Stream<String?> get userIdChanges => _userIds.stream;

  @override
  Future<AppRole> loadRole(String userId) async {
    if (roleError case final error?) {
      throw error;
    }
    return role;
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
