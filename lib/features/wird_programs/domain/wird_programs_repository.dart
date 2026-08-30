import 'package:ward_al_rawdah/features/wird_programs/domain/wird_program_models.dart';

abstract interface class WirdProgramsRepository {
  Future<WirdProgramCreationState> load(String organizationId);

  Future<int> create({
    required String organizationId,
    required WirdProgramRequest request,
  });
}

class WirdProgramFailure implements Exception {
  const WirdProgramFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
