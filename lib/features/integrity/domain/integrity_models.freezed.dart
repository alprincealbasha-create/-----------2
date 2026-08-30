// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'integrity_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IntegrityFlag {

 String get id; String get branchUserId; String get userName; IntegrityFlagType get type; IntegrityFlagStatus get status; int get observedCount; int get thresholdCount; DateTime get windowStartedAt; DateTime get windowEndedAt; DateTime get detectedAt;
/// Create a copy of IntegrityFlag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntegrityFlagCopyWith<IntegrityFlag> get copyWith => _$IntegrityFlagCopyWithImpl<IntegrityFlag>(this as IntegrityFlag, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntegrityFlag&&(identical(other.id, id) || other.id == id)&&(identical(other.branchUserId, branchUserId) || other.branchUserId == branchUserId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.observedCount, observedCount) || other.observedCount == observedCount)&&(identical(other.thresholdCount, thresholdCount) || other.thresholdCount == thresholdCount)&&(identical(other.windowStartedAt, windowStartedAt) || other.windowStartedAt == windowStartedAt)&&(identical(other.windowEndedAt, windowEndedAt) || other.windowEndedAt == windowEndedAt)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,branchUserId,userName,type,status,observedCount,thresholdCount,windowStartedAt,windowEndedAt,detectedAt);

@override
String toString() {
  return 'IntegrityFlag(id: $id, branchUserId: $branchUserId, userName: $userName, type: $type, status: $status, observedCount: $observedCount, thresholdCount: $thresholdCount, windowStartedAt: $windowStartedAt, windowEndedAt: $windowEndedAt, detectedAt: $detectedAt)';
}


}

/// @nodoc
abstract mixin class $IntegrityFlagCopyWith<$Res>  {
  factory $IntegrityFlagCopyWith(IntegrityFlag value, $Res Function(IntegrityFlag) _then) = _$IntegrityFlagCopyWithImpl;
@useResult
$Res call({
 String id, String branchUserId, String userName, IntegrityFlagType type, IntegrityFlagStatus status, int observedCount, int thresholdCount, DateTime windowStartedAt, DateTime windowEndedAt, DateTime detectedAt
});




}
/// @nodoc
class _$IntegrityFlagCopyWithImpl<$Res>
    implements $IntegrityFlagCopyWith<$Res> {
  _$IntegrityFlagCopyWithImpl(this._self, this._then);

  final IntegrityFlag _self;
  final $Res Function(IntegrityFlag) _then;

/// Create a copy of IntegrityFlag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchUserId = null,Object? userName = null,Object? type = null,Object? status = null,Object? observedCount = null,Object? thresholdCount = null,Object? windowStartedAt = null,Object? windowEndedAt = null,Object? detectedAt = null,}) {
  return _then(IntegrityFlag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchUserId: null == branchUserId ? _self.branchUserId : branchUserId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as IntegrityFlagType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IntegrityFlagStatus,observedCount: null == observedCount ? _self.observedCount : observedCount // ignore: cast_nullable_to_non_nullable
as int,thresholdCount: null == thresholdCount ? _self.thresholdCount : thresholdCount // ignore: cast_nullable_to_non_nullable
as int,windowStartedAt: null == windowStartedAt ? _self.windowStartedAt : windowStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,windowEndedAt: null == windowEndedAt ? _self.windowEndedAt : windowEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [IntegrityFlag].
extension IntegrityFlagPatterns on IntegrityFlag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntegrityFlag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntegrityFlag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntegrityFlag value)  $default,){
final _that = this;
switch (_that) {
case _IntegrityFlag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntegrityFlag value)?  $default,){
final _that = this;
switch (_that) {
case _IntegrityFlag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String branchUserId,  String userName,  IntegrityFlagType type,  IntegrityFlagStatus status,  int observedCount,  int thresholdCount,  DateTime windowStartedAt,  DateTime windowEndedAt,  DateTime detectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntegrityFlag() when $default != null:
return $default(_that.id,_that.branchUserId,_that.userName,_that.type,_that.status,_that.observedCount,_that.thresholdCount,_that.windowStartedAt,_that.windowEndedAt,_that.detectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String branchUserId,  String userName,  IntegrityFlagType type,  IntegrityFlagStatus status,  int observedCount,  int thresholdCount,  DateTime windowStartedAt,  DateTime windowEndedAt,  DateTime detectedAt)  $default,) {final _that = this;
switch (_that) {
case _IntegrityFlag():
return $default(_that.id,_that.branchUserId,_that.userName,_that.type,_that.status,_that.observedCount,_that.thresholdCount,_that.windowStartedAt,_that.windowEndedAt,_that.detectedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String branchUserId,  String userName,  IntegrityFlagType type,  IntegrityFlagStatus status,  int observedCount,  int thresholdCount,  DateTime windowStartedAt,  DateTime windowEndedAt,  DateTime detectedAt)?  $default,) {final _that = this;
switch (_that) {
case _IntegrityFlag() when $default != null:
return $default(_that.id,_that.branchUserId,_that.userName,_that.type,_that.status,_that.observedCount,_that.thresholdCount,_that.windowStartedAt,_that.windowEndedAt,_that.detectedAt);case _:
  return null;

}
}

}

/// @nodoc


class _IntegrityFlag implements IntegrityFlag {
  const _IntegrityFlag({required this.id, required this.branchUserId, required this.userName, required this.type, required this.status, required this.observedCount, required this.thresholdCount, required this.windowStartedAt, required this.windowEndedAt, required this.detectedAt});
  

@override final  String id;
@override final  String branchUserId;
@override final  String userName;
@override final  IntegrityFlagType type;
@override final  IntegrityFlagStatus status;
@override final  int observedCount;
@override final  int thresholdCount;
@override final  DateTime windowStartedAt;
@override final  DateTime windowEndedAt;
@override final  DateTime detectedAt;

/// Create a copy of IntegrityFlag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntegrityFlagCopyWith<_IntegrityFlag> get copyWith => __$IntegrityFlagCopyWithImpl<_IntegrityFlag>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntegrityFlag&&(identical(other.id, id) || other.id == id)&&(identical(other.branchUserId, branchUserId) || other.branchUserId == branchUserId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.observedCount, observedCount) || other.observedCount == observedCount)&&(identical(other.thresholdCount, thresholdCount) || other.thresholdCount == thresholdCount)&&(identical(other.windowStartedAt, windowStartedAt) || other.windowStartedAt == windowStartedAt)&&(identical(other.windowEndedAt, windowEndedAt) || other.windowEndedAt == windowEndedAt)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,branchUserId,userName,type,status,observedCount,thresholdCount,windowStartedAt,windowEndedAt,detectedAt);

@override
String toString() {
  return 'IntegrityFlag(id: $id, branchUserId: $branchUserId, userName: $userName, type: $type, status: $status, observedCount: $observedCount, thresholdCount: $thresholdCount, windowStartedAt: $windowStartedAt, windowEndedAt: $windowEndedAt, detectedAt: $detectedAt)';
}


}

/// @nodoc
abstract mixin class _$IntegrityFlagCopyWith<$Res> implements $IntegrityFlagCopyWith<$Res> {
  factory _$IntegrityFlagCopyWith(_IntegrityFlag value, $Res Function(_IntegrityFlag) _then) = __$IntegrityFlagCopyWithImpl;
@override @useResult
$Res call({
 String id, String branchUserId, String userName, IntegrityFlagType type, IntegrityFlagStatus status, int observedCount, int thresholdCount, DateTime windowStartedAt, DateTime windowEndedAt, DateTime detectedAt
});




}
/// @nodoc
class __$IntegrityFlagCopyWithImpl<$Res>
    implements _$IntegrityFlagCopyWith<$Res> {
  __$IntegrityFlagCopyWithImpl(this._self, this._then);

  final _IntegrityFlag _self;
  final $Res Function(_IntegrityFlag) _then;

/// Create a copy of IntegrityFlag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchUserId = null,Object? userName = null,Object? type = null,Object? status = null,Object? observedCount = null,Object? thresholdCount = null,Object? windowStartedAt = null,Object? windowEndedAt = null,Object? detectedAt = null,}) {
  return _then(_IntegrityFlag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchUserId: null == branchUserId ? _self.branchUserId : branchUserId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as IntegrityFlagType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IntegrityFlagStatus,observedCount: null == observedCount ? _self.observedCount : observedCount // ignore: cast_nullable_to_non_nullable
as int,thresholdCount: null == thresholdCount ? _self.thresholdCount : thresholdCount // ignore: cast_nullable_to_non_nullable
as int,windowStartedAt: null == windowStartedAt ? _self.windowStartedAt : windowStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime,windowEndedAt: null == windowEndedAt ? _self.windowEndedAt : windowEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
