import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';

void main() {
  group('AppRole', () {
    test('parses supported database values', () {
      expect(AppRole.parse('organization_admin'), AppRole.organizationAdmin);
      expect(AppRole.parse('branch_manager'), AppRole.branchManager);
      expect(AppRole.parse('admin'), AppRole.admin);
      expect(AppRole.parse('teacher'), AppRole.teacher);
      expect(AppRole.parse('staff'), AppRole.staff);
      expect(AppRole.parse('student'), AppRole.student);
    });

    test('rejects unknown roles securely', () {
      expect(() => AppRole.parse('owner'), throwsFormatException);
    });
  });
}
