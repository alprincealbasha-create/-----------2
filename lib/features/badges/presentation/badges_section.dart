import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/badges/application/badges_controller.dart';
import 'package:ward_al_rawdah/features/badges/domain/badge_models.dart';
import 'package:ward_al_rawdah/features/badges/domain/badges_repository.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/application/branch_users_controller.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

class BadgesSection extends ConsumerWidget {
  const BadgesSection({required this.branch, super.key});

  final Branch? branch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badges = ref.watch(badgesProvider);
    final users = ref.watch(branchUsersProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'الأوسمة والمكافآت',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                FilledButton.icon(
                  onPressed: branch == null
                      ? null
                      : () => _openAwardDialog(context, ref, badges, users),
                  icon: const Icon(Icons.emoji_events_outlined),
                  label: const Text('منح وسام'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'تُمنح أوسمة البداية والمواظبة والمتميز تلقائيًا. '
              'أما وسام الاستمرار المتقدم فتمنحه الإدارة.',
            ),
            const SizedBox(height: 12),
            badges.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text(
                error is BadgeManagementFailure
                    ? error.userMessage
                    : 'تعذر تحميل الأوسمة.',
              ),
              data: (value) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (value.manualBadges.isEmpty)
                    const Text('لا توجد أوسمة يدوية مفعلة.')
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final badge in value.manualBadges)
                          Chip(label: Text('${badge.emoji} ${badge.name}')),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'بيانات أطفال الفرع',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (branch == null)
                    const Text('اختر فرعًا لعرض بيانات الأطفال.')
                  else if (value.childRewards.isEmpty)
                    const Text('لا يوجد أطفال نشطون في هذا الفرع.')
                  else
                    for (final child in value.childRewards) ...[
                      _ChildRewardCard(child: child),
                      const SizedBox(height: 8),
                    ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openAwardDialog(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<BadgeManagementState> badges,
    AsyncValue<List<ManagedUser>> users,
  ) async {
    final availableBadges = badges.value?.manualBadges ?? const [];
    final children = (users.value ?? const [])
        .where((user) => user.userType == ManagedUserType.child)
        .toList(growable: false);
    if (availableBadges.isEmpty || children.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يلزم وجود طفل ووسام يدوي مفعّل.')),
      );
      return;
    }
    final input = await showDialog<_BadgeAwardInput>(
      context: context,
      builder: (context) =>
          _BadgeAwardDialog(badges: availableBadges, children: children),
    );
    if (input == null) return;
    try {
      await ref
          .read(badgesProvider.notifier)
          .award(badgeId: input.badgeId, branchUserId: input.childId);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('تم منح الوسام.')));
      }
    } on BadgeManagementFailure catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.userMessage)));
      }
    }
  }
}

class _ChildRewardCard extends StatelessWidget {
  const _ChildRewardCard({required this.child});

  final ChildRewardOverview child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              child.childName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (child.className != null) Text('الصف: ${child.className}'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                Text('الأوراد المكتملة: ${child.completedWirds}'),
                Text('النقاط: ${child.points}'),
                Text('الاستمرار الحالي: ${child.currentStreak} يوم'),
                Text('أفضل استمرار: ${child.bestStreak} يوم'),
              ],
            ),
            if (child.badges.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final badge in child.badges)
                    Tooltip(
                      message: badge.description,
                      child: Chip(label: Text('${badge.emoji} ${badge.name}')),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BadgeAwardInput {
  const _BadgeAwardInput({required this.badgeId, required this.childId});

  final String badgeId;
  final String childId;
}

class _BadgeAwardDialog extends StatefulWidget {
  const _BadgeAwardDialog({required this.badges, required this.children});

  final List<ManualBadgeDefinition> badges;
  final List<ManagedUser> children;

  @override
  State<_BadgeAwardDialog> createState() => _BadgeAwardDialogState();
}

class _BadgeAwardDialogState extends State<_BadgeAwardDialog> {
  late String _badgeId = widget.badges.first.id;
  late String _childId = widget.children.first.id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('منح وسام متقدم'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _childId,
            decoration: const InputDecoration(labelText: 'الطفل'),
            items: [
              for (final child in widget.children)
                DropdownMenuItem(value: child.id, child: Text(child.fullName)),
            ],
            onChanged: (value) => setState(() => _childId = value ?? _childId),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _badgeId,
            decoration: const InputDecoration(labelText: 'الوسام'),
            items: [
              for (final badge in widget.badges)
                DropdownMenuItem(
                  value: badge.id,
                  child: Text('${badge.emoji} ${badge.name}'),
                ),
            ],
            onChanged: (value) => setState(() => _badgeId = value ?? _badgeId),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            _BadgeAwardInput(badgeId: _badgeId, childId: _childId),
          ),
          child: const Text('منح'),
        ),
      ],
    );
  }
}
