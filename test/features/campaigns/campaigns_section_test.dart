import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/campaigns/application/campaigns_controller.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaign_models.dart';
import 'package:ward_al_rawdah/features/campaigns/presentation/campaigns_section.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

void main() {
  test('maps campaign total, branch, and category contributions', () {
    final campaign = CampaignDashboardItem.fromRpc({
      'campaign_id': 'campaign-1',
      'campaign_name': 'حملة جماعية',
      'dhikr_title': 'ذكر معتمد',
      'target_count': 500000,
      'current_count': 327540,
      'campaign_status': 'active',
      'branch_contributions': [
        {'branch_id': 'damascus', 'branch_name': 'دمشق', 'count': 200000},
        {'branch_id': 'aleppo', 'branch_name': 'حلب', 'count': 127540},
      ],
      'category_contributions': [
        {'category': 'child', 'count': 300000},
        {'category': 'teacher', 'count': 27540},
      ],
    });

    expect(campaign.currentCount, 327540);
    expect(campaign.targetCount, 500000);
    expect(campaign.branchContributions.first.branchName, 'دمشق');
    expect(
      campaign.categoryContributions.first.category,
      ManagedUserType.child,
    );
  });

  testWidgets('shows organization total and contribution breakdowns', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [campaignsProvider.overrideWith(FixedCampaigns.new)],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: CampaignsSection()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('الحملات'), findsOneWidget);
    expect(find.text('حملة جماعية'), findsOneWidget);
    expect(find.text('327,540 / 500,000'), findsOneWidget);

    await tester.tap(find.text('حملة جماعية'));
    await tester.pumpAndSettle();
    expect(find.text('جميع المستخدمين مجتمعين'), findsOneWidget);
    expect(find.text('مساهمة الفروع'), findsOneWidget);
    expect(find.text('مساهمة الفئات'), findsOneWidget);
    expect(find.text('دمشق'), findsOneWidget);
    expect(find.text('طفل'), findsOneWidget);
  });
}

class FixedCampaigns extends CampaignsController {
  @override
  Future<CampaignManagementState> build() async => CampaignManagementState(
    dhikrDefinitions: const [
      DhikrDefinition(
        id: 'dhikr-1',
        title: 'ذكر معتمد',
        displayText: 'نص مراجع للاختبار',
        defaultTarget: 100,
        status: DhikrDefinitionStatus.approved,
        createdBy: 'admin-1',
      ),
    ],
    campaigns: const [
      CampaignDashboardItem(
        id: 'campaign-1',
        name: 'حملة جماعية',
        dhikrTitle: 'ذكر معتمد',
        targetCount: 500000,
        currentCount: 327540,
        status: CampaignStatus.active,
        branchContributions: [
          BranchContribution(
            branchId: 'damascus',
            branchName: 'دمشق',
            count: 200000,
          ),
          BranchContribution(
            branchId: 'aleppo',
            branchName: 'حلب',
            count: 127540,
          ),
        ],
        categoryContributions: [
          CategoryContribution(category: ManagedUserType.child, count: 300000),
          CategoryContribution(category: ManagedUserType.teacher, count: 27540),
        ],
      ),
    ],
  );
}
