import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ward_al_rawdah/features/child_journey/data/child_wird_providers.dart';
import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_state.dart';

final childWirdProvider =
    AsyncNotifierProvider<ChildWirdController, ChildWirdState>(
      ChildWirdController.new,
    );

class ChildWirdController extends AsyncNotifier<ChildWirdState> {
  @override
  Future<ChildWirdState> build() {
    return ref.read(childWirdRepositoryProvider).loadHome();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(childWirdRepositoryProvider).loadHome(),
    );
  }
}
