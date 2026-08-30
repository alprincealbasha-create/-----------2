import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_controller.dart';
import 'package:ward_al_rawdah/features/organizations/application/organization_management_state.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organizations_repository.dart';
import 'package:ward_al_rawdah/features/users/application/branch_users_controller.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_users_repository.dart';
import 'package:ward_al_rawdah/features/wirds/presentation/managed_wirds_section.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/presentation/branch_dashboard_overview.dart';
import 'package:ward_al_rawdah/features/central_dashboard/presentation/central_dashboard_overview.dart';
import 'package:ward_al_rawdah/features/campaigns/presentation/campaigns_section.dart';
import 'package:ward_al_rawdah/features/dhikr_library/presentation/dhikr_library_section.dart';
import 'package:ward_al_rawdah/features/wird_programs/presentation/wird_programs_section.dart';
import 'package:ward_al_rawdah/features/badges/presentation/badges_section.dart';
import 'package:ward_al_rawdah/features/integrity/presentation/integrity_section.dart';
import 'package:ward_al_rawdah/features/reports/presentation/administrative_reports_section.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final management = ref.watch(organizationManagementProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الإدارة'),
        actions: [
          IconButton(
            tooltip: 'تسجيل الخروج',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: management.when(
        data: (value) => _ManagementContent(value: value),
        error: (error, _) => _ErrorView(
          message: error is OrganizationFailure
              ? error.userMessage
              : 'تعذر تحميل بيانات الإدارة.',
          onRetry: () =>
              ref.read(organizationManagementProvider.notifier).refresh(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ManagementContent extends ConsumerStatefulWidget {
  const _ManagementContent({required this.value});

  final OrganizationManagementState value;

  @override
  ConsumerState<_ManagementContent> createState() => _ManagementContentState();
}

class _ManagementContentState extends ConsumerState<_ManagementContent> {
  final _classesKey = GlobalKey();
  final _usersKey = GlobalKey();
  final _wirdsKey = GlobalKey();
  final _campaignsKey = GlobalKey();
  final _rewardsKey = GlobalKey();
  final _reportsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    final controller = ref.read(organizationManagementProvider.notifier);
    final organization = _byId(
      value.organizations,
      value.selectedOrganizationId,
      (item) => item.id,
    );
    final branch = _byId(
      value.branches,
      value.selectedBranchId,
      (item) => item.id,
    );
    final schoolClass = _byId(
      value.classes,
      value.selectedClassId,
      (item) => item.id,
    );

    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CentralDashboardOverview(organization: organization),
          const SizedBox(height: 20),
          const DhikrLibrarySection(),
          const SizedBox(height: 20),
          KeyedSubtree(key: _wirdsKey, child: const WirdProgramsSection()),
          const SizedBox(height: 20),
          KeyedSubtree(key: _campaignsKey, child: const CampaignsSection()),
          const SizedBox(height: 20),
          BranchDashboardOverview(
            branch: branch,
            onModuleSelected: _openModule,
          ),
          const SizedBox(height: 20),
          _EntitySection(
            title: 'المؤسسات',
            emptyMessage: 'أنشئ مؤسسة للبدء.',
            items: value.organizations
                .map((item) => _EntityOption(id: item.id, label: item.name))
                .toList(growable: false),
            selectedId: value.selectedOrganizationId,
            onSelect: controller.selectOrganization,
            onAdd: () async {
              final name = await _askForName(
                context,
                title: 'إنشاء مؤسسة',
                label: 'اسم المؤسسة',
              );
              if (name != null) {
                await controller.createOrganization(name);
              }
            },
            onEdit: organization == null
                ? null
                : () async {
                    final name = await _askForName(
                      context,
                      title: 'تعديل المؤسسة',
                      label: 'اسم المؤسسة',
                      initialValue: organization.name,
                    );
                    if (name != null) {
                      await controller.updateOrganization(
                        organization.copyWith(name: name),
                      );
                    }
                  },
            onDelete: organization == null
                ? null
                : () async {
                    if (await _confirmDelete(context, organization.name)) {
                      await controller.deleteOrganization(organization.id);
                    }
                  },
          ),
          const SizedBox(height: 12),
          _EntitySection(
            title: 'الفروع',
            emptyMessage: organization == null
                ? 'اختر مؤسسة أولًا.'
                : 'لا توجد فروع بعد.',
            items: value.branches
                .map(
                  (item) => _EntityOption(
                    id: item.id,
                    label: item.name,
                    detail: item.city,
                  ),
                )
                .toList(growable: false),
            selectedId: value.selectedBranchId,
            onSelect: controller.selectBranch,
            onAdd: organization == null
                ? null
                : () async {
                    final input = await _askForBranch(context);
                    if (input != null) {
                      await controller.createBranch(
                        name: input.name,
                        city: input.city,
                      );
                    }
                  },
            onEdit: branch == null
                ? null
                : () async {
                    final input = await _askForBranch(context, branch: branch);
                    if (input != null) {
                      await controller.updateBranch(
                        branch.copyWith(name: input.name, city: input.city),
                      );
                    }
                  },
            onDelete: branch == null
                ? null
                : () async {
                    if (await _confirmDelete(context, branch.name)) {
                      await controller.deleteBranch(branch.id);
                    }
                  },
          ),
          const SizedBox(height: 12),
          KeyedSubtree(
            key: _classesKey,
            child: _EntitySection(
              title: 'الصفوف',
              emptyMessage: branch == null
                  ? 'اختر فرعًا أولًا.'
                  : 'لا توجد صفوف بعد.',
              items: value.classes
                  .map((item) => _EntityOption(id: item.id, label: item.name))
                  .toList(growable: false),
              selectedId: value.selectedClassId,
              onSelect: controller.selectClass,
              onAdd: branch == null
                  ? null
                  : () async {
                      final name = await _askForName(
                        context,
                        title: 'إنشاء صف',
                        label: 'اسم الصف',
                      );
                      if (name != null) {
                        await controller.createClass(name);
                      }
                    },
              onEdit: schoolClass == null
                  ? null
                  : () async {
                      final name = await _askForName(
                        context,
                        title: 'تعديل الصف',
                        label: 'اسم الصف',
                        initialValue: schoolClass.name,
                      );
                      if (name != null) {
                        await controller.updateClass(
                          schoolClass.copyWith(name: name),
                        );
                      }
                    },
              onDelete: schoolClass == null
                  ? null
                  : () async {
                      if (await _confirmDelete(context, schoolClass.name)) {
                        await controller.deleteClass(schoolClass.id);
                      }
                    },
            ),
          ),
          const SizedBox(height: 12),
          KeyedSubtree(
            key: _usersKey,
            child: _BranchUsersSection(branch: branch, classes: value.classes),
          ),
          const SizedBox(height: 12),
          ManagedWirdsSection(branch: branch),
          const SizedBox(height: 12),
          KeyedSubtree(
            key: _rewardsKey,
            child: BadgesSection(branch: branch),
          ),
          const SizedBox(height: 12),
          KeyedSubtree(
            key: _reportsKey,
            child: Column(
              children: [
                AdministrativeReportsSection(key: ValueKey(organization?.id)),
                const SizedBox(height: 12),
                IntegritySection(branch: branch),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openModule(BranchDashboardModule module) {
    final target = switch (module) {
      BranchDashboardModule.users => _usersKey,
      BranchDashboardModule.classes => _classesKey,
      BranchDashboardModule.wirds => _wirdsKey,
      BranchDashboardModule.campaigns => _campaignsKey,
      BranchDashboardModule.rewards => _rewardsKey,
      BranchDashboardModule.reports => _reportsKey,
    };
    final targetContext = target.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
      return;
    }
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(module.arabicLabel),
        content: Text(
          'وحدة ${module.englishLabel} جاهزة كمدخل في اللوحة، وستُبنى وظائفها في مرحلتها المخصصة.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسنًا'),
          ),
        ],
      ),
    );
  }
}

class _EntitySection extends StatelessWidget {
  const _EntitySection({
    required this.title,
    required this.emptyMessage,
    required this.items,
    required this.selectedId,
    required this.onSelect,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final String emptyMessage;
  final List<_EntityOption> items;
  final String? selectedId;
  final ValueChanged<String> onSelect;
  final Future<void> Function()? onAdd;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;

  @override
  Widget build(BuildContext context) {
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
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'إضافة',
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                IconButton(
                  tooltip: 'تعديل المحدد',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: 'حذف المحدد',
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (items.isEmpty)
              Text(emptyMessage)
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final item in items)
                    ChoiceChip(
                      selected: item.id == selectedId,
                      label: Text(
                        item.detail == null
                            ? item.label
                            : '${item.label} — ${item.detail}',
                      ),
                      onSelected: (_) => onSelect(item.id),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _BranchUsersSection extends ConsumerWidget {
  const _BranchUsersSection({required this.branch, required this.classes});

  final Branch? branch;
  final List<SchoolClass> classes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(branchUsersProvider);
    final controller = ref.read(branchUsersProvider.notifier);
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
                    branch == null
                        ? 'مستخدمو الفرع'
                        : 'مستخدمو ${branch!.name}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'إضافة مستخدم',
                  onPressed: branch == null
                      ? null
                      : () async {
                          final input = await _askForManagedUser(
                            context,
                            classes: classes,
                          );
                          if (input != null) {
                            await controller.createUser(
                              classId: input.classId,
                              userType: input.userType,
                              fullName: input.fullName,
                              birthDate: input.birthDate,
                            );
                          }
                        },
                  icon: const Icon(Icons.person_add_alt_1_outlined),
                ),
              ],
            ),
            if (branch == null)
              const Text('اختر فرعًا أولًا.')
            else
              users.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Column(
                  children: [
                    Text(
                      error is UserManagementFailure
                          ? error.userMessage
                          : 'تعذر تحميل مستخدمي الفرع.',
                    ),
                    TextButton(
                      onPressed: controller.refresh,
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
                data: (items) => items.isEmpty
                    ? const Text('لا يوجد مستخدمون في هذا الفرع بعد.')
                    : Column(
                        children: [
                          for (final user in items)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                child: Icon(_iconFor(user.userType)),
                              ),
                              title: Text(user.fullName),
                              subtitle: Text(_userSubtitle(user, classes)),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    tooltip: 'تعديل المستخدم',
                                    onPressed: () async {
                                      final input = await _askForManagedUser(
                                        context,
                                        classes: classes,
                                        user: user,
                                      );
                                      if (input != null) {
                                        await controller.updateUser(
                                          user.copyWith(
                                            classId: input.classId,
                                            userType: input.userType,
                                            fullName: input.fullName,
                                            birthDate: input.birthDate,
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.edit_outlined),
                                  ),
                                  IconButton(
                                    tooltip: 'حذف المستخدم',
                                    onPressed: () async {
                                      if (await _confirmDelete(
                                        context,
                                        user.fullName,
                                      )) {
                                        await controller.deleteUser(user);
                                      }
                                    },
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ],
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EntityOption {
  const _EntityOption({required this.id, required this.label, this.detail});

  final String id;
  final String label;
  final String? detail;
}

class _BranchInput {
  const _BranchInput({required this.name, this.city});

  final String name;
  final String? city;
}

class _ManagedUserInput {
  const _ManagedUserInput({
    required this.fullName,
    required this.userType,
    required this.classId,
    this.birthDate,
  });

  final String fullName;
  final ManagedUserType userType;
  final String? classId;
  final DateTime? birthDate;
}

T? _byId<T>(List<T> items, String? id, String Function(T) idOf) {
  if (id == null) {
    return null;
  }
  for (final item in items) {
    if (idOf(item) == id) {
      return item;
    }
  }
  return null;
}

Future<String?> _askForName(
  BuildContext context, {
  required String title,
  required String label,
  String? initialValue,
}) async {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController(text: initialValue);
  final result = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: label),
          validator: _requiredText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context, controller.text.trim());
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    ),
  );
  controller.dispose();
  return result;
}

Future<_BranchInput?> _askForBranch(
  BuildContext context, {
  Branch? branch,
}) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: branch?.name);
  final cityController = TextEditingController(text: branch?.city);
  final result = await showDialog<_BranchInput>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(branch == null ? 'إنشاء فرع' : 'تعديل الفرع'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'اسم الفرع'),
              validator: _requiredText,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'المدينة (اختياري)'),
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
            if (formKey.currentState!.validate()) {
              final city = cityController.text.trim();
              Navigator.pop(
                context,
                _BranchInput(
                  name: nameController.text.trim(),
                  city: city.isEmpty ? null : city,
                ),
              );
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    ),
  );
  nameController.dispose();
  cityController.dispose();
  return result;
}

Future<_ManagedUserInput?> _askForManagedUser(
  BuildContext context, {
  required List<SchoolClass> classes,
  ManagedUser? user,
}) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: user?.fullName);
  var userType = user?.userType ?? ManagedUserType.child;
  var classId = user?.classId ?? (classes.isEmpty ? null : classes.first.id);
  var birthDate = user?.birthDate;
  final result = await showDialog<_ManagedUserInput>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: Text(user == null ? 'إضافة مستخدم' : 'تعديل المستخدم'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'الاسم الكامل'),
                validator: _requiredText,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ManagedUserType>(
                initialValue: userType,
                decoration: const InputDecoration(labelText: 'نوع المستخدم'),
                items: [
                  for (final type in ManagedUserType.values)
                    DropdownMenuItem(
                      value: type,
                      child: Text(type.arabicLabel),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() {
                    userType = value;
                    classId = value.requiresClass
                        ? classId ?? (classes.isEmpty ? null : classes.first.id)
                        : null;
                    if (value != ManagedUserType.child) birthDate = null;
                  });
                },
              ),
              if (userType.requiresClass) ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: classes.any((item) => item.id == classId)
                      ? classId
                      : null,
                  decoration: const InputDecoration(labelText: 'الصف'),
                  items: [
                    for (final schoolClass in classes)
                      DropdownMenuItem(
                        value: schoolClass.id,
                        child: Text(schoolClass.name),
                      ),
                  ],
                  onChanged: (value) => setDialogState(() => classId = value),
                  validator: (value) => value == null ? 'اختر صفًا' : null,
                ),
              ],
              if (userType == ManagedUserType.child) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: birthDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (selected != null) {
                      setDialogState(() => birthDate = selected);
                    }
                  },
                  icon: const Icon(Icons.cake_outlined),
                  label: Text(
                    birthDate == null
                        ? 'تاريخ الميلاد (اختياري)'
                        : _formatDate(birthDate!),
                  ),
                ),
              ],
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
              if (formKey.currentState!.validate()) {
                Navigator.pop(
                  context,
                  _ManagedUserInput(
                    fullName: nameController.text.trim(),
                    userType: userType,
                    classId: userType.requiresClass ? classId : null,
                    birthDate: birthDate,
                  ),
                );
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    ),
  );
  nameController.dispose();
  return result;
}

IconData _iconFor(ManagedUserType type) => switch (type) {
  ManagedUserType.child => Icons.child_care,
  ManagedUserType.teacher => Icons.school_outlined,
  ManagedUserType.administrator => Icons.badge_outlined,
  ManagedUserType.branchManager => Icons.manage_accounts_outlined,
};

String _userSubtitle(ManagedUser user, List<SchoolClass> classes) {
  final schoolClass = _byId(classes, user.classId, (item) => item.id);
  final classLabel = schoolClass == null ? '' : ' — ${schoolClass.name}';
  final birthLabel = user.birthDate == null
      ? ''
      : ' — ${_formatDate(user.birthDate!)}';
  return '${user.userType.arabicLabel}$classLabel$birthLabel';
}

Future<bool> _confirmDelete(BuildContext context, String name) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: Text('هل تريد حذف «$name»؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('حذف'),
            ),
          ],
        ),
      ) ??
      false;
}

String? _requiredText(String? value) {
  return value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;
}

String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}
