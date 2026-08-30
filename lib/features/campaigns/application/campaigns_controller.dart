import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/campaigns/data/campaigns_providers.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaign_models.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaigns_repository.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';

final campaignsProvider =
    AsyncNotifierProvider<CampaignsController, CampaignManagementState>(
      CampaignsController.new,
    );

class CampaignsController extends AsyncNotifier<CampaignManagementState> {
  CampaignsRepository get _repository => ref.read(campaignsRepositoryProvider);

  @override
  Future<CampaignManagementState> build() async {
    final organizationId = _organizationId(watch: true);
    return organizationId == null
        ? const CampaignManagementState()
        : _repository.load(organizationId);
  }

  Future<void> refresh() async {
    final organizationId = _organizationId();
    if (organizationId == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.load(organizationId));
  }

  Future<void> create({
    required String name,
    required String dhikrDefinitionId,
    required int targetCount,
  }) async {
    final organizationId = _organizationId();
    if (organizationId == null) {
      throw const CampaignFailure('اختر مؤسسة أولًا.');
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository.create(
        organizationId: organizationId,
        name: name,
        dhikrDefinitionId: dhikrDefinitionId,
        targetCount: targetCount,
      );
      return _repository.load(organizationId);
    });
  }

  String? _organizationId({bool watch = false}) {
    final management = watch
        ? ref.watch(organizationManagementProvider)
        : ref.read(organizationManagementProvider);
    return switch (management) {
      AsyncData(:final value) => value.selectedOrganizationId,
      _ => null,
    };
  }
}
