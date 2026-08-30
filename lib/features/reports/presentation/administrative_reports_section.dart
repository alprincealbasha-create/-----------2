import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/reports/application/administrative_reports_controller.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_report_models.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_reports_repository.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

class AdministrativeReportsSection extends ConsumerStatefulWidget {
  const AdministrativeReportsSection({super.key});

  @override
  ConsumerState<AdministrativeReportsSection> createState() =>
      _AdministrativeReportsSectionState();
}

class _AdministrativeReportsSectionState
    extends ConsumerState<AdministrativeReportsSection> {
  AdministrativeReportFilters? _draft;

  @override
  Widget build(BuildContext context) {
    final report = ref.watch(administrativeReportsProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'تقارير الإنجاز',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'يمكن دمج جميع الفلاتر، وتُطبّق الصلاحيات والتصفية على الخادم.',
            ),
            const SizedBox(height: 16),
            report.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _ReportError(
                message: error is AdministrativeReportFailure
                    ? error.userMessage
                    : 'تعذر تحميل التقارير.',
                onRetry: () =>
                    ref.read(administrativeReportsProvider.notifier).refresh(),
              ),
              data: (data) {
                _draft ??= data.filters;
                return _ReportContent(
                  data: data,
                  draft: _draft!,
                  onChanged: (value) => setState(() => _draft = value),
                  onApply: () => ref
                      .read(administrativeReportsProvider.notifier)
                      .apply(_draft!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportContent extends StatelessWidget {
  const _ReportContent({
    required this.data,
    required this.draft,
    required this.onChanged,
    required this.onApply,
  });

  final AdministrativeReportData data;
  final AdministrativeReportFilters draft;
  final ValueChanged<AdministrativeReportFilters> onChanged;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final options = data.options;
    final classes = options.classes
        .where(
          (item) => draft.branchId == null || item.branchId == draft.branchId,
        )
        .toList(growable: false);
    final users = options.users
        .where(
          (item) =>
              (draft.branchId == null || item.branchId == draft.branchId) &&
              (draft.classId == null || item.classId == draft.classId) &&
              (draft.role == null || item.role == draft.role),
        )
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SegmentedButton<AdministrativeReportView>(
          segments: [
            for (final view in AdministrativeReportView.values)
              ButtonSegment(value: view, label: Text(view.arabicLabel)),
          ],
          selected: {draft.view},
          onSelectionChanged: (selection) =>
              onChanged(draft.copyWith(view: selection.single)),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () async {
            final range = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
              initialDateRange: DateTimeRange(
                start: draft.startDate,
                end: draft.endDate,
              ),
            );
            if (range != null) {
              onChanged(
                draft.copyWith(startDate: range.start, endDate: range.end),
              );
            }
          },
          icon: const Icon(Icons.date_range_outlined),
          label: Text(
            'الفترة: ${_date(draft.startDate)} – ${_date(draft.endDate)}',
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _FilterDropdown<String>(
              label: 'الفرع',
              value: draft.branchId,
              options: _options(options.branches),
              onChanged: (value) => onChanged(
                draft.copyWith(branchId: value, classId: null, userId: null),
              ),
            ),
            _FilterDropdown<String>(
              label: 'الصف',
              value: classes.any((item) => item.id == draft.classId)
                  ? draft.classId
                  : null,
              options: _options(classes),
              onChanged: (value) =>
                  onChanged(draft.copyWith(classId: value, userId: null)),
            ),
            _FilterDropdown<ManagedUserType>(
              label: 'الدور / الفئة',
              value: draft.role,
              options: {
                for (final item in ManagedUserType.values)
                  item: item.arabicLabel,
              },
              onChanged: (value) =>
                  onChanged(draft.copyWith(role: value, userId: null)),
            ),
            _FilterDropdown<String>(
              label: 'المستخدم',
              value: users.any((item) => item.id == draft.userId)
                  ? draft.userId
                  : null,
              options: _options(users),
              onChanged: (value) => onChanged(draft.copyWith(userId: value)),
            ),
            _FilterDropdown<String>(
              label: 'الورد',
              value: draft.wirdId,
              options: _options(options.wirds),
              onChanged: (value) => onChanged(draft.copyWith(wirdId: value)),
            ),
            _FilterDropdown<String>(
              label: 'الذكر',
              value: draft.dhikrId,
              options: _options(options.dhikrs),
              onChanged: (value) => onChanged(draft.copyWith(dhikrId: value)),
            ),
            _FilterDropdown<ReportCompletionStatus>(
              label: 'حالة الإتمام',
              value: draft.completionStatus,
              options: {
                for (final item in ReportCompletionStatus.values)
                  item: item.arabicLabel,
              },
              onChanged: (value) =>
                  onChanged(draft.copyWith(completionStatus: value)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: onApply,
          icon: const Icon(Icons.filter_alt_outlined),
          label: const Text('تطبيق الفلاتر'),
        ),
        const SizedBox(height: 16),
        _ReportResults(rows: data.rows, filters: data.filters),
      ],
    );
  }

  static Map<String, String> _options(List<ReportFilterOption> values) => {
    for (final item in values) item.id: item.label,
  };
}

class _FilterDropdown<T> extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final Map<T, String> options;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: DropdownButtonFormField<T?>(
        key: ValueKey('$label-$value'),
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: [
          DropdownMenuItem<T?>(value: null, child: const Text('الكل')),
          for (final entry in options.entries)
            DropdownMenuItem<T?>(value: entry.key, child: Text(entry.value)),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

class _ReportResults extends StatelessWidget {
  const _ReportResults({required this.rows, required this.filters});

  final List<AdministrativeReportRow> rows;
  final AdministrativeReportFilters filters;

  @override
  Widget build(BuildContext context) {
    if (filters.view == AdministrativeReportView.branch &&
        filters.branchId == null) {
      return const Text('اختر فرعًا لعرض تقرير الفرع.');
    }
    if (filters.view == AdministrativeReportView.user &&
        filters.userId == null) {
      return const Text('اختر مستخدمًا لعرض تقرير المستخدم.');
    }
    if (rows.isEmpty) {
      return const Text('لا توجد نتائج مطابقة للفلاتر المحددة.');
    }
    if (filters.view == AdministrativeReportView.daily) {
      final days = <DateTime, List<AdministrativeReportRow>>{};
      for (final row in rows) {
        days.putIfAbsent(row.activityDate, () => []).add(row);
      }
      final orderedDays = days.keys.toList()..sort((a, b) => b.compareTo(a));
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final day in orderedDays) ...[
            Text(_date(day), style: Theme.of(context).textTheme.titleMedium),
            _ReportSummary(rows: days[day]!),
            const SizedBox(height: 12),
          ],
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ReportSummary(rows: rows),
        const SizedBox(height: 12),
        for (final row in rows) ...[
          _ReportRowCard(row: row),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _ReportSummary extends StatelessWidget {
  const _ReportSummary({required this.rows});

  final List<AdministrativeReportRow> rows;

  @override
  Widget build(BuildContext context) {
    final completed = rows
        .where(
          (row) => row.completionStatus == ReportCompletionStatus.completed,
        )
        .length;
    final rate = rows.isEmpty ? 0 : (completed * 100 / rows.length).round();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(label: Text('النتائج: ${rows.length}')),
        Chip(label: Text('المكتمل: $completed')),
        Chip(label: Text('نسبة الإتمام: $rate%')),
      ],
    );
  }
}

class _ReportRowCard extends StatelessWidget {
  const _ReportRowCard({required this.row});

  final AdministrativeReportRow row;

  @override
  Widget build(BuildContext context) {
    final classText = row.className == null ? '' : ' — ${row.className}';
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text('${row.userName} — ${row.wirdName}'),
        subtitle: Text(
          '${row.branchName}$classText\n'
          '${row.userRole.arabicLabel} — ${row.dhikrTitle} — '
          '${row.currentCount}/${row.targetCount}',
        ),
        isThreeLine: true,
        trailing: Chip(label: Text(row.completionStatus.arabicLabel)),
      ),
    );
  }
}

class _ReportError extends StatelessWidget {
  const _ReportError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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

String _date(DateTime value) {
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '${value.year}-$month-$day';
}
