import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/users/data/supabase_branch_users_repository.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_users_repository.dart';

final branchUsersRepositoryProvider = Provider<BranchUsersRepository>((ref) {
  return SupabaseBranchUsersRepository(ref.watch(supabaseClientProvider));
});
