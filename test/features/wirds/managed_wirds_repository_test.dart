import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wird.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wirds_repository.dart';

import 'fake_managed_wirds_repository.dart';

void main() {
  late FakeManagedWirdsRepository repository;

  setUp(() {
    repository = FakeManagedWirdsRepository(
      userBranches: {'user-damascus': 'damascus', 'user-aleppo': 'aleppo'},
    );
  });

  test('runs create, edit, assign, and complete lifecycle', () async {
    final draft = await repository.createWird(
      branchId: 'damascus',
      title: 'ورد خاص',
      targetCount: 100,
      details: 'تفاصيل يكتبها المدير',
    );
    expect(draft.status, ManagedWirdStatus.draft);

    final edited = await repository.updateWird(
      draft.copyWith(title: 'ورد خاص محدث'),
    );
    expect(edited.title, 'ورد خاص محدث');

    final assigned = await repository.assignWird(
      wird: edited,
      userId: 'user-damascus',
    );
    expect(assigned.status, ManagedWirdStatus.assigned);
    expect(assigned.assignedUserId, 'user-damascus');
    expect(assigned.assignedAt, isNotNull);

    final completed = await repository.completeWird(assigned);
    expect(completed.status, ManagedWirdStatus.completed);
    expect(completed.completedAt, isNotNull);
  });

  test('requires assignment before completion', () async {
    final draft = await repository.createWird(
      branchId: 'damascus',
      title: 'ورد خاص',
      targetCount: 100,
    );

    expect(
      () => repository.completeWird(draft),
      throwsA(isA<WirdManagementFailure>()),
    );
  });

  test('rejects an assignee from another branch', () async {
    final draft = await repository.createWird(
      branchId: 'damascus',
      title: 'ورد خاص',
      targetCount: 100,
    );

    expect(
      () => repository.assignWird(wird: draft, userId: 'user-aleppo'),
      throwsA(isA<WirdManagementFailure>()),
    );
  });

  test('completed wird is immutable', () async {
    final draft = await repository.createWird(
      branchId: 'damascus',
      title: 'ورد خاص',
      targetCount: 100,
    );
    final assigned = await repository.assignWird(
      wird: draft,
      userId: 'user-damascus',
    );
    final completed = await repository.completeWird(assigned);

    expect(
      () => repository.updateWird(completed.copyWith(title: 'تعديل مرفوض')),
      throwsA(isA<WirdManagementFailure>()),
    );
    expect(
      () => repository.assignWird(wird: completed, userId: 'user-damascus'),
      throwsA(isA<WirdManagementFailure>()),
    );
  });
}
