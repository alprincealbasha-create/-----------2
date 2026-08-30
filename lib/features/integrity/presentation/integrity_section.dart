import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/integrity/application/integrity_controller.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_models.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_repository.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

class IntegritySection extends ConsumerWidget {
  const IntegritySection({required this.branch, super.key});

  final Branch? branch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flags = ref.watch(integrityProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'مؤشرات النزاهة',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'هذه مؤشرات للمراجعة فقط. لا تحذف الإنجاز ولا تغيّر النقاط '
              'أو الأوسمة تلقائيًا.',
            ),
            const SizedBox(height: 12),
            if (branch == null)
              const Text('اختر فرعًا لعرض المؤشرات.')
            else
              flags.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Column(
                  children: [
                    Text(
                      error is IntegrityFailure
                          ? error.userMessage
                          : 'تعذر تحميل المؤشرات.',
                    ),
                    TextButton(
                      onPressed: () =>
                          ref.read(integrityProvider.notifier).refresh(),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
                data: (items) => items.isEmpty
                    ? const Text('لا توجد مؤشرات تحتاج مراجعة.')
                    : Column(
                        children: [
                          for (final flag in items) ...[
                            _IntegrityFlagCard(flag: flag),
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
}

class _IntegrityFlagCard extends ConsumerWidget {
  const _IntegrityFlagCard({required this.flag});

  final IntegrityFlag flag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Text(flag.userName, style: Theme.of(context).textTheme.titleMedium),
            Text(flag.type.arabicLabel),
            Text('الحالة: ${flag.status.arabicLabel}'),
            Text(
              'القيمة المرصودة: ${flag.observedCount} — '
              'العتبة: ${flag.thresholdCount}',
            ),
            if (flag.status == IntegrityFlagStatus.open) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  FilledButton.tonal(
                    onPressed: () => ref
                        .read(integrityProvider.notifier)
                        .review(
                          flagId: flag.id,
                          status: IntegrityFlagStatus.reviewed,
                        ),
                    child: const Text('تمت المراجعة'),
                  ),
                  TextButton(
                    onPressed: () => ref
                        .read(integrityProvider.notifier)
                        .review(
                          flagId: flag.id,
                          status: IntegrityFlagStatus.dismissed,
                        ),
                    child: const Text('استبعاد المؤشر'),
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
