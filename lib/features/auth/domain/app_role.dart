enum AppRole {
  member('member'),
  admin('admin');

  const AppRole(this.value);

  final String value;

  static AppRole parse(String value) {
    return AppRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => throw const FormatException('Unknown application role'),
    );
  }
}
