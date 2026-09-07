import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/presentation/authorization_failure_page.dart';
import 'package:ward_al_rawdah/features/auth/presentation/login_page.dart';
import 'package:ward_al_rawdah/features/auth/presentation/role_shell_page.dart';
import 'package:ward_al_rawdah/features/auth/presentation/splash_page.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const organizationAdmin = '/organization-admin';
  static const branchManager = '/branch-manager';
  static const admin = '/admin';
  static const teacher = '/teacher';
  static const staff = '/staff';
  static const student = '/student';
  // Legacy prototype destination is intentionally not registered in Stage 3.
  static const dhikr = '/student/dhikr';
  static const authorizationFailure = '/access-denied';
}

String? redirectForAuthState(AuthState state, String location) {
  return switch (state) {
    AuthLoading() => location == AppRoutes.splash ? null : AppRoutes.splash,
    AuthUnauthenticated() =>
      location == AppRoutes.login ? null : AppRoutes.login,
    AuthAuthorizationFailure() =>
      location == AppRoutes.authorizationFailure
          ? null
          : AppRoutes.authorizationFailure,
    AuthAuthenticated(:final user) => _redirectAuthenticated(
      user.role,
      location,
    ),
  };
}

String? _redirectAuthenticated(AppRole role, String location) {
  final destination = routeForRole(role);

  final isPublicRoute =
      location == AppRoutes.splash ||
      location == AppRoutes.login ||
      location == AppRoutes.authorizationFailure;
  final isRoleRoute = AppRole.values
      .map(routeForRole)
      .any((route) => location == route || location.startsWith('$route/'));
  final isWrongRoleRoute = isRoleRoute && !location.startsWith(destination);

  return isPublicRoute || isWrongRoleRoute ? destination : null;
}

String routeForRole(AppRole role) => switch (role) {
  AppRole.organizationAdmin => AppRoutes.organizationAdmin,
  AppRole.branchManager => AppRoutes.branchManager,
  AppRole.admin => AppRoutes.admin,
  AppRole.teacher => AppRoutes.teacher,
  AppRole.staff => AppRoutes.staff,
  AppRole.student => AppRoutes.student,
};

final _routerRefreshProvider = Provider<_RouterRefreshNotifier>((ref) {
  final notifier = _RouterRefreshNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(_routerRefreshProvider);
  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) => redirectForAuthState(
      ref.read(authControllerProvider),
      state.matchedLocation,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      for (final role in AppRole.values)
        GoRoute(
          path: routeForRole(role),
          builder: (context, state) => RoleShellPage(role: role),
        ),
      GoRoute(
        path: AppRoutes.authorizationFailure,
        builder: (context, state) => const AuthorizationFailurePage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen<AuthState>(authControllerProvider, (_, _) => notifyListeners());
  }
}
