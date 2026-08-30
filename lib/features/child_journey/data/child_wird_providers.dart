import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/child_journey/data/supabase_child_wird_repository.dart';
import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_repository.dart';

final childWirdRepositoryProvider = Provider<ChildWirdRepository>((ref) {
  return SupabaseChildWirdRepository(ref.watch(supabaseClientProvider));
});
