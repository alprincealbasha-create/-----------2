enum AppRole {
  organizationAdmin('organization_admin'),
  branchManager('branch_manager'),
  admin('admin'),
  teacher('teacher'),
  staff('staff'),
  student('student');

  const AppRole(this.value);

  final String value;

  static AppRole parse(String value) {
    return AppRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => throw const FormatException('Unknown application role'),
    );
  }

  bool get isOrganizationScoped => this == AppRole.organizationAdmin;
}
