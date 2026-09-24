import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';
import 'package:ward_al_rawdah/features/wird_assignments/application/wird_assignment_controllers.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_models.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_repository.dart';

class WirdManagementSection extends ConsumerWidget {
  const WirdManagementSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wirdManagementProvider);
    final current = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    final role = switch (ref.watch(authControllerProvider)) {
      AuthAuthenticated(:final user) => user.role,
      _ => AppRole.staff,
    };
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
                    'الأوراد والتكليف',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  key: const Key('create_wird'),
                  tooltip: 'إنشاء ورد',
                  onPressed: current == null
                      ? null
                      : () async {
                          final draft = await showWirdDraftDialog(
                            context,
                            current,
                            role,
                          );
                          if (draft != null) {
                            await ref
                                .read(wirdManagementProvider.notifier)
                                .create(draft);
                          }
                        },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            if (current?.lastMaterializedCount case final count?)
              Text('تم إنشاء $count تكليفًا فرديًا دون تكرار.'),
            const SizedBox(height: 8),
            state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Column(
                children: [
                  Text(
                    error is WirdAssignmentFailure
                        ? error.userMessage
                        : 'تعذر تحميل الأوراد.',
                  ),
                  TextButton(
                    onPressed: ref
                        .read(wirdManagementProvider.notifier)
                        .refresh,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
              data: (data) => data.wirds.isEmpty
                  ? const Text('لا توجد أوراد بعد.')
                  : Column(
                      children: data.wirds
                          .map(
                            (wird) => ListTile(
                              key: Key('managed_wird_${wird.id}'),
                              contentPadding: EdgeInsets.zero,
                              leading: const CircleAvatar(
                                child: Icon(Icons.menu_book_outlined),
                              ),
                              title: Text(wird.title),
                              subtitle: Text(
                                'الهدف: ${wird.targetCount} — ${wird.status.arabicLabel}\n${_date(wird.startAt)} ← ${_date(wird.endAt)}',
                              ),
                              isThreeLine: true,
                              trailing: IconButton(
                                tooltip: 'تعديل الورد',
                                onPressed: () async {
                                  final updated = await showWirdEditDialog(
                                    context,
                                    wird,
                                  );
                                  if (updated != null) {
                                    await ref
                                        .read(wirdManagementProvider.notifier)
                                        .saveChanges(updated);
                                  }
                                },
                                icon: const Icon(Icons.edit_outlined),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<WirdDraft?> showWirdDraftDialog(
  BuildContext context,
  WirdManagementData data,
  AppRole role,
) async {
  if (data.dhikr.isEmpty) {
    return null;
  }
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  final target = TextEditingController(
    text: data.dhikr.first.defaultTarget.toString(),
  );
  var dhikrId = data.dhikr.first.id;
  var start = DateTime.now();
  var end = start;
  var scope = role == AppRole.organizationAdmin
      ? AssignmentScope.organization
      : AssignmentScope.branch;
  final branchIds = <String>{
    if (role != AppRole.organizationAdmin && data.branches.isNotEmpty)
      data.branches.first.id,
  };
  String? classId;
  String? roleValue;
  String? userId;
  String? scopeError;
  final result = await showDialog<WirdDraft>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('إنشاء ورد وتكليفه'),
        content: SizedBox(
          width: 560,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(labelText: 'اسم الورد'),
                    validator: _required,
                  ),
                  TextFormField(
                    controller: description,
                    decoration: const InputDecoration(labelText: 'الوصف'),
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: dhikrId,
                    decoration: const InputDecoration(labelText: 'الذكر'),
                    items: data.dhikr
                        .map(
                          (item) => DropdownMenuItem(
                            value: item.id,
                            child: Text(item.title),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          dhikrId = value;
                          target.text = data.dhikr
                              .firstWhere((item) => item.id == value)
                              .defaultTarget
                              .toString();
                        });
                      }
                    },
                  ),
                  TextFormField(
                    controller: target,
                    decoration: const InputDecoration(labelText: 'الهدف'),
                    keyboardType: TextInputType.number,
                    validator: _target,
                  ),
                  DropdownButtonFormField<AssignmentScope>(
                    key: const Key('assignment_scope'),
                    initialValue: scope,
                    decoration: const InputDecoration(
                      labelText: 'نطاق التكليف',
                    ),
                    items: AssignmentScope.values
                        .where(
                          (item) =>
                              role == AppRole.organizationAdmin ||
                              item != AssignmentScope.organization,
                        )
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.arabicLabel),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          scope = value;
                          branchIds.clear();
                          classId = null;
                          roleValue = null;
                          userId = null;
                          scopeError = null;
                          if (scope == AssignmentScope.branch &&
                              role != AppRole.organizationAdmin &&
                              data.branches.isNotEmpty) {
                            branchIds.add(data.branches.first.id);
                          }
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  if (scope == AssignmentScope.branch)
                    Wrap(
                      spacing: 8,
                      children: data.branches
                          .map(
                            (branch) => FilterChip(
                              label: Text(branch.name),
                              selected: branchIds.contains(branch.id),
                              onSelected: (selected) => setState(() {
                                selected
                                    ? branchIds.add(branch.id)
                                    : branchIds.remove(branch.id);
                                scopeError = null;
                              }),
                            ),
                          )
                          .toList(),
                    ),
                  if (scope == AssignmentScope.schoolClass)
                    DropdownButtonFormField<String>(
                      initialValue: classId,
                      decoration: const InputDecoration(labelText: 'الصف'),
                      items: data.classes
                          .map(
                            (item) => DropdownMenuItem(
                              value: item.id,
                              child: Text(item.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => classId = value),
                    ),
                  if (scope == AssignmentScope.role) ...[
                    DropdownButtonFormField<String>(
                      initialValue: roleValue,
                      decoration: const InputDecoration(labelText: 'الدور'),
                      items:
                          const {
                                'branch_manager': 'مدير فرع',
                                'admin': 'إداري',
                                'teacher': 'معلم',
                                'staff': 'موظف',
                                'student': 'طالب',
                              }.entries
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.key,
                                  child: Text(item.value),
                                ),
                              )
                              .toList(),
                      onChanged: (value) => setState(() => roleValue = value),
                    ),
                    if (role != AppRole.organizationAdmin &&
                        data.branches.isNotEmpty)
                      Text('سيطبق الدور داخل ${data.branches.first.name} فقط.'),
                  ],
                  if (scope == AssignmentScope.user)
                    DropdownButtonFormField<String>(
                      initialValue: userId,
                      decoration: const InputDecoration(labelText: 'المستخدم'),
                      items: data.users
                          .map(
                            (item) => DropdownMenuItem(
                              value: item.id,
                              child: Text('${item.name} — ${item.role}'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => userId = value),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final value = await _pickDate(context, start);
                            if (value != null) {
                              setState(() => start = value);
                            }
                          },
                          child: Text('البداية: ${_date(start)}'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final value = await _pickDate(context, end);
                            if (value != null) {
                              setState(() => end = value);
                            }
                          },
                          child: Text('النهاية: ${_date(end)}'),
                        ),
                      ),
                    ],
                  ),
                  if (scopeError != null)
                    Text(
                      scopeError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              ),
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
              if (!formKey.currentState!.validate()) {
                return;
              }
              final assignments = buildAssignmentsForTest(
                scope: scope,
                data: data,
                role: role,
                branchIds: branchIds,
                classId: classId,
                roleValue: roleValue,
                userId: userId,
              );
              if (assignments.isEmpty || end.isBefore(start)) {
                setState(
                  () => scopeError =
                      'اختر نطاقًا صالحًا وتاريخ نهاية لاحقًا للبداية.',
                );
                return;
              }
              Navigator.pop(
                context,
                WirdDraft(
                  dhikrId: dhikrId,
                  title: title.text.trim(),
                  description: description.text.trim(),
                  targetCount: int.parse(target.text),
                  startAt: start,
                  endAt: end,
                  assignments: assignments,
                ),
              );
            },
            child: const Text('إنشاء وتكليف'),
          ),
        ],
      ),
    ),
  );
  title.dispose();
  description.dispose();
  target.dispose();
  return result;
}

@visibleForTesting
List<AssignmentDraft> buildAssignmentsForTest({
  required AssignmentScope scope,
  required WirdManagementData data,
  required AppRole role,
  required Set<String> branchIds,
  String? classId,
  String? roleValue,
  String? userId,
}) {
  switch (scope) {
    case AssignmentScope.organization:
      return const [AssignmentDraft(scope: AssignmentScope.organization)];
    case AssignmentScope.branch:
      return branchIds
          .map((id) => AssignmentDraft(scope: scope, branchId: id))
          .toList();
    case AssignmentScope.schoolClass:
      if (classId == null) {
        return const [];
      }
      final selected = data.classes.firstWhere((item) => item.id == classId);
      return [
        AssignmentDraft(
          scope: scope,
          branchId: selected.branchId,
          classId: selected.id,
        ),
      ];
    case AssignmentScope.role:
      if (roleValue == null) {
        return const [];
      }
      return [
        AssignmentDraft(
          scope: scope,
          branchId: role == AppRole.organizationAdmin
              ? null
              : (data.branches.isEmpty ? null : data.branches.first.id),
          role: roleValue,
        ),
      ];
    case AssignmentScope.user:
      if (userId == null) {
        return const [];
      }
      final selected = data.users.firstWhere((item) => item.id == userId);
      return [
        AssignmentDraft(
          scope: scope,
          branchId: selected.branchId,
          userId: selected.id,
        ),
      ];
  }
}

Future<WirdContent?> showWirdEditDialog(
  BuildContext context,
  WirdContent wird,
) async {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController(text: wird.title);
  final target = TextEditingController(text: wird.targetCount.toString());
  var status = wird.status;
  final result = await showDialog<WirdContent>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('تعديل الورد'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(labelText: 'اسم الورد'),
                validator: _required,
              ),
              TextFormField(
                controller: target,
                decoration: const InputDecoration(labelText: 'الهدف'),
                keyboardType: TextInputType.number,
                validator: _target,
              ),
              DropdownButtonFormField<WirdLifecycleStatus>(
                initialValue: status,
                decoration: const InputDecoration(labelText: 'الحالة'),
                items: _allowedWirdStatuses(wird.status)
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.arabicLabel),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => status = value);
                  }
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
              if (!formKey.currentState!.validate()) {
                return;
              }
              Navigator.pop(
                context,
                WirdContent(
                  id: wird.id,
                  dhikrId: wird.dhikrId,
                  title: title.text.trim(),
                  description: wird.description,
                  targetCount: int.parse(target.text),
                  startAt: wird.startAt,
                  endAt: wird.endAt,
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
  target.dispose();
  return result;
}

String? _required(String? value) =>
    value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;
String? _target(String? value) {
  final parsed = int.tryParse(value ?? '');
  return parsed == null || parsed < 1 || parsed > 100000
      ? 'أدخل هدفًا بين 1 و100000'
      : null;
}

Future<DateTime?> _pickDate(BuildContext context, DateTime initial) =>
    showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
String _date(DateTime value) =>
    '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

List<WirdLifecycleStatus> _allowedWirdStatuses(WirdLifecycleStatus current) =>
    switch (current) {
      WirdLifecycleStatus.draft => const [
        WirdLifecycleStatus.draft,
        WirdLifecycleStatus.scheduled,
        WirdLifecycleStatus.cancelled,
      ],
      WirdLifecycleStatus.scheduled => const [
        WirdLifecycleStatus.scheduled,
        WirdLifecycleStatus.active,
        WirdLifecycleStatus.cancelled,
      ],
      WirdLifecycleStatus.active => const [
        WirdLifecycleStatus.active,
        WirdLifecycleStatus.ended,
        WirdLifecycleStatus.cancelled,
      ],
      WirdLifecycleStatus.ended => const [WirdLifecycleStatus.ended],
      WirdLifecycleStatus.cancelled => const [WirdLifecycleStatus.cancelled],
    };
