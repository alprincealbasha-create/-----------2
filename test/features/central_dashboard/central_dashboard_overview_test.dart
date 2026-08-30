import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/central_dashboard/application/central_dashboard_controller.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_branch_metrics.dart';
import 'package:ward_al_rawdah/features/central_dashboard/presentation/central_dashboard_overview.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

void main() {
  test('maps central metrics returned by the RPC', () {
    final metrics = CentralBranchMetrics.fromRpc({
      'branch_id': 'damascus',
      'branch_name': 'دمشق',
      'branch_city': 'دمشق',
      'eligible_users': 150,
      'participating_users': 125,
      'completed_users': 101,
      'participation_rate': 83.3,
      'completion_rate': 80.8,
      'total_recorded_dhikr': 8240,
    });

    expect(metrics.branchName, 'دمشق');
    expect(metrics.eligibleUsers, 150);
    expect(metrics.participatingUsers, 125);
    expect(metrics.completedUsers, 101);
    expect(metrics.participationRate, 83.3);
    expect(metrics.completionRate, 80.8);
  });

  test('ranks by completion then participation, not raw dhikr count', () {
    final ranked = rankCentralBranches(const [
      CentralBranchMetrics(
        branchId: 'raw-high',
        branchName: 'العدد الأعلى',
        completionRate: 70,
        participationRate: 95,
        totalRecordedDhikr: 100000,
      ),
      CentralBranchMetrics(
        branchId: 'completion-high',
        branchName: 'الإكمال الأعلى',
        completionRate: 90,
        participationRate: 80,
        totalRecordedDhikr: 100,
      ),
      CentralBranchMetrics(
        branchId: 'participation-high',
        branchName: 'المشاركة الأعلى',
        completionRate: 90,
        participationRate: 85,
        totalRecordedDhikr: 50,
      ),
    ]);

    expect(ranked.map((item) => item.branchId), [
      'participation-high',
      'completion-high',
      'raw-high',
    ]);
  });

  testWidgets('shows all branches and filters to one branch', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          centralDashboardProvider.overrideWith(FixedCentralController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: CentralDashboardOverview(
                organization: Organization(id: 'org-1', name: 'الروضة'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('كل الفروع'), findsOneWidget);
    expect(find.text('دمشق'), findsOneWidget);
    expect(find.text('حلب'), findsOneWidget);
    expect(find.text('نسبة المشاركة'), findsOneWidget);
    expect(find.text('نسبة الإكمال'), findsOneWidget);

    await tester.tap(find.byType(DropdownButtonFormField<String?>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('حلب').last);
    await tester.pumpAndSettle();

    expect(find.text('دمشق'), findsNothing);
    expect(find.text('حلب'), findsNWidgets(2));
    expect(find.text('89%'), findsOneWidget);
  });
}

class FixedCentralController extends CentralDashboardController {
  @override
  Future<List<CentralBranchMetrics>> build() async => const [
    CentralBranchMetrics(
      branchId: 'damascus',
      branchName: 'دمشق',
      eligibleUsers: 150,
      participatingUsers: 125,
      completedUsers: 101,
      participationRate: 83.3,
      completionRate: 80.8,
      totalRecordedDhikr: 8240,
    ),
    CentralBranchMetrics(
      branchId: 'aleppo',
      branchName: 'حلب',
      eligibleUsers: 100,
      participatingUsers: 90,
      completedUsers: 80,
      participationRate: 90,
      completionRate: 89,
      totalRecordedDhikr: 6300,
    ),
  ];
}
