import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/application/branch_dashboard_controller.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_daily_metrics.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_dashboard_repository.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

enum BranchDashboardModule {
  users('Users', 'المستخدمون', Icons.people_outline),
  classes('Classes', 'الصفوف', Icons.class_outlined),
  wirds('Wirds', 'الأوراد', Icons.menu_book_outlined),
  campaigns('Campaigns', 'الحملات', Icons.campaign_outlined),
  reports('Reports', 'التقارير', Icons.assessment_outlined),
  rewards('Rewards', 'المكافآت', Icons.emoji_events_outlined);

  const BranchDashboardModule(this.englishLabel, this.arabicLabel, this.icon);

  final String englishLabel;
  final String arabicLabel;
  final IconData icon;
}

class BranchDashboardOverview extends ConsumerWidget {
  const BranchDashboardOverview({
    required this.branch,
    required this.onModuleSelected,
    super.key,
  });

  final Branch? branch;
  final ValueChanged<BranchDashboardModule> onModuleSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(branchDashboardProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          branch == null ? 'لوحة مدير الفرع' : 'لوحة ${branch!.name}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'مؤشرات اليوم',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                if (branch == null)
                  const Text('اختر فرعًا لعرض المؤشرات.')
                else
                  metrics.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Column(
                      children: [
                        Text(
                          error is BranchDashboardFailure
                              ? error.userMessage
                              : 'تعذر تحميل مؤشرات اليوم.',
                        ),
                        TextButton(
                          onPressed: () => ref
                              .read(branchDashboardProvider.notifier)
                              .refresh(),
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                    data: (value) => _MetricsGrid(metrics: value),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: BranchDashboardModule.values.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            mainAxisExtent: 110,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final module = BranchDashboardModule.values[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onModuleSelected(module),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(module.icon, size: 30),
                      const SizedBox(height: 6),
                      Text(module.englishLabel),
                      Text(
                        module.arabicLabel,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.metrics});

  final BranchDailyMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('المستخدمون المشاركون', '${metrics.participatingUsers}', Icons.people),
      ('أكملوا الأوراد', '${metrics.completedUsers}', Icons.task_alt),
      (
        'نسبة الإنجاز',
        '${_formatRate(metrics.completionRate)}%',
        Icons.percent,
      ),
      ('إجمالي الأذكار', '${metrics.totalRecordedDhikr}', Icons.touch_app),
      (
        'الأطفال المشاركون',
        '${metrics.participatingChildren}',
        Icons.child_care,
      ),
      ('الموظفون المشاركون', '${metrics.participatingStaff}', Icons.badge),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 210,
        mainAxisExtent: 120,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.$3, size: 22),
                const SizedBox(height: 4),
                Text(item.$2, style: Theme.of(context).textTheme.titleLarge),
                Text(
                  item.$1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String _formatRate(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}
