import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ward_al_rawdah/app/app_config.dart';
import 'package:ward_al_rawdah/app/configuration_error_app.dart';

void main() {
  group('G1 configuration foundation', () {
    test('rejects missing runtime configuration', () {
      const config = AppConfig(supabaseUrl: '', publishableKey: '');

      expect(config.isConfigured, isFalse);
    });

    test('accepts a valid public endpoint and client key', () {
      const config = AppConfig(
        supabaseUrl: 'https://project-ref.supabase.co',
        publishableKey: 'public-test-placeholder',
      );

      expect(config.isConfigured, isTrue);
    });

    testWidgets('runs a safe RTL shell without runtime configuration', (
      tester,
    ) async {
      await tester.pumpWidget(const ConfigurationErrorApp());

      expect(find.byType(MaterialApp), findsOneWidget);
      final message = find.textContaining('إعدادات الاتصال غير مكتملة');
      expect(message, findsOneWidget);
      expect(
        tester
            .widget<Directionality>(
              find
                  .ancestor(of: message, matching: find.byType(Directionality))
                  .first,
            )
            .textDirection,
        TextDirection.rtl,
      );
      expect(tester.takeException(), isNull);
    });
  });
}
