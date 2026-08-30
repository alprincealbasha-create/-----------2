import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/data/local/database_provider.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/dhikr/data/dhikr_sync_gateway.dart';
import 'package:ward_al_rawdah/features/dhikr/data/offline_first_dhikr_repository.dart';
import 'package:ward_al_rawdah/features/dhikr/domain/dhikr_repository.dart';

final connectivityChangesProvider = StreamProvider<List<ConnectivityResult>>((
  ref,
) {
  return Connectivity().onConnectivityChanged;
});

final dhikrSyncGatewayProvider = Provider<DhikrSyncGateway>((ref) {
  return SupabaseDhikrSyncGateway(ref.watch(supabaseClientProvider));
});

final dhikrRepositoryProvider = Provider<DhikrRepository>((ref) {
  return OfflineFirstDhikrRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(dhikrSyncGatewayProvider),
  );
});
