import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/child_journey/application/child_wird_controller.dart';
import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_state.dart';
import 'package:ward_al_rawdah/features/dhikr/application/dhikr_controller.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';
import 'package:ward_al_rawdah/features/home/presentation/member_home_page.dart';
import 'package:ward_al_rawdah/features/employee_journey/application/employee_journey_controller.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_state.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';

void main() {
  testWidgets('shows a very simple assigned wird card', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          childWirdProvider.overrideWith(AssignedChildWirdController.new),
          dhikrControllerProvider.overrideWith(EmptyDhikrController.new),
          employeeJourneyProvider.overrideWith(NoEmployeeController.new),
        ],
        child: const MaterialApp(home: MemberHomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('وردي'), findsOneWidget);
    expect(find.text('إنجازاتي'), findsOneWidget);
    expect(find.text('مكافآتي'), findsOneWidget);
    expect(find.text('سبحان الله'), findsOneWidget);
    expect(find.text('0 من 100'), findsOneWidget);
    expect(find.text('ابدأ الورد'), findsOneWidget);
  });

  testWidgets('shows completion points and first badge', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          childWirdProvider.overrideWith(CompletedChildWirdController.new),
          dhikrControllerProvider.overrideWith(EmptyDhikrController.new),
          employeeJourneyProvider.overrideWith(NoEmployeeController.new),
        ],
        child: const MaterialApp(home: MemberHomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('🌟 أحسنت، أتممت هذا الورد.'), findsOneWidget);
    expect(find.text('وردي'), findsOneWidget);
    expect(find.text('إنجازاتي'), findsOneWidget);
    expect(find.text('مكافآتي'), findsOneWidget);
    expect(find.text('1 ورد مكتمل'), findsOneWidget);
    expect(find.text('النقاط: 80'), findsOneWidget);
    expect(find.text('الالتزام الحالي: 7 يوم'), findsOneWidget);
    expect(find.text('أفضل التزام: 12 يوم'), findsOneWidget);
    expect(find.text('🌱 البداية الطيبة'), findsOneWidget);
    expect(find.text('⭐ المواظب'), findsOneWidget);
    expect(find.textContaining('أنت رقم'), findsNothing);
    expect(find.textContaining('من أصل'), findsNothing);
    expect(find.textContaining('الترتيب'), findsNothing);
    expect(find.textContaining('المركز'), findsNothing);
  });
}

final _assignedWird = ManagedWird(
  id: 'wird-1',
  branchId: 'branch-1',
  assignedUserId: 'child-1',
  title: 'سبحان الله',
  targetCount: 100,
  status: ManagedWirdStatus.assigned,
);

class AssignedChildWirdController extends ChildWirdController {
  @override
  Future<ChildWirdState> build() async => ChildWirdState(wird: _assignedWird);
}

class CompletedChildWirdController extends ChildWirdController {
  @override
  Future<ChildWirdState> build() async => ChildWirdState(
    wird: _assignedWird.copyWith(status: ManagedWirdStatus.completed),
    reward: const ChildReward(
      points: 80,
      completedWirds: 1,
      currentStreak: 7,
      bestStreak: 12,
      badges: [
        EarnedBadge(
          code: 'good_start',
          name: 'البداية الطيبة',
          emoji: '🌱',
          description: 'إتمام أول ورد.',
        ),
        EarnedBadge(
          code: 'consistent',
          name: 'المواظب',
          emoji: '⭐',
          description: 'إتمام الأوراد 7 أيام متتالية.',
        ),
      ],
      badge: 'first_wird',
    ),
  );
}

class EmptyDhikrController extends DhikrController {
  @override
  Future<DhikrCounter?> build() async => null;
}

class NoEmployeeController extends EmployeeJourneyController {
  @override
  Future<EmployeeJourneyState?> build() async => null;
}
