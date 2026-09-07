import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/application/auth_controller.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _organizationCodeController = TextEditingController();
  final _studentCodeController = TextEditingController();
  final _pinController = TextEditingController();
  var _obscurePassword = true;
  var _studentLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _organizationCodeController.dispose();
    _studentCodeController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AuthLoading;
    final message = switch (authState) {
      AuthUnauthenticated(:final message) => message,
      _ => null,
    };

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'ورد الروضة',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'سجّل الدخول للوصول إلى وردك اليومي',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(value: false, label: Text('موظف')),
                        ButtonSegment(value: true, label: Text('طالب')),
                      ],
                      selected: {_studentLogin},
                      onSelectionChanged: isLoading
                          ? null
                          : (selection) {
                              setState(() => _studentLogin = selection.single);
                              _formKey.currentState?.reset();
                            },
                    ),
                    const SizedBox(height: 24),
                    if (_studentLogin) ...[
                      TextFormField(
                        key: const Key('organization_code'),
                        controller: _organizationCodeController,
                        textDirection: TextDirection.ltr,
                        decoration: const InputDecoration(
                          labelText: 'رمز المؤسسة',
                          prefixIcon: Icon(Icons.business_outlined),
                        ),
                        validator: _requiredCode,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        key: const Key('student_code'),
                        controller: _studentCodeController,
                        textDirection: TextDirection.ltr,
                        decoration: const InputDecoration(
                          labelText: 'رمز الطالب',
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                        validator: _requiredCode,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        key: const Key('student_pin'),
                        controller: _pinController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        maxLength: 6,
                        autofillHints: const [AutofillHints.password],
                        onFieldSubmitted: (_) => _submit(isLoading),
                        decoration: const InputDecoration(
                          labelText: 'الرمز السري',
                          prefixIcon: Icon(Icons.pin_outlined),
                        ),
                        validator: (value) =>
                            RegExp(r'^\d{6}$').hasMatch(value ?? '')
                            ? null
                            : 'أدخل رمزًا سريًا من 6 أرقام',
                      ),
                    ] else ...[
                      TextFormField(
                        key: const Key('login_email'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        autofillHints: const [AutofillHints.email],
                        decoration: const InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty || !email.contains('@')) {
                            return 'أدخل بريدًا إلكترونيًا صحيحًا';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        key: const Key('login_password'),
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textDirection: TextDirection.ltr,
                        autofillHints: const [AutofillHints.password],
                        onFieldSubmitted: (_) => _submit(isLoading),
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            tooltip: _obscurePassword
                                ? 'إظهار كلمة المرور'
                                : 'إخفاء كلمة المرور',
                            onPressed: () {
                              setState(
                                () => _obscurePassword = !_obscurePassword,
                              );
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if ((value ?? '').length < 6) {
                            return 'كلمة المرور يجب ألا تقل عن 6 أحرف';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (message != null) ...[
                      const SizedBox(height: 16),
                      Semantics(
                        liveRegion: true,
                        child: Text(
                          message,
                          key: const Key('login_error'),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    FilledButton(
                      key: const Key('login_submit'),
                      onPressed: isLoading ? null : () => _submit(false),
                      child: isLoading
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _studentLogin ? 'دخول الطالب' : 'تسجيل الدخول',
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(bool isLoading) {
    if (isLoading || !_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final controller = ref.read(authControllerProvider.notifier);
    if (_studentLogin) {
      controller.signInStudent(
        organizationCode: _organizationCodeController.text,
        studentCode: _studentCodeController.text,
        pin: _pinController.text,
      );
    } else {
      controller.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  String? _requiredCode(String? value) {
    return (value ?? '').trim().isEmpty ? 'هذا الحقل مطلوب' : null;
  }
}
