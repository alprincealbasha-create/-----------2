import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/reports/application/administrative_reports_controller.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_report_models.dart';
import 'package:ward_al_rawdah/features/reports/presentation/administrative_reports_section.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

void main() {
  test('maps report options with their dependent branch and class', () {
    final option = ReportFilterOption.fromRpc({
      'id': 'user-1',
      'label': 'طفل الاختبار',
      'branch_id': 'damascus',
      'class_id': 'prep-a',
      'role': 'child',
    });

    expect(option.branchId, 'damascus');
    expect(option.classId, 'prep-a');
    expect(option.role, ManagedUserType.child);
  });

  testWidgets('shows all filters and the three MVP report views', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          administrativeReportsProvider.overrideWith(
            FixedAdministrativeReportsController.new,
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: AdministrativeReportsSection()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('تقارير الإنجاز'), findsOneWidget);
    expect(find.text('تقرير يومي'), findsOneWidget);
    expect(find.text('تقرير الفرع'), findsOneWidget);
    expect(find.text('تقرير المستخدم'), findsOneWidget);
    expect(find.textContaining('الفترة:'), findsOneWidget);
    for (final label in [
      'الفرع',
      'الصف',
      'الدور / الفئة',
      'المستخدم',
      'الورد',
      'الذكر',
      'حالة الإتمام',
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    expect(find.text('2026-08-01'), findsOneWidget);
    expect(find.text('نسبة الإتمام: 100%'), findsOneWidget);

    await tester.tap(find.text('تقرير الفرع'));
    await tester.tap(find.text('تطبيق الفلاتر'));
    await tester.pumpAndSettle();
    expect(find.text('اختر فرعًا لعرض تقرير الفرع.'), findsOneWidget);

    await tester.tap(find.text('تقرير المستخدم'));
    await tester.tap(find.text('تطبيق الفلاتر'));
    await tester.pumpAndSettle();
    expect(find.text('اختر مستخدمًا لعرض تقرير المستخدم.'), findsOneWidget);
  });
}

class FixedAdministrativeReportsController
    extends AdministrativeReportsController {
  @override
  Future<AdministrativeReportData> build() async => _data();

  @override
  Future<void> apply(AdministrativeReportFilters filters) async {
    state = AsyncData(_data().copyWith(filters: filters));
  }
}

AdministrativeReportData _data() {
  final date = DateTime(2026, 8, 1);
  return AdministrativeReportData(
    options: const AdministrativeReportOptions(
      branches: [ReportFilterOption(id: 'damascus', label: 'دمشق')],
      classes: [
        ReportFilterOption(
          id: 'prep-a',
          label: 'تمهيدي A',
          branchId: 'damascus',
        ),
      ],
      users: [
        ReportFilterOption(
          id: 'child-1',
          label: 'طفل الاختبار',
          branchId: 'damascus',
          classId: 'prep-a',
          role: ManagedUserType.child,
        ),
      ],
      wirds: [ReportFilterOption(id: 'wird-1', label: 'ورد أغسطس')],
      dhikrs: [ReportFilterOption(id: 'dhikr-1', label: 'التسبيح')],
    ),
    filters: AdministrativeReportFilters(startDate: date, endDate: date),
    rows: [
      AdministrativeReportRow(
        assignmentId: 'assignment-1',
        activityDate: date,
        branchId: 'damascus',
        branchName: 'دمشق',
        classId: 'prep-a',
        className: 'تمهيدي A',
        userId: 'child-1',
        userName: 'طفل الاختبار',
        userRole: ManagedUserType.child,
        wirdId: 'wird-1',
        wirdName: 'ورد أغسطس',
        dhikrId: 'dhikr-1',
        dhikrTitle: 'التسبيح',
        currentCount: 100,
        targetCount: 100,
        completionStatus: ReportCompletionStatus.completed,
      ),
    ],
  );
}
