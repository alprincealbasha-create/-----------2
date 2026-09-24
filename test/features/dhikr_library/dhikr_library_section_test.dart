import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/dhikr_library/application/dhikr_library_controller.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_user.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/dhikr_library/presentation/dhikr_library_section.dart';

void main() {
  test('maps the required dhikr definition fields', () {
    final definition = DhikrDefinition.fromJson({
      'id': 'dhikr-1',
      'title': 'التسبيح',
      'display_text': 'نص قدمه المستخدم',
      'description': 'وصف',
      'default_target': 100,
      'status': 'draft',
      'created_by': 'admin-1',
      'content_version': 1,
    });

    expect(definition.id, 'dhikr-1');
    expect(definition.title, 'التسبيح');
    expect(definition.displayText, 'نص قدمه المستخدم');
    expect(definition.defaultTarget, 100);
    expect(definition.status, DhikrDefinitionStatus.draft);
    expect(definition.createdBy, 'admin-1');
  });

  testWidgets('shows dhikr content, target, review status, and source', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dhikrLibraryProvider.overrideWith(FixedLibraryController.new),
          authControllerProvider.overrideWith(FixedAdminController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: DhikrLibrarySection()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('مكتبة الأذكار المعتمدة'), findsOneWidget);
    expect(find.text('التسبيح'), findsOneWidget);
    expect(find.text('نص مراجع للاختبار'), findsOneWidget);
    expect(find.textContaining('الهدف الافتراضي: 100'), findsOneWidget);
    expect(
      find.text('الهدف الافتراضي: 100 — معتمد — الإصدار 2'),
      findsOneWidget,
    );
    expect(find.text('المصدر: مرجع بشري موثق'), findsOneWidget);
  });
}

class FixedLibraryController extends DhikrLibraryController {
  @override
  Future<List<DhikrDefinition>> build() async => const [
    DhikrDefinition(
      id: 'dhikr-1',
      title: 'التسبيح',
      displayText: 'نص مراجع للاختبار',
      description: 'وصف',
      defaultTarget: 100,
      status: DhikrDefinitionStatus.approved,
      createdBy: 'admin-1',
      sourceReference: 'مرجع بشري موثق',
      contentVersion: 2,
      reviewedBy: 'reviewer-1',
    ),
  ];
}

class FixedAdminController extends AuthController {
  @override
  AuthState build() => const AuthState.authenticated(
    AuthUser(
      id: 'admin-1',
      organizationId: 'org-1',
      role: AppRole.organizationAdmin,
    ),
  );
}
