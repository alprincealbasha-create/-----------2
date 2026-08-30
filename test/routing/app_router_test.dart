import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';
import 'package:ward_al_rawdah/routing/app_router.dart';

void main() {
  group('role based redirect', () {
    test('keeps loading sessions on splash', () {
      expect(
        redirectForAuthState(const AuthState.loading(), AppRoutes.memberHome),
        AppRoutes.splash,
      );
    });

    test('sends unauthenticated users to login', () {
      expect(
        redirectForAuthState(
          const AuthState.unauthenticated(),
          AppRoutes.adminDashboard,
        ),
        AppRoutes.login,
      );
    });

    test('sends members away from the admin route', () {
      expect(
        redirectForAuthState(
          const AuthState.authenticated(
            AuthUser(id: 'member-1', role: AppRole.member),
          ),
          AppRoutes.adminDashboard,
        ),
        AppRoutes.memberHome,
      );
    });

    test('sends admins to their dashboard', () {
      expect(
        redirectForAuthState(
          const AuthState.authenticated(
            AuthUser(id: 'admin-1', role: AppRole.admin),
          ),
          AppRoutes.memberHome,
        ),
        AppRoutes.adminDashboard,
      );
    });

    test('allows the route that matches the role', () {
      expect(
        redirectForAuthState(
          const AuthState.authenticated(
            AuthUser(id: 'member-1', role: AppRole.member),
          ),
          AppRoutes.memberHome,
        ),
        isNull,
      );
    });

    test('denies access while role resolution has failed', () {
      expect(
        redirectForAuthState(
          const AuthState.authorizationFailure('تعذر تحديد الدور'),
          AppRoutes.memberHome,
        ),
        AppRoutes.authorizationFailure,
      );
    });
  });
}
