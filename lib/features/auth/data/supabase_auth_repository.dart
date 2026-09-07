import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/data/local/app_database.dart';
import 'package:ward_al_rawdah/features/auth/data/profile_dto.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_repository.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart' as app;
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client, this._database);

  final SupabaseClient _client;
  final AppDatabase _database;

  @override
  String? get currentUserId => _client.auth.currentUser?.id;

  @override
  Stream<String?> get userIdChanges => _client.auth.onAuthStateChange
      .map((event) => event.session?.user.id)
      .distinct();

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      if (response.user == null) {
        throw const SignInFailure('تعذر تسجيل الدخول. حاول مرة أخرى.');
      }
    } on AuthException catch (error) {
      throw SignInFailure(_messageForAuthError(error));
    } on SignInFailure {
      rethrow;
    } catch (_) {
      throw const SignInFailure(
        'تعذر الاتصال بالخدمة. تحقق من الشبكة وحاول مرة أخرى.',
      );
    }
  }

  @override
  Future<void> signInStudent({
    required String organizationCode,
    required String studentCode,
    required String pin,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'student-login',
        body: {
          'organization_code': organizationCode.trim(),
          'student_code': studentCode.trim(),
          'pin': pin,
        },
      );
      if (response.status != 200 || response.data is! Map) {
        throw const StudentSignInFailure(
          'تعذر تسجيل الدخول. تحقق من البيانات وحاول لاحقًا.',
        );
      }
      final data = Map<String, dynamic>.from(response.data as Map);
      final refreshToken = data['refresh_token'];
      if (refreshToken is! String || refreshToken.isEmpty) {
        throw const StudentSignInFailure(
          'تعذر تسجيل الدخول. تحقق من البيانات وحاول لاحقًا.',
        );
      }
      await _client.auth.setSession(refreshToken);
    } on StudentSignInFailure {
      rethrow;
    } on FunctionException {
      throw const StudentSignInFailure(
        'تعذر تسجيل الدخول. تحقق من البيانات وحاول لاحقًا.',
      );
    } catch (_) {
      throw const StudentSignInFailure(
        'تعذر الاتصال بالخدمة. تحقق من الشبكة وحاول مرة أخرى.',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final userId = currentUserId;
    if (userId != null) {
      try {
        await _database.clearSyncedUserData(userId);
      } catch (_) {
        throw const SignOutFailure(
          'توجد تغييرات محفوظة محليًا لم تُزامن بعد. أعد المحاولة بعد الاتصال.',
        );
      }
    }
    await _client.auth.signOut();
  }

  @override
  Future<app.AuthUser> loadAuthorizationContext(String userId) async {
    try {
      final result = await _client.rpc('resolve_my_authorization_context');
      if (result is! List || result.length != 1) {
        throw const FormatException('Missing authorization context');
      }
      final row = Map<String, dynamic>.from(result.single as Map);
      final profile = ProfileDto.fromJson(row);
      if (profile.id != userId || profile.status != 'active') {
        throw const FormatException('Inactive or mismatched profile');
      }
      final role = AppRole.parse(profile.role);
      if (role.isOrganizationScoped != (profile.branchId == null)) {
        throw const FormatException('Invalid role scope');
      }
      if (role == AppRole.student && profile.classId == null) {
        throw const FormatException('Student class is missing');
      }
      return app.AuthUser(
        id: profile.id,
        organizationId: profile.organizationId,
        branchId: profile.branchId,
        classId: profile.classId,
        role: role,
      );
    } catch (_) {
      throw const RoleResolutionFailure(
        'تعذر التحقق من صلاحية الحساب. تواصل مع الدعم أو أعد المحاولة.',
      );
    }
  }

  String _messageForAuthError(AuthException error) {
    return switch (error.code) {
      'invalid_credentials' => 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
      'email_not_confirmed' => 'يرجى تأكيد البريد الإلكتروني أولًا.',
      _ => 'تعذر تسجيل الدخول. حاول مرة أخرى.',
    };
  }
}
