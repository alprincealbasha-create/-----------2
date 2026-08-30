import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ward_al_rawdah/features/dhikr/application/dhikr_controller.dart';
import 'package:ward_al_rawdah/features/employee_journey/domain/employee_journey_state.dart';
import 'package:ward_al_rawdah/routing/app_router.dart';

class EmployeeHomeContent extends ConsumerWidget {
  const EmployeeHomeContent({required this.state, super.key});

  final EmployeeJourneyState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wird = state.currentWird;
    final localCounter = ref.watch(dhikrControllerProvider).value;
    final count = wird != null && localCounter?.managedWirdId == wird.id
        ? localCounter!.count
        : state.currentCount;
    final target = wird?.targetCount ?? 0;
    final progress = target <= 0 ? 0.0 : (count / target).clamp(0.0, 1.0);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _EmployeeSection(
          title: 'وردي',
          child: wird == null
              ? const Text('لا يوجد ورد مكلّف حاليًا.')
              : Column(
                  children: [
                    Text(
                      wird.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (wird.dhikrTextSnapshot != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        wird.dhikrTextSnapshot!,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
        ),
        const SizedBox(height: 12),
        _EmployeeSection(
          title: 'العداد',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                wird == null ? '—' : '$count من $target',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 64,
                child: FilledButton(
                  onPressed: wird == null || target <= 0
                      ? null
                      : () async {
                          await ref
                              .read(dhikrControllerProvider.notifier)
                              .openManagedWird(
                                wirdId: wird.id,
                                title: wird.dhikrTextSnapshot ?? wird.title,
                                target: target,
                              );
                          if (context.mounted) context.go(AppRoutes.dhikr);
                        },
                  child: const Text('فتح العداد'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _EmployeeSection(
          title: 'تقدمي',
          child: Column(
            children: [
              LinearProgressIndicator(value: progress, minHeight: 10),
              const SizedBox(height: 8),
              Text(wird == null ? 'لا يوجد تقدم حالي.' : '$count من $target'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _EmployeeSection(
          title: 'السجل',
          child: state.history.isEmpty
              ? const Text('لا توجد أوراد مكتملة بعد.')
              : Column(
                  children: [
                    for (final item in state.history)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.task_alt),
                        title: Text(item.title),
                        subtitle: item.completedAt == null
                            ? null
                            : Text(_formatDate(item.completedAt!)),
                      ),
                  ],
                ),
        ),
        if (state.schoolClass != null) ...[
          const SizedBox(height: 12),
          _EmployeeSection(
            title: 'صفي',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  state.schoolClass!.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.classChildren.length} طفل',
                  textAlign: TextAlign.center,
                ),
                if (state.classChildren.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final child in state.classChildren)
                        Chip(label: Text(child.fullName)),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _EmployeeSection extends StatelessWidget {
  const _EmployeeSection({required this.title, required this.child});

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

String _formatDate(DateTime value) {
  final date = value.toLocal();
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}
