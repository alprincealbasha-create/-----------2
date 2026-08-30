// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthLoading value)?  loading,TResult Function( AuthUnauthenticated value)?  unauthenticated,TResult Function( AuthAuthenticated value)?  authenticated,TResult Function( AuthAuthorizationFailure value)?  authorizationFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading(_that);case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case AuthAuthorizationFailure() when authorizationFailure != null:
return authorizationFailure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthLoading value)  loading,required TResult Function( AuthUnauthenticated value)  unauthenticated,required TResult Function( AuthAuthenticated value)  authenticated,required TResult Function( AuthAuthorizationFailure value)  authorizationFailure,}){
final _that = this;
switch (_that) {
case AuthLoading():
return loading(_that);case AuthUnauthenticated():
return unauthenticated(_that);case AuthAuthenticated():
return authenticated(_that);case AuthAuthorizationFailure():
return authorizationFailure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthLoading value)?  loading,TResult? Function( AuthUnauthenticated value)?  unauthenticated,TResult? Function( AuthAuthenticated value)?  authenticated,TResult? Function( AuthAuthorizationFailure value)?  authorizationFailure,}){
final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading(_that);case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case AuthAuthorizationFailure() when authorizationFailure != null:
return authorizationFailure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String? message)?  unauthenticated,TResult Function( AuthUser user)?  authenticated,TResult Function( String message)?  authorizationFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading();case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.message);case AuthAuthenticated() when authenticated != null:
return authenticated(_that.user);case AuthAuthorizationFailure() when authorizationFailure != null:
return authorizationFailure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String? message)  unauthenticated,required TResult Function( AuthUser user)  authenticated,required TResult Function( String message)  authorizationFailure,}) {final _that = this;
switch (_that) {
case AuthLoading():
return loading();case AuthUnauthenticated():
return unauthenticated(_that.message);case AuthAuthenticated():
return authenticated(_that.user);case AuthAuthorizationFailure():
return authorizationFailure(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String? message)?  unauthenticated,TResult? Function( AuthUser user)?  authenticated,TResult? Function( String message)?  authorizationFailure,}) {final _that = this;
switch (_that) {
case AuthLoading() when loading != null:
return loading();case AuthUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.message);case AuthAuthenticated() when authenticated != null:
return authenticated(_that.user);case AuthAuthorizationFailure() when authorizationFailure != null:
return authorizationFailure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AuthLoading implements AuthState {
  const AuthLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class AuthUnauthenticated implements AuthState {
  const AuthUnauthenticated({this.message});
  

 final  String? message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUnauthenticatedCopyWith<AuthUnauthenticated> get copyWith => _$AuthUnauthenticatedCopyWithImpl<AuthUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUnauthenticated&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.unauthenticated(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthUnauthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthUnauthenticatedCopyWith(AuthUnauthenticated value, $Res Function(AuthUnauthenticated) _then) = _$AuthUnauthenticatedCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$AuthUnauthenticatedCopyWithImpl<$Res>
    implements $AuthUnauthenticatedCopyWith<$Res> {
  _$AuthUnauthenticatedCopyWithImpl(this._self, this._then);

  final AuthUnauthenticated _self;
  final $Res Function(AuthUnauthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(AuthUnauthenticated(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class AuthAuthenticated implements AuthState {
  const AuthAuthenticated(this.user);
  

 final  AuthUser user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthAuthenticatedCopyWith<AuthAuthenticated> get copyWith => _$AuthAuthenticatedCopyWithImpl<AuthAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthAuthenticated&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.authenticated(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthAuthenticatedCopyWith(AuthAuthenticated value, $Res Function(AuthAuthenticated) _then) = _$AuthAuthenticatedCopyWithImpl;
@useResult
$Res call({
 AuthUser user
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthAuthenticatedCopyWithImpl<$Res>
    implements $AuthAuthenticatedCopyWith<$Res> {
  _$AuthAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthAuthenticated _self;
  final $Res Function(AuthAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AuthAuthenticated(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class AuthAuthorizationFailure implements AuthState {
  const AuthAuthorizationFailure(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthAuthorizationFailureCopyWith<AuthAuthorizationFailure> get copyWith => _$AuthAuthorizationFailureCopyWithImpl<AuthAuthorizationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthAuthorizationFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.authorizationFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthAuthorizationFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthAuthorizationFailureCopyWith(AuthAuthorizationFailure value, $Res Function(AuthAuthorizationFailure) _then) = _$AuthAuthorizationFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AuthAuthorizationFailureCopyWithImpl<$Res>
    implements $AuthAuthorizationFailureCopyWith<$Res> {
  _$AuthAuthorizationFailureCopyWithImpl(this._self, this._then);

  final AuthAuthorizationFailure _self;
  final $Res Function(AuthAuthorizationFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AuthAuthorizationFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
