import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/dhikr_library/data/supabase_dhikr_library_repository.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_library_repository.dart';

final dhikrLibraryRepositoryProvider = Provider<DhikrLibraryRepository>((ref) {
  return SupabaseDhikrLibraryRepository(ref.watch(supabaseClientProvider));
});
