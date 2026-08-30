import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/users/application/branch_users_controller.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/wirds/application/managed_wirds_controller.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wirds_repository.dart';

class ManagedWirdsSection extends ConsumerWidget {
  const ManagedWirdsSection({required this.branch, super.key});

  final Branch? branch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wirds = ref.watch(managedWirdsProvider);
    final users = ref.watch(branchUsersProvider).value ?? const <ManagedUser>[];
    final controller = ref.read(managedWirdsProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              branch == null ? 'التكليفات الفردية' : 'تكليفات ${branch!.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text(
              'يعرض هذا القسم التكليفات الفردية القائمة؛ إنشاء الأوراد الجديدة يتم من نموذج الورد الجماعي.',
            ),
            if (branch == null)
              const Text('اختر فرعًا أولًا.')
            else
              wirds.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => _WirdError(
                  message: error is WirdManagementFailure
                      ? error.userMessage
                      : 'تعذر تحميل أوراد الفرع.',
                  onRetry: controller.refresh,
                ),
                data: (items) => items.isEmpty
                    ? const Text('لا توجد أوراد في هذا الفرع بعد.')
                    : Column(
                        children: [
                          for (final wird in items)
                            _WirdTile(
                              wird: wird,
                              assignee: _byId(users, wird.assignedUserId),
                              users: users,
                              onEdit: () async {
                                final input = await _askForWird(
                                  context,
                                  wird: wird,
                                );
                                if (input != null) {
                                  await controller.updateWird(
                                    wird.copyWith(
                                      title: input.title,
                                      details: input.details,
                                      targetCount: input.targetCount,
                                    ),
                                  );
                                }
                              },
                              onAssign: () async {
                                final userId = await _askForAssignee(
                                  context,
                                  users: users,
                                  currentUserId: wird.assignedUserId,
                                );
                                if (userId != null) {
                                  await controller.assignWird(wird, userId);
                                }
                              },
                              onComplete: () async {
                                if (await _confirmCompletion(
                                  context,
                                  wird.title,
                                )) {
                                  await controller.completeWird(wird);
                                }
                              },
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

class _WirdTile extends StatelessWidget {
  const _WirdTile({
    required this.wird,
    required this.assignee,
    required this.users,
    required this.onEdit,
    required this.onAssign,
    required this.onComplete,
  });

  final ManagedWird wird;
  final ManagedUser? assignee;
  final List<ManagedUser> users;
  final Future<void> Function() onEdit;
  final Future<void> Function() onAssign;
  final Future<void> Function() onComplete;

  @override
  Widget build(BuildContext context) {
    final completed = wird.status == ManagedWirdStatus.completed;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(completed ? Icons.task_alt : Icons.menu_book_outlined),
      ),
      title: Text(wird.title),
      subtitle: Text(
        [
          wird.status.arabicLabel,
          if (wird.targetCount != null) 'الهدف: ${wird.targetCount}',
          if (assignee != null) 'المكلّف: ${assignee!.fullName}',
          if (wird.details != null) wird.details!,
        ].join(' — '),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Wrap(
        children: [
          IconButton(
            tooltip: 'تعديل الورد',
            onPressed: completed ? null : onEdit,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: wird.assignedUserId == null
                ? 'تكليف الورد'
                : 'تغيير المكلّف',
            onPressed: completed || users.isEmpty ? null : onAssign,
            icon: const Icon(Icons.assignment_ind_outlined),
          ),
          IconButton(
            tooltip: 'إنهاء الورد',
            onPressed: wird.status == ManagedWirdStatus.assigned
                ? onComplete
                : null,
            icon: const Icon(Icons.task_alt),
          ),
        ],
      ),
    );
  }
}

class _WirdError extends StatelessWidget {
  const _WirdError({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(message),
        TextButton(onPressed: onRetry, child: const Text('إعادة المحاولة')),
      ],
    );
  }
}

class _WirdInput {
  const _WirdInput({
    required this.title,
    required this.targetCount,
    this.details,
  });

  final String title;
  final int targetCount;
  final String? details;
}

Future<_WirdInput?> _askForWird(
  BuildContext context, {
  ManagedWird? wird,
}) async {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController(text: wird?.title);
  final targetController = TextEditingController(
    text: wird?.targetCount?.toString(),
  );
  final detailsController = TextEditingController(text: wird?.details);
  final result = await showDialog<_WirdInput>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(wird == null ? 'إنشاء ورد' : 'تعديل الورد'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              autofocus: true,
              maxLength: 160,
              decoration: const InputDecoration(labelText: 'عنوان الورد'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'العنوان مطلوب'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'الهدف العددي'),
              validator: (value) {
                final target = int.tryParse(value ?? '');
                return target == null || target < 1 || target > 100000
                    ? 'أدخل رقمًا بين 1 و100000'
                    : null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: detailsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'التفاصيل (اختياري)',
              ),
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
            final details = detailsController.text.trim();
            Navigator.pop(
              context,
              _WirdInput(
                title: titleController.text.trim(),
                targetCount: int.parse(targetController.text),
                details: details.isEmpty ? null : details,
              ),
            );
          },
          child: const Text('حفظ'),
        ),
      ],
    ),
  );
  titleController.dispose();
  targetController.dispose();
  detailsController.dispose();
  return result;
}

Future<String?> _askForAssignee(
  BuildContext context, {
  required List<ManagedUser> users,
  String? currentUserId,
}) async {
  var userId = users.any((user) => user.id == currentUserId)
      ? currentUserId
      : users.first.id;
  return showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('تكليف الورد'),
        content: DropdownButtonFormField<String>(
          initialValue: userId,
          decoration: const InputDecoration(labelText: 'المستخدم المكلّف'),
          items: [
            for (final user in users)
              DropdownMenuItem(
                value: user.id,
                child: Text('${user.fullName} — ${user.userType.arabicLabel}'),
              ),
          ],
          onChanged: (value) => setState(() => userId = value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: userId == null
                ? null
                : () => Navigator.pop(context, userId),
            child: const Text('تكليف'),
          ),
        ],
      ),
    ),
  );
}

Future<bool> _confirmCompletion(BuildContext context, String title) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('إنهاء الورد'),
          content: Text('هل تريد إنهاء «$title»؟ لا يمكن تعديله بعد الإنهاء.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('إنهاء'),
            ),
          ],
        ),
      ) ??
      false;
}

ManagedUser? _byId(List<ManagedUser> users, String? id) {
  if (id == null) return null;
  for (final user in users) {
    if (user.id == id) return user;
  }
  return null;
}
