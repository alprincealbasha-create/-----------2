import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/app/app_config.dart';
import 'package:ward_al_rawdah/app/configuration_error_app.dart';
import 'package:ward_al_rawdah/app/ward_app.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const config = AppConfig.fromEnvironment();
  if (!config.isConfigured) {
    runApp(const ConfigurationErrorApp());
    return;
  }

  await Supabase.initialize(
    url: config.supabaseUrl,
    publishableKey: config.publishableKey,
  );

  runApp(
    ProviderScope(
      overrides: [
        supabaseClientProvider.overrideWithValue(Supabase.instance.client),
      ],
      child: const WardApp(),
    ),
  );
}
