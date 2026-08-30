import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/campaigns/application/campaigns_controller.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaign_models.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaigns_repository.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';

class CampaignsSection extends ConsumerWidget {
  const CampaignsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaigns = ref.watch(campaignsProvider);
    final controller = ref.read(campaignsProvider.notifier);
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
                    'الحملات',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'إنشاء حملة',
                  onPressed: campaigns.value == null
                      ? null
                      : () async {
                          final input = await showCampaignDialog(
                            context,
                            dhikrs: campaigns.requireValue.dhikrDefinitions,
                          );
                          if (input != null) {
                            await controller.create(
                              name: input.name,
                              dhikrDefinitionId: input.dhikrDefinitionId,
                              targetCount: input.targetCount,
                            );
                          }
                        },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const Text(
              'عداد جماعي مستقل يعرض إجمالي المؤسسة ومساهمة كل فرع وفئة.',
            ),
            const SizedBox(height: 12),
            campaigns.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Column(
                children: [
                  Text(
                    error is CampaignFailure
                        ? error.userMessage
                        : 'تعذر تحميل الحملات.',
                  ),
                  TextButton(
                    onPressed: controller.refresh,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
              data: (value) {
                if (value.dhikrDefinitions.isEmpty) {
                  return const Text(
                    'اعتمد تعريف ذكر واحدًا على الأقل قبل إنشاء حملة.',
                  );
                }
                if (value.campaigns.isEmpty) {
                  return const Text('لا توجد حملات بعد.');
                }
                return Column(
                  children: [
                    for (final campaign in value.campaigns)
                      _CampaignTile(campaign: campaign),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CampaignTile extends StatelessWidget {
  const _CampaignTile({required this.campaign});

  final CampaignDashboardItem campaign;

  @override
  Widget build(BuildContext context) {
    final progress = campaign.targetCount == 0
        ? 0.0
        : (campaign.currentCount / campaign.targetCount).clamp(0.0, 1.0);
    return Card.outlined(
      child: ExpansionTile(
        leading: const Icon(Icons.campaign_outlined),
        title: Text(campaign.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('${campaign.dhikrTitle} — ${campaign.status.arabicLabel}'),
            const SizedBox(height: 6),
            LinearProgressIndicator(value: progress, minHeight: 8),
            const SizedBox(height: 4),
            Text(
              '${_formatNumber(campaign.currentCount)} / '
              '${_formatNumber(campaign.targetCount)}',
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          _ContributionGroup(
            title: 'جميع المستخدمين مجتمعين',
            rows: [('الإجمالي', campaign.currentCount)],
          ),
          _ContributionGroup(
            title: 'مساهمة الفروع',
            rows: [
              for (final item in campaign.branchContributions)
                (item.branchName, item.count),
            ],
          ),
          _ContributionGroup(
            title: 'مساهمة الفئات',
            rows: [
              for (final item in campaign.categoryContributions)
                (item.category.arabicLabel, item.count),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContributionGroup extends StatelessWidget {
  const _ContributionGroup({required this.title, required this.rows});

  final String title;
  final List<(String, int)> rows;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          for (final row in rows)
            Row(
              children: [
                Expanded(child: Text(row.$1)),
                Text(_formatNumber(row.$2)),
              ],
            ),
        ],
      ),
    );
  }
}

class CampaignInput {
  const CampaignInput({
    required this.name,
    required this.dhikrDefinitionId,
    required this.targetCount,
  });

  final String name;
  final String dhikrDefinitionId;
  final int targetCount;
}

Future<CampaignInput?> showCampaignDialog(
  BuildContext context, {
  required List<DhikrDefinition> dhikrs,
}) async {
  if (dhikrs.isEmpty) return null;
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final target = TextEditingController(text: '500000');
  var dhikrId = dhikrs.first.id;
  final result = await showDialog<CampaignInput>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('إنشاء حملة'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(labelText: 'اسم الحملة'),
              validator: _requiredText,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: dhikrId,
              decoration: const InputDecoration(labelText: 'الذكر'),
              items: [
                for (final dhikr in dhikrs)
                  DropdownMenuItem(value: dhikr.id, child: Text(dhikr.title)),
              ],
              onChanged: (value) {
                if (value != null) dhikrId = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: target,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'هدف المؤسسة'),
              validator: (value) {
                final parsed = int.tryParse(value ?? '');
                return parsed == null || parsed < 1 || parsed > 1000000000
                    ? 'أدخل هدفًا بين 1 و1000000000'
                    : null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              CampaignInput(
                name: name.text.trim(),
                dhikrDefinitionId: dhikrId,
                targetCount: int.parse(target.text),
              ),
            );
          },
          child: const Text('إنشاء'),
        ),
      ],
    ),
  );
  name.dispose();
  target.dispose();
  return result;
}

String? _requiredText(String? value) =>
    value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;

String _formatNumber(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) buffer.write(',');
    buffer.write(digits[index]);
  }
  return buffer.toString();
}
