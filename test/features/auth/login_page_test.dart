import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/auth/presentation/login_page.dart';

import 'fake_auth_repository.dart';

void main() {
  testWidgets('validates email and password before sign-in', (tester) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: LoginPage()),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const Key('login_submit')));
    await tester.pump();

    expect(find.text('أدخل بريدًا إلكترونيًا صحيحًا'), findsOneWidget);
    expect(find.text('كلمة المرور يجب ألا تقل عن 6 أحرف'), findsOneWidget);
    expect(repository.signInCalls, 0);
  });

  testWidgets(
    'student login requires organization, student code, and six digit PIN',
    (tester) async {
      final repository = FakeAuthRepository();
      addTearDown(repository.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repository)],
          child: const MaterialApp(home: LoginPage()),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('طالب'));
      await tester.pump();
      await tester.enterText(
        find.byKey(const Key('organization_code')),
        'RW-ONE',
      );
      await tester.enterText(find.byKey(const Key('student_code')), 'ST-001');
      await tester.enterText(find.byKey(const Key('student_pin')), '123456');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pump();

      expect(repository.studentSignInCalls, 1);
    },
  );
}
