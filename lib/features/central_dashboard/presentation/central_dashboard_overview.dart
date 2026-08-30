import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/central_dashboard/application/central_dashboard_controller.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_branch_metrics.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_dashboard_repository.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

class CentralDashboardOverview extends ConsumerStatefulWidget {
  const CentralDashboardOverview({required this.organization, super.key});

  final Organization? organization;

  @override
  ConsumerState<CentralDashboardOverview> createState() =>
      _CentralDashboardOverviewState();
}

class _CentralDashboardOverviewState
    extends ConsumerState<CentralDashboardOverview> {
  String? _selectedBranchId;

  @override
  Widget build(BuildContext context) {
    final metrics = ref.watch(centralDashboardProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'لوحة الإدارة المركزية',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (widget.organization != null)
              Text(
                widget.organization!.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 16),
            if (widget.organization == null)
              const Text('اختر مؤسسة لعرض مقارنة الفروع.')
            else
              metrics.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => _ErrorContent(
                  message: error is CentralDashboardFailure
                      ? error.userMessage
                      : 'تعذر تحميل مؤشرات الإدارة المركزية.',
                  onRetry: () =>
                      ref.read(centralDashboardProvider.notifier).refresh(),
                ),
                data: _buildMetrics,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetrics(List<CentralBranchMetrics> metrics) {
    if (metrics.isEmpty) {
      return const Text('لا توجد فروع لعرضها بعد.');
    }
    final selectedId = metrics.any((item) => item.branchId == _selectedBranchId)
        ? _selectedBranchId
        : null;
    final visible = selectedId == null
        ? metrics
        : metrics.where((item) => item.branchId == selectedId).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String?>(
          key: ValueKey(selectedId),
          initialValue: selectedId,
          decoration: const InputDecoration(
            labelText: 'تصفية الفروع',
            border: OutlineInputBorder(),
          ),
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('كل الفروع'),
            ),
            for (final item in metrics)
              DropdownMenuItem<String?>(
                value: item.branchId,
                child: Text(item.branchName),
              ),
          ],
          onChanged: (value) => setState(() => _selectedBranchId = value),
        ),
        const SizedBox(height: 12),
        Text(
          'الترتيب حسب نسبة الإكمال ثم نسبة المشاركة، وليس عدد الأذكار الخام.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('الفرع')),
              DataColumn(label: Text('المشاركون'), numeric: true),
              DataColumn(label: Text('أكملوا'), numeric: true),
              DataColumn(label: Text('نسبة المشاركة'), numeric: true),
              DataColumn(label: Text('نسبة الإكمال'), numeric: true),
            ],
            rows: [
              for (final item in visible)
                DataRow(
                  cells: [
                    DataCell(Text(item.branchName)),
                    DataCell(Text('${item.participatingUsers}')),
                    DataCell(Text('${item.completedUsers}')),
                    DataCell(Text('${_formatRate(item.participationRate)}%')),
                    DataCell(Text('${_formatRate(item.completionRate)}%')),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'نسبة المشاركة = المشاركون ÷ المستخدمين النشطين. '
          'نسبة الإكمال = المكتملون ÷ المشاركين.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({required this.message, required this.onRetry});

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

String _formatRate(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}
