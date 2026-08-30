import 'package:ward_al_rawdah/features/integrity/domain/integrity_models.dart';

abstract interface class IntegrityRepository {
  Future<List<IntegrityFlag>> listFlags(String branchId);

  Future<void> reviewFlag({
    required String flagId,
    required IntegrityFlagStatus status,
  });
}

class IntegrityFailure implements Exception {
  const IntegrityFailure(this.userMessage);

  final String userMessage;
}
