import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';

abstract interface class DhikrRepository {
  Future<DhikrCounter?> loadCurrent(String userId);

  Future<DhikrCounter> createCounter({
    required String userId,
    required String title,
    required int target,
    String? managedWirdId,
  });

  Future<DhikrCounter> increment({
    required String userId,
    required String sessionId,
  });

  Future<DhikrCounter?> syncPending(String userId);
}

class DhikrFailure implements Exception {
  const DhikrFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
