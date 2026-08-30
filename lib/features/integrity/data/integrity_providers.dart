import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/integrity/data/supabase_integrity_repository.dart';
import 'package:ward_al_rawdah/features/integrity/domain/integrity_repository.dart';

final integrityRepositoryProvider = Provider<IntegrityRepository>((ref) {
  return SupabaseIntegrityRepository(ref.watch(supabaseClientProvider));
});
