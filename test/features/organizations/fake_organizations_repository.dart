import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organizations_repository.dart';

class FakeOrganizationsRepository implements OrganizationsRepository {
  final Map<String, Organization> organizations = {};
  final Map<String, Branch> branches = {};
  final Map<String, SchoolClass> classes = {};
  final Map<String, ChildRecord> children = {};
  var _nextId = 1;

  String _id(String prefix) => '$prefix-${_nextId++}';

  @override
  Future<List<Organization>> listOrganizations() async =>
      _sorted(organizations.values, (item) => item.name);

  @override
  Future<Organization> createOrganization(String name) async {
    final item = Organization(id: _id('org'), name: _name(name));
    organizations[item.id] = item;
    return item;
  }

  @override
  Future<Organization> updateOrganization(Organization organization) async {
    _require(organizations, organization.id);
    final updated = organization.copyWith(name: _name(organization.name));
    organizations[updated.id] = updated;
    return updated;
  }

  @override
  Future<void> deleteOrganization(String organizationId) async {
    _require(organizations, organizationId);
    organizations.remove(organizationId);
    final branchIds = branches.values
        .where((item) => item.organizationId == organizationId)
        .map((item) => item.id)
        .toList();
    for (final branchId in branchIds) {
      await deleteBranch(branchId);
    }
  }

  @override
  Future<List<Branch>> listBranches(String organizationId) async => _sorted(
    branches.values.where((item) => item.organizationId == organizationId),
    (item) => item.name,
  );

  @override
  Future<Branch> createBranch({
    required String organizationId,
    required String name,
    String? city,
  }) async {
    _require(organizations, organizationId);
    final item = Branch(
      id: _id('branch'),
      organizationId: organizationId,
      name: _name(name),
      city: city,
    );
    branches[item.id] = item;
    return item;
  }

  @override
  Future<Branch> updateBranch(Branch branch) async {
    _require(branches, branch.id);
    final updated = branch.copyWith(name: _name(branch.name));
    branches[updated.id] = updated;
    return updated;
  }

  @override
  Future<void> deleteBranch(String branchId) async {
    _require(branches, branchId);
    branches.remove(branchId);
    final classIds = classes.values
        .where((item) => item.branchId == branchId)
        .map((item) => item.id)
        .toList();
    for (final classId in classIds) {
      await deleteClass(classId);
    }
  }

  @override
  Future<List<SchoolClass>> listClasses(String branchId) async => _sorted(
    classes.values.where((item) => item.branchId == branchId),
    (item) => item.name,
  );

  @override
  Future<SchoolClass> createClass({
    required String branchId,
    required String name,
  }) async {
    _require(branches, branchId);
    final item = SchoolClass(
      id: _id('class'),
      branchId: branchId,
      name: _name(name),
    );
    classes[item.id] = item;
    return item;
  }

  @override
  Future<SchoolClass> updateClass(SchoolClass schoolClass) async {
    _require(classes, schoolClass.id);
    final updated = schoolClass.copyWith(name: _name(schoolClass.name));
    classes[updated.id] = updated;
    return updated;
  }

  @override
  Future<void> deleteClass(String classId) async {
    _require(classes, classId);
    classes.remove(classId);
    children.removeWhere((_, child) => child.classId == classId);
  }

  @override
  Future<List<ChildRecord>> listChildren(String classId) async => _sorted(
    children.values.where((item) => item.classId == classId),
    (item) => item.fullName,
  );

  @override
  Future<ChildRecord> createChild({
    required String classId,
    required String fullName,
    DateTime? birthDate,
  }) async {
    _require(classes, classId);
    final item = ChildRecord(
      id: _id('child'),
      classId: classId,
      fullName: _name(fullName),
      birthDate: birthDate,
    );
    children[item.id] = item;
    return item;
  }

  @override
  Future<ChildRecord> updateChild(ChildRecord child) async {
    _require(children, child.id);
    _require(classes, child.classId);
    final updated = child.copyWith(fullName: _name(child.fullName));
    children[updated.id] = updated;
    return updated;
  }

  @override
  Future<void> deleteChild(String childId) async {
    _require(children, childId);
    children.remove(childId);
  }

  List<T> _sorted<T>(Iterable<T> values, String Function(T) nameOf) {
    final result = values.toList();
    result.sort((left, right) => nameOf(left).compareTo(nameOf(right)));
    return result;
  }

  String _name(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw const OrganizationFailure('الاسم مطلوب.');
    }
    return normalized;
  }

  void _require<T>(Map<String, T> values, String id) {
    if (!values.containsKey(id)) {
      throw const OrganizationFailure('العنصر غير موجود.');
    }
  }
}
