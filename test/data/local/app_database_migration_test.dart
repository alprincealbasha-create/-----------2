import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/data/local/app_database.dart';

void main() {
  test('migrates schema 1 sessions and preserves their data', () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database
          ..execute('''
            CREATE TABLE dhikr_sessions (
              id TEXT NOT NULL PRIMARY KEY,
              user_id TEXT NOT NULL,
              title TEXT NOT NULL,
              target INTEGER NOT NULL,
              count INTEGER NOT NULL DEFAULT 0,
              status TEXT NOT NULL DEFAULT 'in_progress',
              updated_at INTEGER NOT NULL,
              completed_at INTEGER
            )
          ''')
          ..execute('''
            CREATE TABLE dhikr_mutations (
              operation_id TEXT NOT NULL PRIMARY KEY,
              user_id TEXT NOT NULL,
              session_id TEXT NOT NULL,
              delta INTEGER NOT NULL DEFAULT 1,
              created_at INTEGER NOT NULL,
              attempt_count INTEGER NOT NULL DEFAULT 0,
              synced_at INTEGER
            )
          ''')
          ..execute('''
            INSERT INTO dhikr_sessions (
              id, user_id, title, target, count, status, updated_at
            ) VALUES (
              'session-1', 'user-1', 'ذكر خاص', 10, 4, 'in_progress', 0
            )
          ''')
          ..execute('PRAGMA user_version = 1');
      },
    );
    final database = AppDatabase.forTesting(executor);
    addTearDown(database.close);

    final session = await database.latestSession('user-1');
    final columns = await database
        .customSelect('PRAGMA table_info(dhikr_sessions)')
        .get();

    expect(session?.count, 4);
    expect(session?.managedWirdId, isNull);
    expect(
      columns.map((row) => row.read<String>('name')),
      contains('managed_wird_id'),
    );
  });
}
