import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ward_al_rawdah/features/auth/data/supabase_auth_repository.dart';
import 'package:ward_al_rawdah/features/auth/domain/auth_repository.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  throw StateError('SupabaseClient must be overridden at application startup.');
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return SupabaseAuthRepository(ref.watch(supabaseClientProvider));
});
