import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/wird_programs/application/wird_programs_controller.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_program_models.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_programs_repository.dart';

class WirdProgramsSection extends ConsumerWidget {
  const WirdProgramsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programs = ref.watch(wirdProgramsProvider);
    final controller = ref.read(wirdProgramsProvider.notifier);
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
                    'إنشاء الورد الجماعي',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'إنشاء ورد جماعي',
                  onPressed: programs.value == null
                      ? null
                      : () async {
                          final input = await showWirdProgramDialog(
                            context,
                            state: programs.requireValue,
                          );
                          if (input != null) await controller.create(input);
                        },
                  icon: const Icon(Icons.playlist_add),
                ),
              ],
            ),
            const Text('اختر ذكرًا معتمدًا، ثم حدّد المدة ونوع نطاق التكليف.'),
            const SizedBox(height: 12),
            programs.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Column(
                children: [
                  Text(
                    error is WirdProgramFailure
                        ? error.userMessage
                        : 'تعذر تحميل الأوراد الجماعية.',
                  ),
                  TextButton(
                    onPressed: controller.refresh,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
              data: (value) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (value.lastAssignedCount != null)
                    Text(
                      'تم إنشاء الورد وتكليف ${value.lastAssignedCount} مستخدمًا.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  if (value.dhikrDefinitions.isEmpty)
                    const Text(
                      'اعتمد تعريف ذكر واحدًا على الأقل قبل إنشاء الورد.',
                    )
                  else if (value.branches.isEmpty)
                    const Text('أنشئ فرعًا واحدًا على الأقل قبل إنشاء الورد.')
                  else if (value.programs.isEmpty)
                    const Text('لا توجد أوراد جماعية بعد.')
                  else
                    for (final program in value.programs)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          child: Icon(Icons.menu_book_outlined),
                        ),
                        title: Text(program.name),
                        subtitle: Text(
                          '${program.dhikrTitleSnapshot} — '
                          'الهدف: ${program.targetCount} — '
                          '${_formatDate(program.startsOn)} إلى '
                          '${_formatDate(program.endsOn)} — '
                          '${program.scopeType.arabicLabel}: '
                          '${program.audienceName}',
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

Future<WirdProgramRequest?> showWirdProgramDialog(
  BuildContext context, {
  required WirdProgramCreationState state,
}) async {
  if (state.dhikrDefinitions.isEmpty || state.branches.isEmpty) return null;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final audienceController = TextEditingController();
  var dhikrId = state.dhikrDefinitions.first.id;
  final targetController = TextEditingController(
    text: state.dhikrDefinitions.first.defaultTarget.toString(),
  );
  var startsOn = DateTime.now();
  startsOn = DateTime(startsOn.year, startsOn.month, startsOn.day);
  var endsOn = startsOn;
  var scope = WirdAssignmentScope.organization;
  final branchIds = <String>{};
  final classIds = <String>{};
  final roles = <ManagedUserType>{};
  final userIds = <String>{};
  audienceController.text = 'جميع المؤسسة';
  String? selectionError;

  final result = await showDialog<WirdProgramRequest>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: const Text('إنشاء ورد'),
        content: SizedBox(
          width: 560,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'اسم الورد'),
                    validator: _requiredText,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: dhikrId,
                    decoration: const InputDecoration(labelText: 'الذكر'),
                    items: [
                      for (final dhikr in state.dhikrDefinitions)
                        DropdownMenuItem(
                          value: dhikr.id,
                          child: Text(dhikr.title),
                        ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      final dhikr = _dhikrById(state.dhikrDefinitions, value);
                      setDialogState(() {
                        dhikrId = value;
                        targetController.text = dhikr.defaultTarget.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: targetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'الهدف'),
                    validator: _targetValidator,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<WirdAssignmentScope>(
                    initialValue: scope,
                    decoration: const InputDecoration(
                      labelText: 'نطاق التكليف',
                    ),
                    items: [
                      for (final item in WirdAssignmentScope.values)
                        DropdownMenuItem(
                          value: item,
                          child: Text(item.arabicLabel),
                        ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setDialogState(() {
                        scope = value;
                        _initializeScope(
                          scope: scope,
                          state: state,
                          branchIds: branchIds,
                          classIds: classIds,
                          roles: roles,
                          userIds: userIds,
                        );
                        audienceController.text = _audienceLabel(
                          scope: scope,
                          state: state,
                          branchIds: branchIds,
                          classIds: classIds,
                          roles: roles,
                          userIds: userIds,
                        );
                        selectionError = null;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: audienceController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'الجمهور'),
                  ),
                  const SizedBox(height: 10),
                  if (scope == WirdAssignmentScope.branch ||
                      scope == WirdAssignmentScope.multipleBranches) ...[
                    Text(
                      scope == WirdAssignmentScope.branch ? 'الفرع' : 'الفروع',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final branch in state.branches)
                          FilterChip(
                            label: Text(branch.name),
                            selected: branchIds.contains(branch.id),
                            onSelected: (selected) => setDialogState(() {
                              if (scope == WirdAssignmentScope.branch) {
                                branchIds
                                  ..clear()
                                  ..add(branch.id);
                              } else if (selected) {
                                branchIds.add(branch.id);
                              } else {
                                branchIds.remove(branch.id);
                              }
                              audienceController.text = _audienceLabel(
                                scope: scope,
                                state: state,
                                branchIds: branchIds,
                                classIds: classIds,
                                roles: roles,
                                userIds: userIds,
                              );
                              selectionError = null;
                            }),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (scope == WirdAssignmentScope.schoolClass) ...[
                    Text('الصف', style: Theme.of(context).textTheme.titleSmall),
                    if (state.classes.isEmpty)
                      const Text('لا توجد صفوف متاحة.')
                    else
                      Wrap(
                        spacing: 8,
                        children: [
                          for (final schoolClass in state.classes)
                            ChoiceChip(
                              label: Text(
                                '${schoolClass.name} — '
                                '${_branchName(state, schoolClass.branchId)}',
                              ),
                              selected: classIds.contains(schoolClass.id),
                              onSelected: (_) => setDialogState(() {
                                classIds
                                  ..clear()
                                  ..add(schoolClass.id);
                                audienceController.text = _audienceLabel(
                                  scope: scope,
                                  state: state,
                                  branchIds: branchIds,
                                  classIds: classIds,
                                  roles: roles,
                                  userIds: userIds,
                                );
                                selectionError = null;
                              }),
                            ),
                        ],
                      ),
                    const SizedBox(height: 10),
                  ],
                  if (scope == WirdAssignmentScope.role) ...[
                    Text(
                      'الأدوار',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final role in ManagedUserType.values)
                          FilterChip(
                            label: Text(role.arabicLabel),
                            selected: roles.contains(role),
                            onSelected: (selected) => setDialogState(() {
                              selected ? roles.add(role) : roles.remove(role);
                              audienceController.text = _audienceLabel(
                                scope: scope,
                                state: state,
                                branchIds: branchIds,
                                classIds: classIds,
                                roles: roles,
                                userIds: userIds,
                              );
                              selectionError = null;
                            }),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (scope == WirdAssignmentScope.user) ...[
                    if (state.users.isEmpty)
                      const Text('لا يوجد مستخدمون متاحون.')
                    else
                      DropdownButtonFormField<String>(
                        initialValue: userIds.isEmpty ? null : userIds.first,
                        decoration: const InputDecoration(
                          labelText: 'المستخدم',
                        ),
                        items: [
                          for (final user in state.users)
                            DropdownMenuItem(
                              value: user.id,
                              child: Text(
                                '${user.fullName} — '
                                '${user.userType.arabicLabel}',
                              ),
                            ),
                        ],
                        onChanged: (value) => setDialogState(() {
                          userIds.clear();
                          if (value != null) userIds.add(value);
                          audienceController.text = _audienceLabel(
                            scope: scope,
                            state: state,
                            branchIds: branchIds,
                            classIds: classIds,
                            roles: roles,
                            userIds: userIds,
                          );
                          selectionError = null;
                        }),
                      ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final selected = await _pickDate(context, startsOn);
                            if (selected != null) {
                              setDialogState(() {
                                startsOn = selected;
                                if (endsOn.isBefore(startsOn)) {
                                  endsOn = startsOn;
                                }
                              });
                            }
                          },
                          child: Text('البداية: ${_formatDate(startsOn)}'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final selected = await _pickDate(context, endsOn);
                            if (selected != null) {
                              setDialogState(() => endsOn = selected);
                            }
                          },
                          child: Text('النهاية: ${_formatDate(endsOn)}'),
                        ),
                      ),
                    ],
                  ),
                  if (selectionError != null)
                    Text(
                      selectionError!,
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
              if (!formKey.currentState!.validate()) return;
              final scopeError = _scopeError(
                scope: scope,
                branchIds: branchIds,
                classIds: classIds,
                roles: roles,
                userIds: userIds,
              );
              if (scopeError != null) {
                setDialogState(() => selectionError = scopeError);
                return;
              }
              if (endsOn.isBefore(startsOn)) {
                setDialogState(
                  () => selectionError = 'تاريخ النهاية يسبق البداية.',
                );
                return;
              }
              Navigator.pop(
                context,
                WirdProgramRequest(
                  name: nameController.text.trim(),
                  dhikrDefinitionId: dhikrId,
                  targetCount: int.parse(targetController.text),
                  startsOn: startsOn,
                  endsOn: endsOn,
                  audienceName: audienceController.text.trim(),
                  scope: scope,
                  branchIds: Set.of(branchIds),
                  classIds: Set.of(classIds),
                  roles: Set.of(roles),
                  userIds: Set.of(userIds),
                ),
              );
            },
            child: const Text('إنشاء وتكليف'),
          ),
        ],
      ),
    ),
  );
  nameController.dispose();
  targetController.dispose();
  audienceController.dispose();
  return result;
}

void _initializeScope({
  required WirdAssignmentScope scope,
  required WirdProgramCreationState state,
  required Set<String> branchIds,
  required Set<String> classIds,
  required Set<ManagedUserType> roles,
  required Set<String> userIds,
}) {
  branchIds.clear();
  classIds.clear();
  roles.clear();
  userIds.clear();
  switch (scope) {
    case WirdAssignmentScope.organization:
      break;
    case WirdAssignmentScope.branch:
      branchIds.add(state.branches.first.id);
    case WirdAssignmentScope.multipleBranches:
      branchIds.addAll(state.branches.take(2).map((item) => item.id));
    case WirdAssignmentScope.schoolClass:
      if (state.classes.isNotEmpty) classIds.add(state.classes.first.id);
    case WirdAssignmentScope.role:
      roles.add(ManagedUserType.teacher);
    case WirdAssignmentScope.user:
      if (state.users.isNotEmpty) userIds.add(state.users.first.id);
  }
}

String _audienceLabel({
  required WirdAssignmentScope scope,
  required WirdProgramCreationState state,
  required Set<String> branchIds,
  required Set<String> classIds,
  required Set<ManagedUserType> roles,
  required Set<String> userIds,
}) => switch (scope) {
  WirdAssignmentScope.organization => 'جميع المؤسسة',
  WirdAssignmentScope.branch =>
    branchIds.isEmpty ? 'اختر فرعًا' : _branchName(state, branchIds.first),
  WirdAssignmentScope.multipleBranches =>
    branchIds.isEmpty
        ? 'اختر الفروع'
        : branchIds.map((id) => _branchName(state, id)).join(' + '),
  WirdAssignmentScope.schoolClass =>
    classIds.isEmpty ? 'اختر صفًا' : _className(state, classIds.first),
  WirdAssignmentScope.role =>
    roles.isEmpty
        ? 'اختر دورًا'
        : roles.map((role) => role.arabicLabel).join(' + '),
  WirdAssignmentScope.user =>
    userIds.isEmpty ? 'اختر مستخدمًا' : _userName(state, userIds.first),
};

String? _scopeError({
  required WirdAssignmentScope scope,
  required Set<String> branchIds,
  required Set<String> classIds,
  required Set<ManagedUserType> roles,
  required Set<String> userIds,
}) => switch (scope) {
  WirdAssignmentScope.organization => null,
  WirdAssignmentScope.branch when branchIds.length != 1 => 'اختر فرعًا واحدًا.',
  WirdAssignmentScope.multipleBranches when branchIds.length < 2 =>
    'اختر فرعين على الأقل.',
  WirdAssignmentScope.schoolClass when classIds.length != 1 =>
    'اختر صفًا واحدًا.',
  WirdAssignmentScope.role when roles.isEmpty => 'اختر دورًا واحدًا على الأقل.',
  WirdAssignmentScope.user when userIds.length != 1 => 'اختر مستخدمًا واحدًا.',
  _ => null,
};

String _branchName(WirdProgramCreationState state, String id) =>
    state.branches.firstWhere((item) => item.id == id).name;

String _className(WirdProgramCreationState state, String id) =>
    state.classes.firstWhere((item) => item.id == id).name;

String _userName(WirdProgramCreationState state, String id) =>
    state.users.firstWhere((item) => item.id == id).fullName;

DhikrDefinition _dhikrById(List<DhikrDefinition> items, String id) =>
    items.firstWhere((item) => item.id == id);

Future<DateTime?> _pickDate(BuildContext context, DateTime initial) {
  return showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );
}

String? _requiredText(String? value) =>
    value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;

String? _targetValidator(String? value) {
  final parsed = int.tryParse(value ?? '');
  return parsed == null || parsed < 1 || parsed > 100000
      ? 'أدخل هدفًا بين 1 و100000'
      : null;
}

String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}
