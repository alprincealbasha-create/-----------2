import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';
import 'package:ward_al_rawdah/features/dhikr_library/presentation/dhikr_library_section.dart';
import 'package:ward_al_rawdah/features/wird_assignments/presentation/today_wirds_section.dart';
import 'package:ward_al_rawdah/features/wird_assignments/presentation/wird_management_section.dart';

class RoleShellPage extends ConsumerWidget {
  const RoleShellPage({required this.role, super.key});

  final AppRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ورد الروضة'),
        actions: [
          IconButton(
            key: const Key('sign_out'),
            tooltip: 'تسجيل الخروج',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    if (role == AppRole.organizationAdmin ||
        role == AppRole.branchManager ||
        role == AppRole.admin) {
      return ListView(
        key: const Key('stage4_management'),
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            _label(role),
            key: const Key('role_shell_label'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          const DhikrLibrarySection(),
          const SizedBox(height: 12),
          const WirdManagementSection(),
        ],
      );
    }
    return const TodayWirdsSection();
  }

  String _label(AppRole role) => switch (role) {
    AppRole.organizationAdmin => 'إدارة المؤسسة',
    AppRole.branchManager => 'مدير الفرع',
    AppRole.admin => 'الإدارة التشغيلية',
    AppRole.teacher => 'المعلم',
    AppRole.staff => 'الموظف',
    AppRole.student => 'الطالب',
  };
}
