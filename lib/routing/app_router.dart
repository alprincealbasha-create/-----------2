import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ward_al_rawdah/features/admin/presentation/admin_dashboard_page.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/presentation/authorization_failure_page.dart';
import 'package:ward_al_rawdah/features/auth/presentation/login_page.dart';
import 'package:ward_al_rawdah/features/auth/presentation/splash_page.dart';
import 'package:ward_al_rawdah/features/home/presentation/member_home_page.dart';
import 'package:ward_al_rawdah/features/dhikr/presentation/dhikr_screen.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const memberHome = '/home';
  static const dhikr = '/home/dhikr';
  static const adminDashboard = '/admin';
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
  final destination = switch (role) {
    AppRole.member => AppRoutes.memberHome,
    AppRole.admin => AppRoutes.adminDashboard,
  };

  final isPublicRoute =
      location == AppRoutes.splash ||
      location == AppRoutes.login ||
      location == AppRoutes.authorizationFailure;
  final isWrongRoleRoute = switch (role) {
    AppRole.member => location.startsWith(AppRoutes.adminDashboard),
    AppRole.admin => location.startsWith(AppRoutes.memberHome),
  };

  return isPublicRoute || isWrongRoleRoute ? destination : null;
}

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
      GoRoute(
        path: AppRoutes.memberHome,
        builder: (context, state) => const MemberHomePage(),
      ),
      GoRoute(
        path: AppRoutes.dhikr,
        builder: (context, state) => const DhikrScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminDashboard,
        builder: (context, state) => const AdminDashboardPage(),
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
