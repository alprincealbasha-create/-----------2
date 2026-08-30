import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/campaigns/data/supabase_campaigns_repository.dart';
import 'package:ward_al_rawdah/features/campaigns/domain/campaigns_repository.dart';

final campaignsRepositoryProvider = Provider<CampaignsRepository>((ref) {
  return SupabaseCampaignsRepository(ref.watch(supabaseClientProvider));
});
