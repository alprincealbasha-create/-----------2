import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/badges/data/supabase_badges_repository.dart';
import 'package:ward_al_rawdah/features/badges/domain/badges_repository.dart';

final badgesRepositoryProvider = Provider<BadgesRepository>((ref) {
  return SupabaseBadgesRepository(ref.watch(supabaseClientProvider));
});
