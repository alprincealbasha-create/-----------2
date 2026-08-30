import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/data/supabase_branch_dashboard_repository.dart';
import 'package:ward_al_rawdah/features/branch_dashboard/domain/branch_dashboard_repository.dart';

final branchDashboardRepositoryProvider = Provider<BranchDashboardRepository>((
  ref,
) {
  return SupabaseBranchDashboardRepository(ref.watch(supabaseClientProvider));
});

final branchDashboardClockProvider = Provider<DateTime Function()>((ref) {
  return DateTime.now;
});
