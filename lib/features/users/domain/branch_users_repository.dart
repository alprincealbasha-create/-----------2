import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

abstract interface class BranchUsersRepository {
  Future<List<ManagedUser>> listUsers(String branchId);

  Future<ManagedUser> createUser({
    required String branchId,
    required String? classId,
    required ManagedUserType userType,
    required String fullName,
    DateTime? birthDate,
  });

  Future<ManagedUser> updateUser(ManagedUser user);

  Future<void> deleteUser(String userId);
}

class UserManagementFailure implements Exception {
  const UserManagementFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}

void validateUserAssignment({
  required ManagedUserType userType,
  required String? classId,
}) {
  final hasClass = classId != null && classId.trim().isNotEmpty;
  if (userType.requiresClass && !hasClass) {
    throw UserManagementFailure(
      'يجب اختيار صف عند إضافة ${userType.arabicLabel}.',
    );
  }
  if (!userType.requiresClass && hasClass) {
    throw UserManagementFailure('${userType.arabicLabel} يرتبط بالفرع دون صف.');
  }
}
