import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/dhikr_library/data/dhikr_library_providers.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_library_repository.dart';

final dhikrLibraryProvider =
    AsyncNotifierProvider<DhikrLibraryController, List<DhikrDefinition>>(
      DhikrLibraryController.new,
    );

class DhikrLibraryController extends AsyncNotifier<List<DhikrDefinition>> {
  DhikrLibraryRepository get _repository =>
      ref.read(dhikrLibraryRepositoryProvider);

  @override
  Future<List<DhikrDefinition>> build() => _repository.listDefinitions();

  Future<void> refresh() => _replaceWith(_repository.listDefinitions());

  Future<void> createDefinition({
    required String title,
    required String displayText,
    required int defaultTarget,
    String? description,
    String? sourceReference,
  }) => _replaceWith(() async {
    final organizationId = switch (ref.read(authControllerProvider)) {
      AuthAuthenticated(:final user) => user.organizationId,
      _ => throw const DhikrLibraryFailure('تعذر تحديد المؤسسة الحالية.'),
    };
    await _repository.createDefinition(
      organizationId: organizationId,
      title: title,
      displayText: displayText,
      defaultTarget: defaultTarget,
      description: description,
      sourceReference: sourceReference,
    );
    return _repository.listDefinitions();
  }());

  Future<void> updateDefinition(DhikrDefinition definition) =>
      _replaceWith(() async {
        final organizationId = switch (ref.read(authControllerProvider)) {
          AuthAuthenticated(:final user) => user.organizationId,
          _ => throw const DhikrLibraryFailure('تعذر تحديد المؤسسة الحالية.'),
        };
        await _repository.updateDefinition(
          organizationId: organizationId,
          definition: definition,
        );
        return _repository.listDefinitions();
      }());

  Future<void> _replaceWith(Future<List<DhikrDefinition>> operation) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => operation);
  }
}
