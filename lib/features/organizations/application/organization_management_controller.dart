import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_state.dart';
import 'package:ward_al_rawdah/features/organizations/data/organizations_providers.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organizations_repository.dart';

final organizationManagementProvider =
    AsyncNotifierProvider<
      OrganizationManagementController,
      OrganizationManagementState
    >(OrganizationManagementController.new);

class OrganizationManagementController
    extends AsyncNotifier<OrganizationManagementState> {
  OrganizationsRepository get _repository =>
      ref.read(organizationsRepositoryProvider);

  @override
  Future<OrganizationManagementState> build() => _load();

  Future<void> refresh() => _replaceWith(_load());

  Future<void> selectOrganization(String organizationId) =>
      _replaceWith(_load(preferredOrganizationId: organizationId));

  Future<void> selectBranch(String branchId) {
    final current = _current;
    return _replaceWith(
      _load(
        preferredOrganizationId: current?.selectedOrganizationId,
        preferredBranchId: branchId,
      ),
    );
  }

  Future<void> selectClass(String classId) {
    final current = _current;
    return _replaceWith(
      _load(
        preferredOrganizationId: current?.selectedOrganizationId,
        preferredBranchId: current?.selectedBranchId,
        preferredClassId: classId,
      ),
    );
  }

  Future<void> createOrganization(String name) => _replaceWith(() async {
    final created = await _repository.createOrganization(name);
    return _load(preferredOrganizationId: created.id);
  }());

  Future<void> updateOrganization(Organization organization) =>
      _replaceWith(() async {
        final updated = await _repository.updateOrganization(organization);
        return _load(preferredOrganizationId: updated.id);
      }());

  Future<void> deleteOrganization(String organizationId) =>
      _replaceWith(() async {
        await _repository.deleteOrganization(organizationId);
        return _load();
      }());

  Future<void> createBranch({required String name, String? city}) {
    final organizationId = _requireCurrent(
      _current?.selectedOrganizationId,
      'اختر مؤسسة أولًا.',
    );
    return _replaceWith(() async {
      final created = await _repository.createBranch(
        organizationId: organizationId,
        name: name,
        city: city,
      );
      return _load(
        preferredOrganizationId: organizationId,
        preferredBranchId: created.id,
      );
    }());
  }

  Future<void> updateBranch(Branch branch) => _replaceWith(() async {
    final updated = await _repository.updateBranch(branch);
    return _load(
      preferredOrganizationId: updated.organizationId,
      preferredBranchId: updated.id,
    );
  }());

  Future<void> deleteBranch(String branchId) {
    final organizationId = _current?.selectedOrganizationId;
    return _replaceWith(() async {
      await _repository.deleteBranch(branchId);
      return _load(preferredOrganizationId: organizationId);
    }());
  }

  Future<void> createClass(String name) {
    final current = _current;
    final branchId = _requireCurrent(
      current?.selectedBranchId,
      'اختر فرعًا أولًا.',
    );
    return _replaceWith(() async {
      final created = await _repository.createClass(
        branchId: branchId,
        name: name,
      );
      return _load(
        preferredOrganizationId: current?.selectedOrganizationId,
        preferredBranchId: branchId,
        preferredClassId: created.id,
      );
    }());
  }

  Future<void> updateClass(SchoolClass schoolClass) => _replaceWith(() async {
    final current = _current;
    final updated = await _repository.updateClass(schoolClass);
    return _load(
      preferredOrganizationId: current?.selectedOrganizationId,
      preferredBranchId: updated.branchId,
      preferredClassId: updated.id,
    );
  }());

  Future<void> deleteClass(String classId) {
    final current = _current;
    return _replaceWith(() async {
      await _repository.deleteClass(classId);
      return _load(
        preferredOrganizationId: current?.selectedOrganizationId,
        preferredBranchId: current?.selectedBranchId,
      );
    }());
  }

  Future<void> createChild({required String fullName, DateTime? birthDate}) {
    final current = _current;
    final classId = _requireCurrent(
      current?.selectedClassId,
      'اختر صفًا أولًا.',
    );
    return _replaceWith(() async {
      await _repository.createChild(
        classId: classId,
        fullName: fullName,
        birthDate: birthDate,
      );
      return _load(
        preferredOrganizationId: current?.selectedOrganizationId,
        preferredBranchId: current?.selectedBranchId,
        preferredClassId: classId,
      );
    }());
  }

  Future<void> updateChild(ChildRecord child) => _replaceWith(() async {
    final current = _current;
    final updated = await _repository.updateChild(child);
    return _load(
      preferredOrganizationId: current?.selectedOrganizationId,
      preferredBranchId: current?.selectedBranchId,
      preferredClassId: updated.classId,
    );
  }());

  Future<void> deleteChild(String childId) {
    final current = _current;
    return _replaceWith(() async {
      await _repository.deleteChild(childId);
      return _load(
        preferredOrganizationId: current?.selectedOrganizationId,
        preferredBranchId: current?.selectedBranchId,
        preferredClassId: current?.selectedClassId,
      );
    }());
  }

  OrganizationManagementState? get _current => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  Future<void> _replaceWith(
    Future<OrganizationManagementState> operation,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => operation);
  }

  Future<OrganizationManagementState> _load({
    String? preferredOrganizationId,
    String? preferredBranchId,
    String? preferredClassId,
  }) async {
    final organizations = await _repository.listOrganizations();
    final organizationId = _selectedId(
      organizations.map((item) => item.id).toList(growable: false),
      preferredOrganizationId,
    );
    final branches = organizationId == null
        ? const <Branch>[]
        : await _repository.listBranches(organizationId);
    final branchId = _selectedId(
      branches.map((item) => item.id).toList(growable: false),
      preferredBranchId,
    );
    final classes = branchId == null
        ? const <SchoolClass>[]
        : await _repository.listClasses(branchId);
    final classId = _selectedId(
      classes.map((item) => item.id).toList(growable: false),
      preferredClassId,
    );
    final children = classId == null
        ? const <ChildRecord>[]
        : await _repository.listChildren(classId);

    return OrganizationManagementState(
      organizations: organizations,
      branches: branches,
      classes: classes,
      children: children,
      selectedOrganizationId: organizationId,
      selectedBranchId: branchId,
      selectedClassId: classId,
    );
  }

  String? _selectedId(List<String> ids, String? preferredId) {
    if (preferredId != null && ids.contains(preferredId)) {
      return preferredId;
    }
    return ids.isEmpty ? null : ids.first;
  }

  String _requireCurrent(String? id, String message) {
    if (id == null) {
      throw OrganizationFailure(message);
    }
    return id;
  }
}
