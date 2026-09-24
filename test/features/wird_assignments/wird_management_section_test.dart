import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/wird_assignments/application/wird_assignment_controllers.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_models.dart';
import 'package:ward_al_rawdah/features/wird_assignments/presentation/wird_management_section.dart';

void main() {
  test('multiple branch selection becomes atomic branch assignment rows', () {
    final assignments = buildAssignmentsForTest(
      scope: AssignmentScope.branch,
      data: _data(),
      role: AppRole.organizationAdmin,
      branchIds: {'branch-1', 'branch-2'},
    );
    expect(assignments, hasLength(2));
    expect(
      assignments.every((item) => item.scope == AssignmentScope.branch),
      isTrue,
    );
  });

  testWidgets('organization admin sees all five assignment scopes', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(FixedOrgAdminController.new),
          wirdManagementProvider.overrideWith(FixedManagementController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: WirdManagementSection()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('create_wird')));
    await tester.pumpAndSettle();
    expect(find.text('إنشاء ورد وتكليفه'), findsOneWidget);
    await tester.tap(find.byKey(const Key('assignment_scope')));
    await tester.pumpAndSettle();
    for (final scope in AssignmentScope.values) {
      expect(find.text(scope.arabicLabel), findsWidgets);
    }
  });

  testWidgets('branch manager is not offered organization-wide assignment', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(FixedBranchManagerController.new),
          wirdManagementProvider.overrideWith(FixedManagementController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: WirdManagementSection()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('create_wird')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('assignment_scope')));
    await tester.pumpAndSettle();
    expect(find.text(AssignmentScope.organization.arabicLabel), findsNothing);
  });
}

WirdManagementData _data() => WirdManagementData(
  dhikr: const [
    DhikrDefinition(
      id: 'dhikr-1',
      title: 'التسبيح',
      displayText: 'سبحان الله',
      defaultTarget: 100,
      status: DhikrDefinitionStatus.approved,
      createdBy: 'admin-1',
    ),
  ],
  branches: const [
    AudienceBranch(id: 'branch-1', name: 'دمشق'),
    AudienceBranch(id: 'branch-2', name: 'حلب'),
  ],
  classes: const [
    AudienceClass(id: 'class-1', branchId: 'branch-1', name: 'تمهيدي A'),
  ],
  users: const [
    AudienceUser(
      id: 'user-1',
      name: 'طفل اختباري',
      role: 'student',
      branchId: 'branch-1',
    ),
  ],
);

class FixedManagementController extends WirdManagementController {
  @override
  Future<WirdManagementData> build() async => _data();
}

class FixedOrgAdminController extends AuthController {
  @override
  AuthState build() => const AuthState.authenticated(
    AuthUser(
      id: 'admin-1',
      organizationId: 'org-1',
      role: AppRole.organizationAdmin,
    ),
  );
}

class FixedBranchManagerController extends AuthController {
  @override
  AuthState build() => const AuthState.authenticated(
    AuthUser(
      id: 'manager-1',
      organizationId: 'org-1',
      branchId: 'branch-1',
      role: AppRole.branchManager,
    ),
  );
}
