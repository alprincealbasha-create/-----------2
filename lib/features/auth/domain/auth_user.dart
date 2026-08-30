import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/auth/domain/app_role.dart';

part 'auth_user.freezed.dart';

@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({required String id, required AppRole role}) =
      _AuthUser;
}
