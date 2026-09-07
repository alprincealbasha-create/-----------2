import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';
import 'package:ward_al_rawdah/routing/app_router.dart';

void main() {
  group('role based redirect', () {
    test('maps every approved role to its isolated shell', () {
      expect(
        routeForRole(AppRole.organizationAdmin),
        AppRoutes.organizationAdmin,
      );
      expect(routeForRole(AppRole.branchManager), AppRoutes.branchManager);
      expect(routeForRole(AppRole.admin), AppRoutes.admin);
      expect(routeForRole(AppRole.teacher), AppRoutes.teacher);
      expect(routeForRole(AppRole.staff), AppRoutes.staff);
      expect(routeForRole(AppRole.student), AppRoutes.student);
    });

    test('keeps loading sessions on splash', () {
      expect(
        redirectForAuthState(const AuthState.loading(), AppRoutes.student),
        AppRoutes.splash,
      );
    });

    test('sends unauthenticated users to login', () {
      expect(
        redirectForAuthState(
          const AuthState.unauthenticated(),
          AppRoutes.admin,
        ),
        AppRoutes.login,
      );
    });

    test('sends students away from the admin route', () {
      expect(
        redirectForAuthState(
          const AuthState.authenticated(
            AuthUser(
              id: 'student-1',
              organizationId: 'organization-1',
              branchId: 'branch-1',
              classId: 'class-1',
              role: AppRole.student,
            ),
          ),
          AppRoutes.admin,
        ),
        AppRoutes.student,
      );
    });

    test('sends admins to their dashboard', () {
      expect(
        redirectForAuthState(
          const AuthState.authenticated(
            AuthUser(
              id: 'admin-1',
              organizationId: 'organization-1',
              branchId: 'branch-1',
              role: AppRole.admin,
            ),
          ),
          AppRoutes.student,
        ),
        AppRoutes.admin,
      );
    });

    test('allows the route that matches the role', () {
      expect(
        redirectForAuthState(
          const AuthState.authenticated(
            AuthUser(
              id: 'student-1',
              organizationId: 'organization-1',
              branchId: 'branch-1',
              classId: 'class-1',
              role: AppRole.student,
            ),
          ),
          AppRoutes.student,
        ),
        isNull,
      );
    });

    test('denies access while role resolution has failed', () {
      expect(
        redirectForAuthState(
          const AuthState.authorizationFailure('تعذر تحديد الدور'),
          AppRoutes.student,
        ),
        AppRoutes.authorizationFailure,
      );
    });
  });
}
