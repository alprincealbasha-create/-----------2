import 'package:ward_al_rawdah/features/campaigns/domain/campaign_models.dart';

abstract interface class CampaignsRepository {
  Future<CampaignManagementState> load(String organizationId);

  Future<void> create({
    required String organizationId,
    required String name,
    required String dhikrDefinitionId,
    required int targetCount,
  });
}

class CampaignFailure implements Exception {
  const CampaignFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
