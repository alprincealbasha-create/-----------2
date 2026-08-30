import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/wird_programs/application/wird_programs_controller.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_program_models.dart';
import 'package:ward_al_rawdah/features/wird_programs/presentation/wird_programs_section.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

void main() {
  test('the same dhikr definition can be reused in multiple wirds', () {
    final first = _program(id: 'wird-1', name: 'ورد صباح الثلاثاء');
    final second = _program(id: 'wird-2', name: 'ورد صباح الأربعاء');

    expect(first.id, isNot(second.id));
    expect(first.dhikrDefinitionId, second.dhikrDefinitionId);
  });

  test('checks the assigned wird date window', () {
    final wird = ManagedWird(
      id: 'assignment-1',
      branchId: 'branch-1',
      title: 'ورد مجدول',
      status: ManagedWirdStatus.assigned,
      availableFrom: DateTime(2026, 8, 25),
      availableUntil: DateTime(2026, 8, 27),
    );

    expect(isWirdAvailableOn(wird, DateTime(2026, 8, 24)), isFalse);
    expect(isWirdAvailableOn(wird, DateTime(2026, 8, 25)), isTrue);
    expect(isWirdAvailableOn(wird, DateTime(2026, 8, 27)), isTrue);
    expect(isWirdAvailableOn(wird, DateTime(2026, 8, 28)), isFalse);
  });

  testWidgets('shows wird, dhikr, target, dates, and audience', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wirdProgramsProvider.overrideWith(FixedProgramsController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: WirdProgramsSection()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('إنشاء الورد الجماعي'), findsOneWidget);
    expect(find.text('ورد صباح الثلاثاء'), findsOneWidget);
    expect(find.textContaining('التسبيح'), findsOneWidget);
    expect(find.textContaining('الهدف: 100'), findsOneWidget);
    expect(find.textContaining('أطفال فرع دمشق'), findsOneWidget);
  });

  testWidgets('creation form exposes the six exclusive assignment scopes', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wirdProgramsProvider.overrideWith(FixedProgramsController.new),
        ],
        child: const MaterialApp(home: Scaffold(body: WirdProgramsSection())),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('إنشاء ورد جماعي'));
    await tester.pumpAndSettle();

    expect(find.text('اسم الورد'), findsOneWidget);
    expect(find.text('الذكر'), findsOneWidget);
    expect(find.text('الهدف'), findsOneWidget);
    expect(find.text('نطاق التكليف'), findsOneWidget);
    expect(find.text('الجمهور'), findsOneWidget);
    expect(find.textContaining('البداية:'), findsOneWidget);
    expect(find.textContaining('النهاية:'), findsOneWidget);

    await tester.tap(find.byType(DropdownButtonFormField<WirdAssignmentScope>));
    await tester.pumpAndSettle();
    for (final scope in WirdAssignmentScope.values) {
      expect(find.text(scope.arabicLabel), findsWidgets);
    }
    await tester.tap(find.text('دور').last);
    await tester.pumpAndSettle();
    expect(find.text('الأدوار'), findsOneWidget);
    expect(find.text('معلم'), findsWidgets);
  });
}

WirdProgram _program({required String id, required String name}) => WirdProgram(
  id: id,
  organizationId: 'org-1',
  name: name,
  dhikrDefinitionId: 'dhikr-1',
  dhikrTitleSnapshot: 'التسبيح',
  dhikrTextSnapshot: 'نص مراجع للاختبار',
  targetCount: 100,
  startsOn: DateTime(2026, 8, 25),
  endsOn: DateTime(2026, 8, 26),
  audienceName: 'أطفال فرع دمشق',
  scopeType: WirdAssignmentScope.schoolClass,
);

class FixedProgramsController extends WirdProgramsController {
  @override
  Future<WirdProgramCreationState> build() async => WirdProgramCreationState(
    programs: [_program(id: 'wird-1', name: 'ورد صباح الثلاثاء')],
    dhikrDefinitions: const [
      DhikrDefinition(
        id: 'dhikr-1',
        title: 'التسبيح',
        displayText: 'نص مراجع للاختبار',
        defaultTarget: 100,
        status: DhikrDefinitionStatus.approved,
        createdBy: 'admin-1',
      ),
    ],
    branches: const [
      Branch(id: 'branch-1', organizationId: 'org-1', name: 'فرع دمشق'),
      Branch(id: 'branch-2', organizationId: 'org-1', name: 'فرع حلب'),
    ],
    classes: const [
      SchoolClass(id: 'class-1', branchId: 'branch-1', name: 'تمهيدي A'),
    ],
    users: const [
      ManagedUser(
        id: 'user-1',
        branchId: 'branch-1',
        classId: 'class-1',
        userType: ManagedUserType.child,
        fullName: 'مستخدم اختباري',
      ),
    ],
  );
}
