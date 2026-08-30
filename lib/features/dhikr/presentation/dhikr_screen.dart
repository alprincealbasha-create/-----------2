import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/dhikr/application/dhikr_controller.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_counter.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_repository.dart';
import 'package:ward_al_rawdah/features/child_journey/application/child_wird_controller.dart';
import 'package:ward_al_rawdah/features/employee_journey/application/employee_journey_controller.dart';

class DhikrScreen extends ConsumerWidget {
  const DhikrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(dhikrControllerProvider);
    final reward = ref.watch(childWirdProvider).value?.reward;
    ref.listen(dhikrControllerProvider, (_, next) {
      final value = next.value;
      if (value?.managedWirdId != null &&
          value?.completionState == DhikrCompletionState.completed &&
          value?.syncState == DhikrSyncState.synced) {
        ref.invalidate(childWirdProvider);
        ref.invalidate(employeeJourneyProvider);
      }
    });
    return Scaffold(
      appBar: AppBar(title: const Text('عداد الذكر')),
      body: SafeArea(
        child: counter.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _ErrorView(
            message: error is DhikrFailure
                ? error.userMessage
                : 'تعذر تحميل العداد المحلي.',
            onRetry: () => ref.invalidate(dhikrControllerProvider),
          ),
          data: (value) => value == null
              ? _EmptyCounter(onCreate: () => _createCounter(context, ref))
              : _CounterContent(
                  counter: value,
                  points: reward?.points ?? 0,
                  badge: reward?.badge,
                  onIncrement: () =>
                      ref.read(dhikrControllerProvider.notifier).increment(),
                  onSync: () =>
                      ref.read(dhikrControllerProvider.notifier).sync(),
                  onNewCounter: () => _createCounter(context, ref),
                ),
        ),
      ),
    );
  }
}

class _EmptyCounter extends StatelessWidget {
  const _EmptyCounter({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.touch_app_outlined,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'أنشئ عدادًا خاصًا بك',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'اكتب عنوان الذكر والهدف الذي اخترته، وسيُحفظ تقدمك على الجهاز.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add),
              label: const Text('إنشاء عداد'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterContent extends StatelessWidget {
  const _CounterContent({
    required this.counter,
    required this.points,
    required this.badge,
    required this.onIncrement,
    required this.onSync,
    required this.onNewCounter,
  });

  final DhikrCounter counter;
  final int points;
  final String? badge;
  final Future<void> Function() onIncrement;
  final Future<void> Function() onSync;
  final VoidCallback onNewCounter;

  @override
  Widget build(BuildContext context) {
    final completed = counter.completionState == DhikrCompletionState.completed;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          counter.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        Semantics(
          label: 'تقدم الذكر',
          value: '${counter.count} من ${counter.target}',
          child: LinearProgressIndicator(
            value: counter.progress,
            minHeight: 12,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          '${counter.count}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: completed ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
        Text(
          'من ${counter.target}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 32),
        if (completed)
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    counter.managedWirdId == null
                        ? 'اكتمل الهدف'
                        : '🌟 أحسنت، أتممت هذا الورد.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (counter.managedWirdId != null &&
                      counter.syncState == DhikrSyncState.synced) ...[
                    const SizedBox(height: 12),
                    Text('النقاط: $points'),
                    if (badge == 'first_wird') const Text('🏅 شارة: أول ورد'),
                  ],
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: 140,
            child: Semantics(
              button: true,
              label: 'زيادة عداد الذكر',
              value: '${counter.count} من ${counter.target}',
              child: FilledButton(
                onPressed: onIncrement,
                child: counter.managedWirdId == null
                    ? const Icon(Icons.add, size: 64)
                    : const Text('اضغط للذكر', style: TextStyle(fontSize: 26)),
              ),
            ),
          ),
        const SizedBox(height: 24),
        _SyncStatus(counter: counter, onSync: onSync),
        if (completed && counter.managedWirdId == null) ...[
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onNewCounter,
            icon: const Icon(Icons.add),
            label: const Text('بدء عداد جديد'),
          ),
        ],
      ],
    );
  }
}

class _SyncStatus extends StatelessWidget {
  const _SyncStatus({required this.counter, required this.onSync});

  final DhikrCounter counter;
  final Future<void> Function() onSync;

  @override
  Widget build(BuildContext context) {
    return switch (counter.syncState) {
      DhikrSyncState.synced => const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_done_outlined, size: 20),
          SizedBox(width: 8),
          Text('تمت المزامنة'),
        ],
      ),
      DhikrSyncState.pending => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_upload_outlined, size: 20),
          const SizedBox(width: 8),
          Text('بانتظار المزامنة (${counter.pendingSyncCount})'),
        ],
      ),
      DhikrSyncState.failed => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Text('تعذرت المزامنة، والتقدم محفوظ محليًا.')),
          TextButton(onPressed: onSync, child: const Text('إعادة المحاولة')),
        ],
      ),
    };
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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

Future<void> _createCounter(BuildContext context, WidgetRef ref) async {
  final input = await showDialog<_CounterInput>(
    context: context,
    builder: (context) => const _CounterDialog(),
  );
  if (input == null) return;
  await ref
      .read(dhikrControllerProvider.notifier)
      .createCounter(title: input.title, target: input.target);
}

class _CounterInput {
  const _CounterInput({required this.title, required this.target});

  final String title;
  final int target;
}

class _CounterDialog extends StatefulWidget {
  const _CounterDialog();

  @override
  State<_CounterDialog> createState() => _CounterDialogState();
}

class _CounterDialogState extends State<_CounterDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _targetController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إنشاء عداد'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              autofocus: true,
              maxLength: 160,
              decoration: const InputDecoration(labelText: 'عنوان الذكر'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'العنوان مطلوب'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'الهدف'),
              validator: (value) {
                final target = int.tryParse(value ?? '');
                return target == null || target < 1 || target > 100000
                    ? 'أدخل رقمًا بين 1 و100000'
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
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              _CounterInput(
                title: _titleController.text.trim(),
                target: int.parse(_targetController.text),
              ),
            );
          },
          child: const Text('بدء'),
        ),
      ],
    );
  }
}
