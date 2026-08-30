import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/dhikr/application/dhikr_controller.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';
import 'package:ward_al_rawdah/features/employee_journey/application/employee_journey_controller.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_state.dart';
import 'package:ward_al_rawdah/features/home/presentation/member_home_page.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

void main() {
  testWidgets('shows employee wird, counter, progress, and history', (
    tester,
  ) async {
    await _pump(tester, TeacherEmployeeController.new);

    expect(find.text('وردي'), findsOneWidget);
    expect(find.text('العداد'), findsOneWidget);
    expect(find.text('تقدمي'), findsOneWidget);
    expect(find.text('السجل'), findsOneWidget);
    expect(find.text('ورد الموظف'), findsOneWidget);
    expect(find.text('12 من 30'), findsNWidgets(2));
    expect(find.text('ورد سابق'), findsOneWidget);
  });

  testWidgets('shows My Class only for an authorized linked teacher', (
    tester,
  ) async {
    await _pump(tester, TeacherEmployeeController.new);
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('صفي'), findsOneWidget);
    expect(find.text('الصف التمهيدي'), findsOneWidget);
    expect(find.text('ليان أحمد'), findsOneWidget);

    await _pump(tester, AdministratorEmployeeController.new);
    expect(find.text('صفي'), findsNothing);
  });
}

Future<void> _pump(
  WidgetTester tester,
  EmployeeJourneyController Function() controller,
) async {
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [
        employeeJourneyProvider.overrideWith(controller),
        dhikrControllerProvider.overrideWith(EmptyDhikrController.new),
      ],
      child: const MaterialApp(home: MemberHomePage()),
    ),
  );
  await tester.pumpAndSettle();
}

final _teacher = ManagedUser(
  id: 'teacher-1',
  branchId: 'branch-1',
  classId: 'class-1',
  userType: ManagedUserType.teacher,
  fullName: 'المعلمة سارة',
);

final _currentWird = ManagedWird(
  id: 'wird-1',
  branchId: 'branch-1',
  assignedUserId: 'teacher-1',
  title: 'ورد الموظف',
  targetCount: 30,
  status: ManagedWirdStatus.assigned,
);

final _historyWird = ManagedWird(
  id: 'wird-2',
  branchId: 'branch-1',
  assignedUserId: 'teacher-1',
  title: 'ورد سابق',
  targetCount: 10,
  status: ManagedWirdStatus.completed,
  completedAt: DateTime.utc(2026, 8, 24),
);

class TeacherEmployeeController extends EmployeeJourneyController {
  @override
  Future<EmployeeJourneyState?> build() async => EmployeeJourneyState(
    employee: _teacher,
    currentWird: _currentWird,
    currentCount: 12,
    history: [_historyWird],
    schoolClass: const SchoolClass(
      id: 'class-1',
      branchId: 'branch-1',
      name: 'الصف التمهيدي',
    ),
    classChildren: const [
      ManagedUser(
        id: 'child-1',
        branchId: 'branch-1',
        classId: 'class-1',
        userType: ManagedUserType.child,
        fullName: 'ليان أحمد',
      ),
    ],
  );
}

class AdministratorEmployeeController extends EmployeeJourneyController {
  @override
  Future<EmployeeJourneyState?> build() async => const EmployeeJourneyState(
    employee: ManagedUser(
      id: 'admin-1',
      branchId: 'branch-1',
      userType: ManagedUserType.administrator,
      fullName: 'الإداري أحمد',
    ),
  );
}

class EmptyDhikrController extends DhikrController {
  @override
  Future<DhikrCounter?> build() async => null;
}
