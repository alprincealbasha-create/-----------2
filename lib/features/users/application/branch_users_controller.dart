import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';
import 'package:ward_al_rawdah/features/users/data/branch_users_providers.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_users_repository.dart';

final branchUsersProvider =
    AsyncNotifierProvider<BranchUsersController, List<ManagedUser>>(
      BranchUsersController.new,
    );

class BranchUsersController extends AsyncNotifier<List<ManagedUser>> {
  BranchUsersRepository get _repository =>
      ref.read(branchUsersRepositoryProvider);

  @override
  Future<List<ManagedUser>> build() async {
    final management = ref.watch(organizationManagementProvider);
    final branchId = switch (management) {
      AsyncData(:final value) => value.selectedBranchId,
      _ => null,
    };
    return branchId == null ? const [] : _repository.listUsers(branchId);
  }

  Future<void> refresh() => _replaceWith(_loadCurrentBranch());

  Future<void> createUser({
    required String? classId,
    required ManagedUserType userType,
    required String fullName,
    DateTime? birthDate,
  }) {
    final branchId = _requiredBranchId();
    return _replaceWith(() async {
      await _repository.createUser(
        branchId: branchId,
        classId: classId,
        userType: userType,
        fullName: fullName,
        birthDate: birthDate,
      );
      return _repository.listUsers(branchId);
    }());
  }

  Future<void> updateUser(ManagedUser user) => _replaceWith(() async {
    await _repository.updateUser(user);
    return _repository.listUsers(user.branchId);
  }());

  Future<void> deleteUser(ManagedUser user) => _replaceWith(() async {
    await _repository.deleteUser(user.id);
    return _repository.listUsers(user.branchId);
  }());

  Future<List<ManagedUser>> _loadCurrentBranch() async {
    final branchId = _requiredBranchId();
    return _repository.listUsers(branchId);
  }

  String _requiredBranchId() {
    final management = ref.read(organizationManagementProvider);
    final branchId = switch (management) {
      AsyncData(:final value) => value.selectedBranchId,
      _ => null,
    };
    if (branchId == null) {
      throw const UserManagementFailure('اختر فرعًا أولًا.');
    }
    return branchId;
  }

  Future<void> _replaceWith(Future<List<ManagedUser>> operation) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => operation);
  }
}
