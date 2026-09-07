import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified_user_outlined, size: 56),
              const SizedBox(height: 16),
              Text(
                _label(role),
                key: const Key('role_shell_label'),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'تم التحقق من هويتك وصلاحية حسابك.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
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
