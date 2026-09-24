import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/dhikr_library/application/dhikr_library_controller.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_library_repository.dart';

class DhikrLibrarySection extends ConsumerWidget {
  const DhikrLibrarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final definitions = ref.watch(dhikrLibraryProvider);
    final controller = ref.read(dhikrLibraryProvider.notifier);
    final actor = switch (ref.watch(authControllerProvider)) {
      AuthAuthenticated(:final user) => user,
      _ => null,
    };
    final canApprove = actor?.role == AppRole.organizationAdmin;
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
                    'مكتبة الأذكار المعتمدة',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'إضافة ذكر',
                  onPressed: () async {
                    final input = await showDhikrDefinitionDialog(context);
                    if (input != null) {
                      await controller.createDefinition(
                        title: input.title,
                        displayText: input.displayText,
                        defaultTarget: input.defaultTarget,
                        description: input.description,
                        sourceReference: input.sourceReference,
                      );
                    }
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const Text(
              'لا يظهر الذكر للمستخدمين بوصفه معتمدًا قبل توثيق المصدر والمراجعة.',
            ),
            const SizedBox(height: 12),
            definitions.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Column(
                children: [
                  Text(
                    error is DhikrLibraryFailure
                        ? error.userMessage
                        : 'تعذر تحميل مكتبة الأذكار.',
                  ),
                  TextButton(
                    onPressed: controller.refresh,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
              data: (items) => items.isEmpty
                  ? const Text('لا توجد تعريفات أذكار بعد.')
                  : Column(
                      children: [
                        for (final item in items)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(item.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.displayText),
                                Text(
                                  'الهدف الافتراضي: ${item.defaultTarget} — '
                                  '${item.status.arabicLabel} — '
                                  'الإصدار ${item.contentVersion}',
                                ),
                                if (item.sourceReference != null)
                                  Text('المصدر: ${item.sourceReference}'),
                              ],
                            ),
                            trailing: IconButton(
                              tooltip: 'تعديل تعريف الذكر',
                              onPressed:
                                  actor == null ||
                                      (!canApprove &&
                                          item.ownerBranchId != actor.branchId)
                                  ? null
                                  : () async {
                                      final input =
                                          await showDhikrDefinitionDialog(
                                            context,
                                            definition: item,
                                            canApprove: canApprove,
                                          );
                                      if (input != null) {
                                        await controller.updateDefinition(
                                          item.copyWith(
                                            title: input.title,
                                            displayText: input.displayText,
                                            description: input.description,
                                            defaultTarget: input.defaultTarget,
                                            sourceReference:
                                                input.sourceReference,
                                            status: input.status,
                                          ),
                                        );
                                      }
                                    },
                              icon: const Icon(Icons.edit_outlined),
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class DhikrDefinitionInput {
  const DhikrDefinitionInput({
    required this.title,
    required this.displayText,
    required this.defaultTarget,
    required this.status,
    this.description,
    this.sourceReference,
  });

  final String title;
  final String displayText;
  final String? description;
  final int defaultTarget;
  final String? sourceReference;
  final DhikrDefinitionStatus status;
}

Future<DhikrDefinitionInput?> showDhikrDefinitionDialog(
  BuildContext context, {
  DhikrDefinition? definition,
  bool canApprove = false,
}) async {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController(text: definition?.title);
  final displayText = TextEditingController(text: definition?.displayText);
  final description = TextEditingController(text: definition?.description);
  final target = TextEditingController(
    text: definition?.defaultTarget.toString() ?? '100',
  );
  final source = TextEditingController(text: definition?.sourceReference);
  var status = definition?.status ?? DhikrDefinitionStatus.draft;
  final result = await showDialog<DhikrDefinitionInput>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(definition == null ? 'إضافة تعريف ذكر' : 'تعديل الذكر'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'العنوان'),
                  validator: _requiredText,
                ),
                TextFormField(
                  controller: displayText,
                  decoration: const InputDecoration(labelText: 'نص العرض'),
                  validator: _requiredText,
                ),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(labelText: 'الوصف'),
                ),
                TextFormField(
                  controller: target,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الهدف الافتراضي',
                  ),
                  validator: _targetValidator,
                ),
                TextFormField(
                  controller: source,
                  decoration: const InputDecoration(labelText: 'مرجع المصدر'),
                  validator: (value) {
                    if (status == DhikrDefinitionStatus.approved &&
                        (value == null || value.trim().isEmpty)) {
                      return 'مرجع المصدر مطلوب للاعتماد';
                    }
                    return null;
                  },
                ),
                if (definition != null)
                  DropdownButtonFormField<DhikrDefinitionStatus>(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: 'الحالة'),
                    items: [
                      for (final item in _allowedStatuses(
                        definition.status,
                        canApprove,
                      ))
                        DropdownMenuItem(
                          value: item,
                          child: Text(item.arabicLabel),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => status = value);
                      }
                    },
                  ),
              ],
            ),
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
                DhikrDefinitionInput(
                  title: title.text.trim(),
                  displayText: displayText.text.trim(),
                  description: _optional(description.text),
                  defaultTarget: int.parse(target.text),
                  sourceReference: _optional(source.text),
                  status: status,
                ),
              );
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    ),
  );
  title.dispose();
  displayText.dispose();
  description.dispose();
  target.dispose();
  source.dispose();
  return result;
}

String? _requiredText(String? value) =>
    value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;

String? _targetValidator(String? value) {
  final parsed = int.tryParse(value ?? '');
  return parsed == null || parsed < 1 || parsed > 100000
      ? 'أدخل هدفًا بين 1 و100000'
      : null;
}

String? _optional(String value) {
  final normalized = value.trim();
  return normalized.isEmpty ? null : normalized;
}

List<DhikrDefinitionStatus> _allowedStatuses(
  DhikrDefinitionStatus current,
  bool canApprove,
) {
  if (!canApprove) {
    return current == DhikrDefinitionStatus.inReview
        ? const [DhikrDefinitionStatus.inReview, DhikrDefinitionStatus.draft]
        : const [DhikrDefinitionStatus.draft, DhikrDefinitionStatus.inReview];
  }
  return switch (current) {
    DhikrDefinitionStatus.draft => const [
      DhikrDefinitionStatus.draft,
      DhikrDefinitionStatus.inReview,
      DhikrDefinitionStatus.archived,
    ],
    DhikrDefinitionStatus.inReview => const [
      DhikrDefinitionStatus.inReview,
      DhikrDefinitionStatus.draft,
      DhikrDefinitionStatus.approved,
      DhikrDefinitionStatus.archived,
    ],
    DhikrDefinitionStatus.approved => const [
      DhikrDefinitionStatus.approved,
      DhikrDefinitionStatus.archived,
    ],
    DhikrDefinitionStatus.archived => const [
      DhikrDefinitionStatus.archived,
      DhikrDefinitionStatus.draft,
    ],
  };
}
