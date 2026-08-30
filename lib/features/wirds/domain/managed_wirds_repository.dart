import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

abstract interface class ManagedWirdsRepository {
  Future<List<ManagedWird>> listWirds(String branchId);

  Future<ManagedWird> createWird({
    required String branchId,
    required String title,
    required int targetCount,
    String? details,
  });

  Future<ManagedWird> updateWird(ManagedWird wird);

  Future<ManagedWird> assignWird({
    required ManagedWird wird,
    required String userId,
  });

  Future<ManagedWird> completeWird(ManagedWird wird);
}

class WirdManagementFailure implements Exception {
  const WirdManagementFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
