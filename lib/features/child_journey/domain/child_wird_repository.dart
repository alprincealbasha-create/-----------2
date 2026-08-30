import 'package:ward_al_rawdah/features/child_journey/domain/child_wird_state.dart';

abstract interface class ChildWirdRepository {
  Future<ChildWirdState> loadHome();
}

class ChildWirdFailure implements Exception {
  const ChildWirdFailure(this.userMessage);

  final String userMessage;

  @override
  String toString() => userMessage;
}
