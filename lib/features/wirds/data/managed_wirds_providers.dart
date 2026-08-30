import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/wirds/data/supabase_managed_wirds_repository.dart';
import 'package:ward_al_rawdah/features/wirds/domain/managed_wirds_repository.dart';

final managedWirdsRepositoryProvider = Provider<ManagedWirdsRepository>((ref) {
  return SupabaseManagedWirdsRepository(ref.watch(supabaseClientProvider));
});
