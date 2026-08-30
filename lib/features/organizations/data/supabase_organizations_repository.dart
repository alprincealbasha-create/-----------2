import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organizations_repository.dart';

class SupabaseOrganizationsRepository implements OrganizationsRepository {
  SupabaseOrganizationsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Organization>> listOrganizations() =>
      _guard('تعذر تحميل المؤسسات.', () async {
        final rows = await _client
            .from('organizations')
            .select('id, name')
            .isFilter('deleted_at', null)
            .order('name');
        return rows.map(Organization.fromJson).toList(growable: false);
      });

  @override
  Future<Organization> createOrganization(String name) =>
      _guard('تعذر إنشاء المؤسسة.', () async {
        final row = await _client
            .from('organizations')
            .insert({'name': _requiredName(name)})
            .select('id, name')
            .single();
        return Organization.fromJson(row);
      });

  @override
  Future<Organization> updateOrganization(Organization organization) =>
      _guard('تعذر تعديل المؤسسة.', () async {
        final row = await _client
            .from('organizations')
            .update({'name': _requiredName(organization.name)})
            .eq('id', organization.id)
            .select('id, name')
            .single();
        return Organization.fromJson(row);
      });

  @override
  Future<void> deleteOrganization(String organizationId) => _softDelete(
    table: 'organizations',
    id: organizationId,
    message: 'تعذر حذف المؤسسة.',
  );

  @override
  Future<List<Branch>> listBranches(String organizationId) =>
      _guard('تعذر تحميل الفروع.', () async {
        final rows = await _client
            .from('branches')
            .select('id, organization_id, name, city')
            .eq('organization_id', organizationId)
            .isFilter('deleted_at', null)
            .order('name');
        return rows.map(Branch.fromJson).toList(growable: false);
      });

  @override
  Future<Branch> createBranch({
    required String organizationId,
    required String name,
    String? city,
  }) => _guard('تعذر إنشاء الفرع.', () async {
    final row = await _client
        .from('branches')
        .insert({
          'organization_id': organizationId,
          'name': _requiredName(name),
          'city': _optionalText(city),
        })
        .select('id, organization_id, name, city')
        .single();
    return Branch.fromJson(row);
  });

  @override
  Future<Branch> updateBranch(Branch branch) =>
      _guard('تعذر تعديل الفرع.', () async {
        final row = await _client
            .from('branches')
            .update({'name': _requiredName(branch.name), 'city': branch.city})
            .eq('id', branch.id)
            .select('id, organization_id, name, city')
            .single();
        return Branch.fromJson(row);
      });

  @override
  Future<void> deleteBranch(String branchId) =>
      _softDelete(table: 'branches', id: branchId, message: 'تعذر حذف الفرع.');

  @override
  Future<List<SchoolClass>> listClasses(String branchId) =>
      _guard('تعذر تحميل الصفوف.', () async {
        final rows = await _client
            .from('classes')
            .select('id, branch_id, name')
            .eq('branch_id', branchId)
            .isFilter('deleted_at', null)
            .order('name');
        return rows.map(SchoolClass.fromJson).toList(growable: false);
      });

  @override
  Future<SchoolClass> createClass({
    required String branchId,
    required String name,
  }) => _guard('تعذر إنشاء الصف.', () async {
    final row = await _client
        .from('classes')
        .insert({'branch_id': branchId, 'name': _requiredName(name)})
        .select('id, branch_id, name')
        .single();
    return SchoolClass.fromJson(row);
  });

  @override
  Future<SchoolClass> updateClass(SchoolClass schoolClass) =>
      _guard('تعذر تعديل الصف.', () async {
        final row = await _client
            .from('classes')
            .update({'name': _requiredName(schoolClass.name)})
            .eq('id', schoolClass.id)
            .select('id, branch_id, name')
            .single();
        return SchoolClass.fromJson(row);
      });

  @override
  Future<void> deleteClass(String classId) =>
      _softDelete(table: 'classes', id: classId, message: 'تعذر حذف الصف.');

  @override
  Future<List<ChildRecord>> listChildren(String classId) =>
      _guard('تعذر تحميل الأطفال.', () async {
        final rows = await _client
            .from('branch_users')
            .select('id, class_id, full_name, birth_date')
            .eq('class_id', classId)
            .eq('user_type', 'child')
            .isFilter('deleted_at', null)
            .order('full_name');
        return rows.map(ChildRecord.fromJson).toList(growable: false);
      });

  @override
  Future<ChildRecord> createChild({
    required String classId,
    required String fullName,
    DateTime? birthDate,
  }) => _guard('تعذر إضافة الطفل.', () async {
    final row = await _client
        .from('branch_users')
        .insert({
          'class_id': classId,
          'user_type': 'child',
          'full_name': _requiredName(fullName),
          'birth_date': _dateOnly(birthDate),
        })
        .select('id, class_id, full_name, birth_date')
        .single();
    return ChildRecord.fromJson(row);
  });

  @override
  Future<ChildRecord> updateChild(ChildRecord child) =>
      _guard('تعذر تعديل بيانات الطفل.', () async {
        final row = await _client
            .from('branch_users')
            .update({
              'class_id': child.classId,
              'full_name': _requiredName(child.fullName),
              'birth_date': _dateOnly(child.birthDate),
            })
            .eq('id', child.id)
            .select('id, class_id, full_name, birth_date')
            .single();
        return ChildRecord.fromJson(row);
      });

  @override
  Future<void> deleteChild(String childId) => _softDelete(
    table: 'branch_users',
    id: childId,
    message: 'تعذر حذف الطفل.',
  );

  Future<void> _softDelete({
    required String table,
    required String id,
    required String message,
  }) => _guard(message, () async {
    await _client
        .from(table)
        .update({'deleted_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', id);
  });

  Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on OrganizationFailure {
      rethrow;
    } catch (_) {
      throw OrganizationFailure(message);
    }
  }

  String _requiredName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw const OrganizationFailure('الاسم مطلوب.');
    }
    return normalized;
  }

  String? _optionalText(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  String? _dateOnly(DateTime? value) {
    if (value == null) {
      return null;
    }
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
