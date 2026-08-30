import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

abstract interface class OrganizationsRepository {
  Future<List<Organization>> listOrganizations();

  Future<Organization> createOrganization(String name);

  Future<Organization> updateOrganization(Organization organization);

  Future<void> deleteOrganization(String organizationId);

  Future<List<Branch>> listBranches(String organizationId);

  Future<Branch> createBranch({
    required String organizationId,
    required String name,
    String? city,
  });

  Future<Branch> updateBranch(Branch branch);

  Future<void> deleteBranch(String branchId);

  Future<List<SchoolClass>> listClasses(String branchId);

  Future<SchoolClass> createClass({
    required String branchId,
    required String name,
  });

  Future<SchoolClass> updateClass(SchoolClass schoolClass);

  Future<void> deleteClass(String classId);

  Future<List<ChildRecord>> listChildren(String classId);

  Future<ChildRecord> createChild({
    required String classId,
    required String fullName,
    DateTime? birthDate,
  });

  Future<ChildRecord> updateChild(ChildRecord child);

  Future<void> deleteChild(String childId);
}

class OrganizationFailure implements Exception {
  const OrganizationFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
