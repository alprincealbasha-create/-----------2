import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/application/branch_dashboard_controller.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_daily_metrics.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/presentation/branch_dashboard_overview.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

void main() {
  test('maps daily metrics returned by the RPC', () {
    final metrics = BranchDailyMetrics.fromRpc({
      'participating_users': 8,
      'completed_users': 6,
      'completion_rate': 75,
      'total_recorded_dhikr': 420,
      'participating_children': 5,
      'participating_staff': 3,
    });

    expect(metrics.participatingUsers, 8);
    expect(metrics.completedUsers, 6);
    expect(metrics.completionRate, 75);
    expect(metrics.totalRecordedDhikr, 420);
    expect(metrics.participatingChildren, 5);
    expect(metrics.participatingStaff, 3);
  });

  testWidgets('shows the six daily indicators and dashboard modules', (
    tester,
  ) async {
    BranchDashboardModule? selected;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          branchDashboardProvider.overrideWith(FixedMetricsController.new),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: BranchDashboardOverview(
                branch: const Branch(
                  id: 'branch-1',
                  organizationId: 'org-1',
                  name: 'فرع دمشق',
                ),
                onModuleSelected: (value) => selected = value,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('المستخدمون المشاركون'), findsOneWidget);
    expect(find.text('أكملوا الأوراد'), findsOneWidget);
    expect(find.text('نسبة الإنجاز'), findsOneWidget);
    expect(find.text('إجمالي الأذكار'), findsOneWidget);
    expect(find.text('الأطفال المشاركون'), findsOneWidget);
    expect(find.text('الموظفون المشاركون'), findsOneWidget);
    for (final module in BranchDashboardModule.values) {
      expect(find.text(module.englishLabel), findsOneWidget);
    }

    await tester.tap(find.text('Users'));
    expect(selected, BranchDashboardModule.users);
  });
}

class FixedMetricsController extends BranchDashboardController {
  @override
  Future<BranchDailyMetrics> build() async => const BranchDailyMetrics(
    participatingUsers: 8,
    completedUsers: 6,
    completionRate: 75,
    totalRecordedDhikr: 420,
    participatingChildren: 5,
    participatingStaff: 3,
  );
}
