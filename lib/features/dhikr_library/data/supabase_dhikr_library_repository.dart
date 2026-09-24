import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_library_repository.dart';

class SupabaseDhikrLibraryRepository implements DhikrLibraryRepository {
  SupabaseDhikrLibraryRepository(this._client);

  final SupabaseClient _client;

  static const _fields =
      'id, owner_branch_id, title, display_text, description, default_target, status, '
      'created_by, source_reference, content_version, content_checksum, '
      'reviewed_by, reviewed_at';

  @override
  Future<List<DhikrDefinition>> listDefinitions() =>
      _guard('تعذر تحميل مكتبة الأذكار.', () async {
        final rows = await _client
            .from('dhikr_definitions')
            .select(_fields)
            .order('status')
            .order('title');
        return rows.map(DhikrDefinition.fromJson).toList(growable: false);
      });

  @override
  Future<DhikrDefinition> createDefinition({
    required String organizationId,
    required String title,
    required String displayText,
    required int defaultTarget,
    String? description,
    String? sourceReference,
  }) => _guard('تعذر إنشاء تعريف الذكر.', () async {
    final row = await _client.rpc(
      'save_dhikr_definition',
      params: {
        'p_id': null,
        'p_organization_id': organizationId,
        'p_title': _requiredText(title, 'عنوان الذكر مطلوب.'),
        'p_display_text': _requiredText(displayText, 'نص العرض مطلوب.'),
        'p_description': _optionalText(description),
        'p_default_target': _requiredTarget(defaultTarget),
        'p_status': 'draft',
        'p_source_reference': _optionalText(sourceReference),
      },
    );
    return DhikrDefinition.fromJson(Map<String, Object?>.from(row as Map));
  });

  @override
  Future<DhikrDefinition> updateDefinition({
    required String organizationId,
    required DhikrDefinition definition,
  }) => _guard('تعذر تحديث تعريف الذكر.', () async {
    if (definition.status == DhikrDefinitionStatus.approved &&
        _optionalText(definition.sourceReference) == null) {
      throw const DhikrLibraryFailure('مرجع المصدر مطلوب قبل اعتماد الذكر.');
    }
    final row = await _client.rpc(
      'save_dhikr_definition',
      params: {
        'p_id': definition.id,
        'p_organization_id': organizationId,
        'p_title': _requiredText(definition.title, 'عنوان الذكر مطلوب.'),
        'p_display_text': _requiredText(
          definition.displayText,
          'نص العرض مطلوب.',
        ),
        'p_description': _optionalText(definition.description),
        'p_default_target': _requiredTarget(definition.defaultTarget),
        'p_status': definition.status.value,
        'p_source_reference': _optionalText(definition.sourceReference),
      },
    );
    return DhikrDefinition.fromJson(Map<String, Object?>.from(row as Map));
  });

  Future<T> _guard<T>(String message, Future<T> Function() action) async {
    try {
      return await action();
    } on DhikrLibraryFailure {
      rethrow;
    } catch (_) {
      throw DhikrLibraryFailure(message);
    }
  }

  String _requiredText(String value, String message) {
    final normalized = value.trim();
    if (normalized.isEmpty) throw DhikrLibraryFailure(message);
    return normalized;
  }

  String? _optionalText(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  int _requiredTarget(int value) {
    if (value < 1 || value > 100000) {
      throw const DhikrLibraryFailure('أدخل هدفًا بين 1 و100000.');
    }
    return value;
  }
}
