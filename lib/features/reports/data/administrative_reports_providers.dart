import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/reports/data/supabase_administrative_reports_repository.dart';
import 'package:ward_al_rawdah/features/reports/domain/administrative_reports_repository.dart';

final administrativeReportsRepositoryProvider =
    Provider<AdministrativeReportsRepository>((ref) {
      return SupabaseAdministrativeReportsRepository(
        ref.watch(supabaseClientProvider),
      );
    });
