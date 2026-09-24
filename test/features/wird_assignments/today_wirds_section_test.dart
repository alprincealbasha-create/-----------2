import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/wird_assignments/application/wird_assignment_controllers.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_models.dart';
import 'package:ward_al_rawdah/features/wird_assignments/presentation/today_wirds_section.dart';

void main() {
  testWidgets('shows only the assigned snapshot and opens read-only detail', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [todayWirdsProvider.overrideWith(FixedTodayController.new)],
        child: const MaterialApp(home: Scaffold(body: TodayWirdsSection())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('وردي اليوم'), findsOneWidget);
    expect(find.text('ورد الصباح'), findsOneWidget);
    expect(find.textContaining('الهدف: 100'), findsOneWidget);
    expect(find.text('اضغط للذكر'), findsNothing);

    await tester.tap(find.byKey(const Key('today_wird_instance-1')));
    await tester.pumpAndSettle();
    expect(find.text('التسبيح'), findsOneWidget);
    expect(find.textContaining('Asia/Damascus'), findsOneWidget);
  });
}

class FixedTodayController extends TodayWirdsController {
  @override
  Future<List<TodayWird>> build() async => [
    TodayWird(
      id: 'instance-1',
      title: 'ورد الصباح',
      dhikrTitle: 'التسبيح',
      dhikrText: 'سبحان الله',
      targetCount: 100,
      startAt: DateTime.utc(2026, 9, 21),
      endAt: DateTime.utc(2026, 9, 22),
      timezoneName: 'Asia/Damascus',
      assignmentScope: 'class',
    ),
  ];
}
