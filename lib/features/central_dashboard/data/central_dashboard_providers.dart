import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/central_dashboard/data/supabase_central_dashboard_repository.dart';
import 'package:ward_al_rawdah/features/central_dashboard/domain/central_dashboard_repository.dart';

final centralDashboardRepositoryProvider = Provider<CentralDashboardRepository>(
  (ref) =>
      SupabaseCentralDashboardRepository(ref.watch(supabaseClientProvider)),
);

final centralDashboardClockProvider = Provider<DateTime Function()>(
  (ref) => DateTime.now,
);
