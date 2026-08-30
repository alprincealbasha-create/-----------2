import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';

void main() {
  group('AppRole', () {
    test('parses supported database values', () {
      expect(AppRole.parse('member'), AppRole.member);
      expect(AppRole.parse('admin'), AppRole.admin);
    });

    test('rejects unknown roles securely', () {
      expect(() => AppRole.parse('owner'), throwsFormatException);
    });
  });
}
