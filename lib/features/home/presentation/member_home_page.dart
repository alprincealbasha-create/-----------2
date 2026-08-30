import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:ward_al_rawdah/routing/app_router.dart';
import 'package:ward_al_rawdah/features/child_journey/application/child_wird_controller.dart';
import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_repository.dart';
import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_state.dart';
import 'package:ward_al_rawdah/features/dhikr/application/dhikr_controller.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';
import 'package:ward_al_rawdah/features/employee_journey/application/employee_journey_controller.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_repository.dart';
import 'package:ward_al_rawdah/features/employee_journey/presentation/employee_home_content.dart';

class MemberHomePage extends ConsumerWidget {
  const MemberHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeJourney = ref.watch(employeeJourneyProvider);
    if (employeeJourney case AsyncLoading()) {
      return _homeScaffold(
        ref: ref,
        title: 'الرئيسية',
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (employeeJourney case AsyncError(:final error)) {
      return _homeScaffold(
        ref: ref,
        title: 'الرئيسية',
        body: _HomeError(
          message: error is EmployeeJourneyFailure
              ? error.userMessage
              : 'تعذر تحديد بيانات الحساب.',
          onRetry: () => ref.read(employeeJourneyProvider.notifier).refresh(),
        ),
      );
    }
    final employee = employeeJourney.value;
    if (employee != null) {
      return _homeScaffold(
        ref: ref,
        title: 'مرحبًا ${employee.employee.fullName}',
        body: EmployeeHomeContent(state: employee),
      );
    }

    final childWird = ref.watch(childWirdProvider);
    final localCounter = ref.watch(dhikrControllerProvider).value;
    return _homeScaffold(
      ref: ref,
      title: 'الرئيسية',
      body: childWird.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _HomeError(
          message: error is ChildWirdFailure
              ? error.userMessage
              : 'تعذر تحميل ورد اليوم.',
          onRetry: () => ref.read(childWirdProvider.notifier).refresh(),
        ),
        data: (state) {
          final wird = state.wird;
          final count = wird != null && localCounter?.managedWirdId == wird.id
              ? localCounter!.count
              : 0;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ChildSection(
                title: 'وردي',
                child: _WirdContent(
                  wird: wird,
                  count: count,
                  onOpen: wird == null
                      ? null
                      : () async {
                          final target = wird.targetCount;
                          if (target == null) return;
                          await ref
                              .read(dhikrControllerProvider.notifier)
                              .openManagedWird(
                                wirdId: wird.id,
                                title: wird.dhikrTextSnapshot ?? wird.title,
                                target: target,
                              );
                          if (context.mounted) context.go(AppRoutes.dhikr);
                        },
                ),
              ),
              const SizedBox(height: 12),
              _ChildSection(
                title: 'إنجازاتي',
                child: _AchievementsContent(
                  completedWirds: state.reward.completedWirds,
                ),
              ),
              const SizedBox(height: 12),
              _ChildSection(
                title: 'مكافآتي',
                child: _RewardsContent(
                  points: state.reward.points,
                  currentStreak: state.reward.currentStreak,
                  bestStreak: state.reward.bestStreak,
                  badges: state.reward.badges,
                  badge: state.reward.badge,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _homeScaffold({
  required WidgetRef ref,
  required String title,
  required Widget body,
}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      actions: [
        IconButton(
          tooltip: 'تسجيل الخروج',
          onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
          icon: const Icon(Icons.logout),
        ),
      ],
    ),
    body: body,
  );
}

class _ChildSection extends StatelessWidget {
  const _ChildSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _WirdContent extends StatelessWidget {
  const _WirdContent({
    required this.wird,
    required this.count,
    required this.onOpen,
  });

  final ManagedWird? wird;
  final int count;
  final Future<void> Function()? onOpen;

  @override
  Widget build(BuildContext context) {
    final item = wird;
    if (item == null) return const Text('لا يوجد ورد مكلّف اليوم.');
    if (item.status == ManagedWirdStatus.completed) {
      return Text(
        '🌟 أحسنت، أتممت هذا الورد.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (item.dhikrTextSnapshot != null) ...[
          const SizedBox(height: 8),
          Text(
            item.dhikrTextSnapshot!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
        if (item.details != null) ...[
          const SizedBox(height: 8),
          Text(item.details!, textAlign: TextAlign.center),
        ],
        const SizedBox(height: 12),
        Text(
          '$count من ${item.targetCount}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 64,
          child: FilledButton(
            onPressed: onOpen,
            child: Text(count == 0 ? 'ابدأ الورد' : 'تابع الورد'),
          ),
        ),
      ],
    );
  }
}

class _AchievementsContent extends StatelessWidget {
  const _AchievementsContent({required this.completedWirds});

  final int completedWirds;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.task_alt, size: 32),
        const SizedBox(width: 12),
        Text(
          '$completedWirds ورد مكتمل',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _RewardsContent extends StatelessWidget {
  const _RewardsContent({
    required this.points,
    required this.currentStreak,
    required this.bestStreak,
    required this.badges,
    required this.badge,
  });

  final int points;
  final int currentStreak;
  final int bestStreak;
  final List<EarnedBadge> badges;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.stars_outlined, size: 32),
            const SizedBox(width: 12),
            Text(
              'النقاط: $points',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        if (currentStreak > 0 || bestStreak > 0) ...[
          const SizedBox(height: 12),
          Text('الالتزام الحالي: $currentStreak يوم'),
          Text('أفضل التزام: $bestStreak يوم'),
        ],
        if (badges.isNotEmpty) ...[
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final earned in badges)
                Tooltip(
                  message: earned.description,
                  child: Chip(label: Text('${earned.emoji} ${earned.name}')),
                ),
            ],
          ),
        ] else if (badge == 'first_wird') ...[
          const SizedBox(height: 12),
          const Text('🏅 شارة: أول ورد'),
        ] else if (points == 0)
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text('أكمل وردك الأول لتحصل على مكافأتك.'),
          ),
      ],
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            TextButton(onPressed: onRetry, child: const Text('إعادة المحاولة')),
          ],
        ),
      ),
    );
  }
}
