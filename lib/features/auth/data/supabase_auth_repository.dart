import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/auth/data/profile_dto.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;

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
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<AppRole> loadRole(String userId) async {
    try {
      final row = await _client
          .from('profiles')
          .select('id, role')
          .eq('id', userId)
          .single();
      final profile = ProfileDto.fromJson(row);
      return AppRole.parse(profile.role);
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
