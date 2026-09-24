import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/wird_assignments/application/wird_assignment_controllers.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_models.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_repository.dart';

class TodayWirdsSection extends ConsumerWidget {
  const TodayWirdsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todayWirdsProvider);
    return RefreshIndicator(
      onRefresh: ref.read(todayWirdsProvider.notifier).refresh,
      child: ListView(
        key: const Key('today_wirds_list'),
        padding: const EdgeInsets.all(20),
        children: [
          Text('وردي اليوم', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          ...state.when(
            loading: () => const [Center(child: CircularProgressIndicator())],
            error: (error, _) => [
              const Icon(Icons.cloud_off_outlined, size: 42),
              const SizedBox(height: 8),
              Text(
                error is WirdAssignmentFailure
                    ? error.userMessage
                    : 'تعذر تحميل ورد اليوم.',
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: ref.read(todayWirdsProvider.notifier).refresh,
                child: const Text('إعادة المحاولة'),
              ),
            ],
            data: (items) => items.isEmpty
                ? const [
                    SizedBox(height: 48),
                    Icon(Icons.eco_outlined, size: 56),
                    SizedBox(height: 12),
                    Text(
                      'لا يوجد ورد مكلّف لك اليوم.',
                      textAlign: TextAlign.center,
                    ),
                  ]
                : items.map((item) => _TodayWirdCard(item: item)).toList(),
          ),
        ],
      ),
    );
  }
}

class _TodayWirdCard extends StatelessWidget {
  const _TodayWirdCard({required this.item});
  final TodayWird item;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      key: Key('today_wird_${item.id}'),
      leading: const CircleAvatar(child: Icon(Icons.menu_book_outlined)),
      title: Text(item.title),
      subtitle: Text('${item.dhikrText}\nالهدف: ${item.targetCount}'),
      isThreeLine: true,
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(item.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.dhikrTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                item.dhikrText,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text('الهدف: ${item.targetCount}'),
              Text('المنطقة الزمنية: ${item.timezoneName}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        ),
      ),
    ),
  );
}
