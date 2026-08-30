import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/integrity/application/integrity_controller.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_models.dart';
import 'package:ward_al_rawdah/features/integrity/presentation/integrity_section.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organization_models.dart';

void main() {
  test('maps an integrity flag without any achievement mutation field', () {
    final flag = IntegrityFlag.fromRpc({
      'flag_id': 'flag-1',
      'branch_user_id': 'child-1',
      'user_name': 'طفل الاختبار',
      'flag_type': 'unusually_fast_activity',
      'flag_status': 'open',
      'observed_count': 22,
      'threshold_count': 20,
      'window_started_at': '2026-08-25T12:00:00Z',
      'window_ended_at': '2026-08-25T12:00:05Z',
      'detected_at': '2026-08-25T12:00:05Z',
      'evidence': {'operation_count': 22},
    });

    expect(flag.type, IntegrityFlagType.unusuallyFastActivity);
    expect(flag.status, IntegrityFlagStatus.open);
    expect(flag.observedCount, 22);
    expect(flag.thresholdCount, 20);
  });

  testWidgets('shows non-destructive flags only to the administration', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          integrityProvider.overrideWith(FixedIntegrityController.new),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: IntegritySection(
                branch: Branch(
                  id: 'branch-1',
                  organizationId: 'organization-1',
                  name: 'فرع الاختبار',
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('مؤشرات النزاهة'), findsOneWidget);
    expect(
      find.textContaining('لا تحذف الإنجاز ولا تغيّر النقاط'),
      findsOneWidget,
    );
    expect(find.text('نشاط سريع بصورة غير معتادة'), findsOneWidget);
    expect(find.text('نشاط مرتفع بصورة غير معتادة'), findsOneWidget);
    expect(find.text('مشكلة محتملة في المزامنة'), findsOneWidget);
    expect(find.text('تمت المراجعة'), findsNWidgets(3));
    expect(find.text('استبعاد المؤشر'), findsNWidgets(3));
    expect(find.textContaining('حذف الإنجاز'), findsOneWidget);
  });
}

class FixedIntegrityController extends IntegrityController {
  @override
  Future<List<IntegrityFlag>> build() async => [
    _flag(
      id: 'flag-1',
      type: IntegrityFlagType.unusuallyFastActivity,
      observed: 22,
      threshold: 20,
    ),
    _flag(
      id: 'flag-2',
      type: IntegrityFlagType.excessiveActivity,
      observed: 5100,
      threshold: 5000,
    ),
    _flag(
      id: 'flag-3',
      type: IntegrityFlagType.syncAnomaly,
      observed: 11,
      threshold: 10,
    ),
  ];
}

IntegrityFlag _flag({
  required String id,
  required IntegrityFlagType type,
  required int observed,
  required int threshold,
}) {
  final detectedAt = DateTime.utc(2026, 8, 25, 12);
  return IntegrityFlag(
    id: id,
    branchUserId: 'child-1',
    userName: 'طفل الاختبار',
    type: type,
    status: IntegrityFlagStatus.open,
    observedCount: observed,
    thresholdCount: threshold,
    windowStartedAt: detectedAt.subtract(const Duration(seconds: 5)),
    windowEndedAt: detectedAt,
    detectedAt: detectedAt,
  );
}
