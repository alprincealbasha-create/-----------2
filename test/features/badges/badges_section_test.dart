import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/badges/application/badges_controller.dart';
import 'package:ward_al_rawdah/features/badges/domain/badge_models.dart';
import 'package:ward_al_rawdah/features/badges/presentation/badges_section.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/application/branch_users_controller.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

void main() {
  test('maps full child reward data without a rank field', () {
    final child = ChildRewardOverview.fromRpc({
      'child_id': 'child-1',
      'child_name': 'طفل الاختبار',
      'class_name': 'التمهيدي',
      'completed_wirds': 9,
      'points': 180,
      'current_streak': 7,
      'best_streak': 12,
      'earned_badges': [
        {
          'code': 'consistent',
          'name': 'المواظب',
          'emoji': '⭐',
          'description': 'وصف الاختبار',
        },
      ],
    });

    expect(child.points, 180);
    expect(child.completedWirds, 9);
    expect(child.badges.single.code, 'consistent');
  });

  testWidgets('shows manual badge and opens award form for a child', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          badgesProvider.overrideWith(FixedBadgesController.new),
          branchUsersProvider.overrideWith(FixedChildrenController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: BadgesSection(
              branch: Branch(
                id: 'branch-1',
                organizationId: 'organization-1',
                name: 'فرع الاختبار',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('الأوسمة والمكافآت'), findsOneWidget);
    expect(find.text('🏆 الاستمرار'), findsOneWidget);
    expect(find.text('طفل الاختبار'), findsOneWidget);
    expect(find.text('الأوراد المكتملة: 9'), findsOneWidget);
    expect(find.text('النقاط: 180'), findsOneWidget);
    expect(find.text('الاستمرار الحالي: 7 يوم'), findsOneWidget);
    expect(find.text('أفضل استمرار: 12 يوم'), findsOneWidget);
    expect(find.text('⭐ المواظب'), findsOneWidget);
    expect(find.textContaining('الترتيب'), findsNothing);

    await tester.tap(find.text('منح وسام'));
    await tester.pumpAndSettle();

    expect(find.text('منح وسام متقدم'), findsOneWidget);
    expect(find.text('طفل الاختبار'), findsNWidgets(2));
    expect(find.text('الطفل'), findsOneWidget);
    expect(find.text('الوسام'), findsOneWidget);
  });
}

class FixedBadgesController extends BadgesController {
  @override
  Future<BadgeManagementState> build() async => const BadgeManagementState(
    manualBadges: [
      ManualBadgeDefinition(
        id: 'badge-1',
        name: 'الاستمرار',
        emoji: '🏆',
        description: 'مرحلة متقدمة تمنحها الإدارة.',
      ),
    ],
    childRewards: [
      ChildRewardOverview(
        childId: 'child-1',
        childName: 'طفل الاختبار',
        className: 'التمهيدي',
        completedWirds: 9,
        points: 180,
        currentStreak: 7,
        bestStreak: 12,
        badges: [
          RewardBadgeSummary(
            code: 'consistent',
            name: 'المواظب',
            emoji: '⭐',
            description: 'إتمام الأوراد 7 أيام متتالية.',
          ),
        ],
      ),
    ],
  );
}

class FixedChildrenController extends BranchUsersController {
  @override
  Future<List<ManagedUser>> build() async => const [
    ManagedUser(
      id: 'child-1',
      branchId: 'branch-1',
      classId: 'class-1',
      userType: ManagedUserType.child,
      fullName: 'طفل الاختبار',
    ),
  ];
}
