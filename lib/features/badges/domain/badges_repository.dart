import 'package:ward_al_rawdah/features/badges/domain/badge_models.dart';

abstract interface class BadgesRepository {
  Future<BadgeManagementState> load(String? branchId);

  Future<void> awardManualBadge({
    required String badgeId,
    required String branchUserId,
  });
}

class BadgeManagementFailure implements Exception {
  const BadgeManagementFailure(this.userMessage);

  final String userMessage;
}
