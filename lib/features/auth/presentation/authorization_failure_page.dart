import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';

class AuthorizationFailurePage extends ConsumerWidget {
  const AuthorizationFailurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final message = switch (state) {
      AuthAuthorizationFailure(:final message) => message,
      _ => 'تعذر التحقق من صلاحية الحساب.',
    };

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.gpp_maybe_outlined, size: 48),
                const SizedBox(height: 16),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => ref
                      .read(authControllerProvider.notifier)
                      .retryRoleResolution(),
                  child: const Text('إعادة المحاولة'),
                ),
                TextButton(
                  onPressed: () =>
                      ref.read(authControllerProvider.notifier).signOut(),
                  child: const Text('تسجيل الخروج'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
