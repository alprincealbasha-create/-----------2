import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_state.dart';
import 'package:ward_al_rawdah/features/organizations/data/organizations_providers.dart';

import 'fake_organizations_repository.dart';

void main() {
  test('creates Damascus branch, a class, and assigns a child to it', () async {
    final repository = FakeOrganizationsRepository();
    final container = ProviderContainer(
      overrides: [
        organizationsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await container.read(organizationManagementProvider.future);
    final controller = container.read(organizationManagementProvider.notifier);

    await controller.createOrganization('ورد الروضة');
    await controller.createBranch(name: 'فرع دمشق', city: 'دمشق');
    await controller.createClass('الصف التمهيدي');
    await controller.createChild(
      fullName: 'ليان أحمد',
      birthDate: DateTime(2021, 4, 12),
    );

    final state = _data(container);
    expect(state.organizations.single.name, 'ورد الروضة');
    expect(state.branches.single.name, 'فرع دمشق');
    expect(state.branches.single.city, 'دمشق');
    expect(state.classes.single.name, 'الصف التمهيدي');
    expect(state.children.single.fullName, 'ليان أحمد');
    expect(state.children.single.classId, state.classes.single.id);
    expect(state.classes.single.branchId, state.branches.single.id);
    expect(state.branches.single.organizationId, state.organizations.single.id);
  });

  test('supports update and delete operations at every level', () async {
    final repository = FakeOrganizationsRepository();
    final organization = await repository.createOrganization('المؤسسة');
    final branch = await repository.createBranch(
      organizationId: organization.id,
      name: 'الفرع',
    );
    final schoolClass = await repository.createClass(
      branchId: branch.id,
      name: 'الصف',
    );
    final child = await repository.createChild(
      classId: schoolClass.id,
      fullName: 'طفل',
    );

    expect(
      (await repository.updateOrganization(
        organization.copyWith(name: 'المؤسسة الجديدة'),
      )).name,
      'المؤسسة الجديدة',
    );
    expect(
      (await repository.updateBranch(branch.copyWith(name: 'فرع دمشق'))).name,
      'فرع دمشق',
    );
    expect(
      (await repository.updateClass(schoolClass.copyWith(name: 'التمهيدي')))
          .name,
      'التمهيدي',
    );
    expect(
      (await repository.updateChild(child.copyWith(fullName: 'ليان'))).fullName,
      'ليان',
    );

    await repository.deleteChild(child.id);
    expect(await repository.listChildren(schoolClass.id), isEmpty);
    await repository.deleteClass(schoolClass.id);
    expect(await repository.listClasses(branch.id), isEmpty);
    await repository.deleteBranch(branch.id);
    expect(await repository.listBranches(organization.id), isEmpty);
    await repository.deleteOrganization(organization.id);
    expect(await repository.listOrganizations(), isEmpty);
  });
}

OrganizationManagementState _data(ProviderContainer container) {
  return switch (container.read(organizationManagementProvider)) {
    AsyncData(:final value) => value,
    final value => throw StateError('Expected data, got $value'),
  };
}
