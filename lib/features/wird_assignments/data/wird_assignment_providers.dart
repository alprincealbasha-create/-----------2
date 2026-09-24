import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/auth/data/auth_providers.dart';
import 'package:ward_al_rawdah/features/wird_assignments/data/supabase_wird_assignment_repository.dart';
import 'package:ward_al_rawdah/features/wird_assignments/domain/wird_assignment_repository.dart';

final wirdAssignmentRepositoryProvider = Provider<WirdAssignmentRepository>(
  (ref) => SupabaseWirdAssignmentRepository(ref.watch(supabaseClientProvider)),
);
