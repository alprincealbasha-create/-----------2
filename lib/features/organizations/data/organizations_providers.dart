import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/organizations/data/supabase_organizations_repository.dart';
import 'package:ward_al_rawdah/features/organizations/domain/organizations_repository.dart';

final organizationsRepositoryProvider = Provider<OrganizationsRepository>((
  ref,
) {
  return SupabaseOrganizationsRepository(ref.watch(supabaseClientProvider));
});
