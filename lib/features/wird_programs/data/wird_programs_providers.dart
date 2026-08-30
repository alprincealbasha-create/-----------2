import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/wird_programs/data/supabase_wird_programs_repository.dart';
import 'package:ward_al_rawdah/features/wird_programs/domain/wird_programs_repository.dart';

final wirdProgramsRepositoryProvider = Provider<WirdProgramsRepository>((ref) {
  return SupabaseWirdProgramsRepository(ref.watch(supabaseClientProvider));
});
