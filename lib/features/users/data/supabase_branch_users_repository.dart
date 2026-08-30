import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_users_repository.dart';

class SupabaseBranchUsersRepository implements BranchUsersRepository {
  SupabaseBranchUsersRepository(this._client);

  final SupabaseClient _client;

  static const _fields =
      'id, branch_id, class_id, profile_id, user_type, full_name, birth_date';

  @override
  Future<List<ManagedUser>> listUsers(String branchId) =>
      _guard('تعذر تحميل مستخدمي الفرع.', () async {
        final rows = await _client
            .from('branch_users')
            .select(_fields)
            .eq('branch_id', branchId)
            .isFilter('deleted_at', null)
            .order('full_name');
        return rows.map(ManagedUser.fromJson).toList(growable: false);
      });

  @override
  Future<ManagedUser> createUser({
    required String branchId,
    required String? classId,
    required ManagedUserType userType,
    required String fullName,
    DateTime? birthDate,
  }) => _guard('تعذر إضافة المستخدم.', () async {
    validateUserAssignment(userType: userType, classId: classId);
    final row = await _client
        .from('branch_users')
        .insert({
          'branch_id': branchId,
          'class_id': classId,
          'user_type': userType.value,
          'full_name': _requiredName(fullName),
          'birth_date': _dateOnly(birthDate),
        })
        .select(_fields)
        .single();
    return ManagedUser.fromJson(row);
  });

  @override
  Future<ManagedUser> updateUser(ManagedUser user) =>
      _guard('تعذر تعديل المستخدم.', () async {
        validateUserAssignment(userType: user.userType, classId: user.classId);
        final row = await _client
            .from('branch_users')
            .update({
              'branch_id': user.branchId,
              'class_id': user.classId,
              'user_type': user.userType.value,
              'full_name': _requiredName(user.fullName),
              'birth_date': _dateOnly(user.birthDate),
            })
            .eq('id', user.id)
            .select(_fields)
            .single();
        return ManagedUser.fromJson(row);
      });

  @override
  Future<void> deleteUser(String userId) =>
      _guard('تعذر حذف المستخدم.', () async {
        await _client
            .from('branch_users')
            .update({'deleted_at': DateTime.now().toUtc().toIso8601String()})
            .eq('id', userId);
      });

  Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on UserManagementFailure {
      rethrow;
    } catch (_) {
      throw UserManagementFailure(message);
    }
  }

  String _requiredName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw const UserManagementFailure('الاسم مطلوب.');
    }
    return normalized;
  }

  String? _dateOnly(DateTime? value) {
    if (value == null) return null;
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}-$month-$day';
  }
}
