import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_users_repository.dart';

import 'fake_branch_users_repository.dart';

void main() {
  group('Branch users', () {
    test(
      'creates all four user types with valid branch and class links',
      () async {
        final repository = FakeBranchUsersRepository();

        final child = await repository.createUser(
          branchId: 'damascus',
          classId: 'class-a',
          userType: ManagedUserType.child,
          fullName: 'ليان أحمد',
        );
        final teacher = await repository.createUser(
          branchId: 'damascus',
          classId: 'class-a',
          userType: ManagedUserType.teacher,
          fullName: 'سارة محمود',
        );
        final administrator = await repository.createUser(
          branchId: 'damascus',
          classId: null,
          userType: ManagedUserType.administrator,
          fullName: 'نور علي',
        );
        final manager = await repository.createUser(
          branchId: 'damascus',
          classId: null,
          userType: ManagedUserType.branchManager,
          fullName: 'أحمد خالد',
        );

        expect(child.classId, 'class-a');
        expect(teacher.classId, 'class-a');
        expect(administrator.classId, isNull);
        expect(manager.classId, isNull);
        expect(
          (await repository.listUsers('damascus')).map((item) => item.userType),
          containsAll(ManagedUserType.values),
        );
      },
    );

    test('child and teacher require a class', () {
      for (final type in [ManagedUserType.child, ManagedUserType.teacher]) {
        expect(
          () => validateUserAssignment(userType: type, classId: null),
          throwsA(isA<UserManagementFailure>()),
        );
      }
    });

    test('administrator and branch manager cannot be assigned a class', () {
      for (final type in [
        ManagedUserType.administrator,
        ManagedUserType.branchManager,
      ]) {
        expect(
          () => validateUserAssignment(userType: type, classId: 'class-a'),
          throwsA(isA<UserManagementFailure>()),
        );
      }
    });

    test('updates and deletes a managed user', () async {
      final repository = FakeBranchUsersRepository();
      final user = await repository.createUser(
        branchId: 'damascus',
        classId: 'class-a',
        userType: ManagedUserType.teacher,
        fullName: 'سارة محمود',
      );

      final updated = await repository.updateUser(
        user.copyWith(fullName: 'سارة أحمد', classId: 'class-b'),
      );
      expect(updated.fullName, 'سارة أحمد');
      expect(updated.classId, 'class-b');

      await repository.deleteUser(user.id);
      expect(await repository.listUsers('damascus'), isEmpty);
    });
  });
}
