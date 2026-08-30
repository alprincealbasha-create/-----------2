// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch_user_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManagedUser {

 String get id;@JsonKey(name: 'branch_id') String get branchId;@JsonKey(name: 'class_id') String? get classId;@JsonKey(name: 'profile_id') String? get profileId;@JsonKey(name: 'user_type') ManagedUserType get userType;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'birth_date') DateTime? get birthDate;
/// Create a copy of ManagedUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManagedUserCopyWith<ManagedUser> get copyWith => _$ManagedUserCopyWithImpl<ManagedUser>(this as ManagedUser, _$identity);

  /// Serializes this ManagedUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagedUser&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,classId,profileId,userType,fullName,birthDate);

@override
String toString() {
  return 'ManagedUser(id: $id, branchId: $branchId, classId: $classId, profileId: $profileId, userType: $userType, fullName: $fullName, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class $ManagedUserCopyWith<$Res>  {
  factory $ManagedUserCopyWith(ManagedUser value, $Res Function(ManagedUser) _then) = _$ManagedUserCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'branch_id') String branchId,@JsonKey(name: 'class_id') String? classId,@JsonKey(name: 'profile_id') String? profileId,@JsonKey(name: 'user_type') ManagedUserType userType,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'birth_date') DateTime? birthDate
});




}
/// @nodoc
class _$ManagedUserCopyWithImpl<$Res>
    implements $ManagedUserCopyWith<$Res> {
  _$ManagedUserCopyWithImpl(this._self, this._then);

  final ManagedUser _self;
  final $Res Function(ManagedUser) _then;

/// Create a copy of ManagedUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = null,Object? classId = freezed,Object? profileId = freezed,Object? userType = null,Object? fullName = null,Object? birthDate = freezed,}) {
  return _then(ManagedUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as ManagedUserType,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ManagedUser].
extension ManagedUserPatterns on ManagedUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManagedUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManagedUser() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManagedUser value)  $default,){
final _that = this;
switch (_that) {
case _ManagedUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManagedUser value)?  $default,){
final _that = this;
switch (_that) {
case _ManagedUser() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'branch_id')  String branchId, @JsonKey(name: 'class_id')  String? classId, @JsonKey(name: 'profile_id')  String? profileId, @JsonKey(name: 'user_type')  ManagedUserType userType, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'birth_date')  DateTime? birthDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManagedUser() when $default != null:
return $default(_that.id,_that.branchId,_that.classId,_that.profileId,_that.userType,_that.fullName,_that.birthDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'branch_id')  String branchId, @JsonKey(name: 'class_id')  String? classId, @JsonKey(name: 'profile_id')  String? profileId, @JsonKey(name: 'user_type')  ManagedUserType userType, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'birth_date')  DateTime? birthDate)  $default,) {final _that = this;
switch (_that) {
case _ManagedUser():
return $default(_that.id,_that.branchId,_that.classId,_that.profileId,_that.userType,_that.fullName,_that.birthDate);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'branch_id')  String branchId, @JsonKey(name: 'class_id')  String? classId, @JsonKey(name: 'profile_id')  String? profileId, @JsonKey(name: 'user_type')  ManagedUserType userType, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'birth_date')  DateTime? birthDate)?  $default,) {final _that = this;
switch (_that) {
case _ManagedUser() when $default != null:
return $default(_that.id,_that.branchId,_that.classId,_that.profileId,_that.userType,_that.fullName,_that.birthDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ManagedUser implements ManagedUser {
  const _ManagedUser({required this.id, @JsonKey(name: 'branch_id') required this.branchId, @JsonKey(name: 'class_id') this.classId, @JsonKey(name: 'profile_id') this.profileId, @JsonKey(name: 'user_type') required this.userType, @JsonKey(name: 'full_name') required this.fullName, @JsonKey(name: 'birth_date') this.birthDate});
  factory _ManagedUser.fromJson(Map<String, dynamic> json) => _$ManagedUserFromJson(json);

@override final  String id;
@override@JsonKey(name: 'branch_id') final  String branchId;
@override@JsonKey(name: 'class_id') final  String? classId;
@override@JsonKey(name: 'profile_id') final  String? profileId;
@override@JsonKey(name: 'user_type') final  ManagedUserType userType;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'birth_date') final  DateTime? birthDate;

/// Create a copy of ManagedUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManagedUserCopyWith<_ManagedUser> get copyWith => __$ManagedUserCopyWithImpl<_ManagedUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManagedUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManagedUser&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,classId,profileId,userType,fullName,birthDate);

@override
String toString() {
  return 'ManagedUser(id: $id, branchId: $branchId, classId: $classId, profileId: $profileId, userType: $userType, fullName: $fullName, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class _$ManagedUserCopyWith<$Res> implements $ManagedUserCopyWith<$Res> {
  factory _$ManagedUserCopyWith(_ManagedUser value, $Res Function(_ManagedUser) _then) = __$ManagedUserCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'branch_id') String branchId,@JsonKey(name: 'class_id') String? classId,@JsonKey(name: 'profile_id') String? profileId,@JsonKey(name: 'user_type') ManagedUserType userType,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'birth_date') DateTime? birthDate
});




}
/// @nodoc
class __$ManagedUserCopyWithImpl<$Res>
    implements _$ManagedUserCopyWith<$Res> {
  __$ManagedUserCopyWithImpl(this._self, this._then);

  final _ManagedUser _self;
  final $Res Function(_ManagedUser) _then;

/// Create a copy of ManagedUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = null,Object? classId = freezed,Object? profileId = freezed,Object? userType = null,Object? fullName = null,Object? birthDate = freezed,}) {
  return _then(_ManagedUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as ManagedUserType,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
