import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_models.dart';

abstract interface class WirdAssignmentRepository {
  Future<WirdManagementData> loadManagementData(String organizationId);
  Future<int> createWird(String organizationId, WirdDraft draft);
  Future<void> updateWird(String organizationId, WirdContent wird);
  Future<List<TodayWird>> listToday();
}

class WirdAssignmentFailure implements Exception {
  const WirdAssignmentFailure(this.userMessage);
  final String userMessage;
  @override
  String toString() => userMessage;
}
