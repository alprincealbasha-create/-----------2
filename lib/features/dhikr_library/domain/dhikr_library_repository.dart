import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';

abstract interface class DhikrLibraryRepository {
  Future<List<DhikrDefinition>> listDefinitions();

  Future<DhikrDefinition> createDefinition({
    required String organizationId,
    required String title,
    required String displayText,
    required int defaultTarget,
    String? description,
    String? sourceReference,
  });

  Future<DhikrDefinition> updateDefinition({
    required String organizationId,
    required DhikrDefinition definition,
  });
}

class DhikrLibraryFailure implements Exception {
  const DhikrLibraryFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
