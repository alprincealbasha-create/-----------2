import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/dhikr/application/dhikr_controller.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';
import 'package:ward_al_rawdah/features/dhikr/presentation/dhikr_screen.dart';

void main() {
  testWidgets('opens counter setup and validates its fields', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dhikrControllerProvider.overrideWith(EmptyDhikrController.new),
        ],
        child: const MaterialApp(home: DhikrScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('أنشئ عدادًا خاصًا بك'), findsOneWidget);
    await tester.tap(find.text('إنشاء عداد'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('بدء'));
    await tester.pump();

    expect(find.text('العنوان مطلوب'), findsOneWidget);
    expect(find.text('أدخل رقمًا بين 1 و100000'), findsOneWidget);
  });

  testWidgets('shows restored offline progress as 50 of 100', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dhikrControllerProvider.overrideWith(RestoredDhikrController.new),
        ],
        child: const MaterialApp(home: DhikrScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('50'), findsOneWidget);
    expect(find.text('من 100'), findsOneWidget);
    expect(find.text('بانتظار المزامنة (30)'), findsOneWidget);
    final progressFinder = find.bySemanticsLabel('تقدم الذكر');
    expect(progressFinder, findsOneWidget);
    final progressSemantics = tester.getSemantics(progressFinder);
    expect(progressSemantics.label, 'تقدم الذكر');
    expect(progressSemantics.value, '50 من 100');
  });
}

class EmptyDhikrController extends DhikrController {
  @override
  Future<DhikrCounter?> build() async => null;
}

class RestoredDhikrController extends DhikrController {
  @override
  Future<DhikrCounter?> build() async => const DhikrCounter(
    id: 'session-1',
    title: 'عداد محفوظ',
    target: 100,
    count: 50,
    completionState: DhikrCompletionState.inProgress,
    pendingSyncCount: 30,
    syncState: DhikrSyncState.pending,
  );
}
