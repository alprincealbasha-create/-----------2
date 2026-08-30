import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_users_repository.dart';

class FakeBranchUsersRepository implements BranchUsersRepository {
  final Map<String, ManagedUser> users = {};
  var _nextId = 1;

  @override
  Future<List<ManagedUser>> listUsers(String branchId) async {
    final result = users.values
        .where((item) => item.branchId == branchId)
        .toList();
    result.sort((left, right) => left.fullName.compareTo(right.fullName));
    return result;
  }

  @override
  Future<ManagedUser> createUser({
    required String branchId,
    required String? classId,
    required ManagedUserType userType,
    required String fullName,
    DateTime? birthDate,
  }) async {
    validateUserAssignment(userType: userType, classId: classId);
    final normalizedName = _name(fullName);
    final user = ManagedUser(
      id: 'user-${_nextId++}',
      branchId: branchId,
      classId: classId,
      userType: userType,
      fullName: normalizedName,
      birthDate: birthDate,
    );
    users[user.id] = user;
    return user;
  }

  @override
  Future<ManagedUser> updateUser(ManagedUser user) async {
    if (!users.containsKey(user.id)) {
      throw const UserManagementFailure('المستخدم غير موجود.');
    }
    validateUserAssignment(userType: user.userType, classId: user.classId);
    final updated = user.copyWith(fullName: _name(user.fullName));
    users[user.id] = updated;
    return updated;
  }

  @override
  Future<void> deleteUser(String userId) async {
    if (users.remove(userId) == null) {
      throw const UserManagementFailure('المستخدم غير موجود.');
    }
  }

  String _name(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw const UserManagementFailure('الاسم مطلوب.');
    }
    return normalized;
  }
}
