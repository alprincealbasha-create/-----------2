// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch_daily_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BranchDailyMetrics {

 int get participatingUsers; int get completedUsers; double get completionRate; int get totalRecordedDhikr; int get participatingChildren; int get participatingStaff;
/// Create a copy of BranchDailyMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchDailyMetricsCopyWith<BranchDailyMetrics> get copyWith => _$BranchDailyMetricsCopyWithImpl<BranchDailyMetrics>(this as BranchDailyMetrics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchDailyMetrics&&(identical(other.participatingUsers, participatingUsers) || other.participatingUsers == participatingUsers)&&(identical(other.completedUsers, completedUsers) || other.completedUsers == completedUsers)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.totalRecordedDhikr, totalRecordedDhikr) || other.totalRecordedDhikr == totalRecordedDhikr)&&(identical(other.participatingChildren, participatingChildren) || other.participatingChildren == participatingChildren)&&(identical(other.participatingStaff, participatingStaff) || other.participatingStaff == participatingStaff));
}


@override
int get hashCode => Object.hash(runtimeType,participatingUsers,completedUsers,completionRate,totalRecordedDhikr,participatingChildren,participatingStaff);

@override
String toString() {
  return 'BranchDailyMetrics(participatingUsers: $participatingUsers, completedUsers: $completedUsers, completionRate: $completionRate, totalRecordedDhikr: $totalRecordedDhikr, participatingChildren: $participatingChildren, participatingStaff: $participatingStaff)';
}


}

/// @nodoc
abstract mixin class $BranchDailyMetricsCopyWith<$Res>  {
  factory $BranchDailyMetricsCopyWith(BranchDailyMetrics value, $Res Function(BranchDailyMetrics) _then) = _$BranchDailyMetricsCopyWithImpl;
@useResult
$Res call({
 int participatingUsers, int completedUsers, double completionRate, int totalRecordedDhikr, int participatingChildren, int participatingStaff
});




}
/// @nodoc
class _$BranchDailyMetricsCopyWithImpl<$Res>
    implements $BranchDailyMetricsCopyWith<$Res> {
  _$BranchDailyMetricsCopyWithImpl(this._self, this._then);

  final BranchDailyMetrics _self;
  final $Res Function(BranchDailyMetrics) _then;

/// Create a copy of BranchDailyMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? participatingUsers = null,Object? completedUsers = null,Object? completionRate = null,Object? totalRecordedDhikr = null,Object? participatingChildren = null,Object? participatingStaff = null,}) {
  return _then(BranchDailyMetrics(
participatingUsers: null == participatingUsers ? _self.participatingUsers : participatingUsers // ignore: cast_nullable_to_non_nullable
as int,completedUsers: null == completedUsers ? _self.completedUsers : completedUsers // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,totalRecordedDhikr: null == totalRecordedDhikr ? _self.totalRecordedDhikr : totalRecordedDhikr // ignore: cast_nullable_to_non_nullable
as int,participatingChildren: null == participatingChildren ? _self.participatingChildren : participatingChildren // ignore: cast_nullable_to_non_nullable
as int,participatingStaff: null == participatingStaff ? _self.participatingStaff : participatingStaff // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BranchDailyMetrics].
extension BranchDailyMetricsPatterns on BranchDailyMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BranchDailyMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BranchDailyMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BranchDailyMetrics value)  $default,){
final _that = this;
switch (_that) {
case _BranchDailyMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BranchDailyMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _BranchDailyMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int participatingUsers,  int completedUsers,  double completionRate,  int totalRecordedDhikr,  int participatingChildren,  int participatingStaff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BranchDailyMetrics() when $default != null:
return $default(_that.participatingUsers,_that.completedUsers,_that.completionRate,_that.totalRecordedDhikr,_that.participatingChildren,_that.participatingStaff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int participatingUsers,  int completedUsers,  double completionRate,  int totalRecordedDhikr,  int participatingChildren,  int participatingStaff)  $default,) {final _that = this;
switch (_that) {
case _BranchDailyMetrics():
return $default(_that.participatingUsers,_that.completedUsers,_that.completionRate,_that.totalRecordedDhikr,_that.participatingChildren,_that.participatingStaff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int participatingUsers,  int completedUsers,  double completionRate,  int totalRecordedDhikr,  int participatingChildren,  int participatingStaff)?  $default,) {final _that = this;
switch (_that) {
case _BranchDailyMetrics() when $default != null:
return $default(_that.participatingUsers,_that.completedUsers,_that.completionRate,_that.totalRecordedDhikr,_that.participatingChildren,_that.participatingStaff);case _:
  return null;

}
}

}

/// @nodoc


class _BranchDailyMetrics implements BranchDailyMetrics {
  const _BranchDailyMetrics({this.participatingUsers = 0, this.completedUsers = 0, this.completionRate = 0, this.totalRecordedDhikr = 0, this.participatingChildren = 0, this.participatingStaff = 0});
  

@override@JsonKey() final  int participatingUsers;
@override@JsonKey() final  int completedUsers;
@override@JsonKey() final  double completionRate;
@override@JsonKey() final  int totalRecordedDhikr;
@override@JsonKey() final  int participatingChildren;
@override@JsonKey() final  int participatingStaff;

/// Create a copy of BranchDailyMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchDailyMetricsCopyWith<_BranchDailyMetrics> get copyWith => __$BranchDailyMetricsCopyWithImpl<_BranchDailyMetrics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchDailyMetrics&&(identical(other.participatingUsers, participatingUsers) || other.participatingUsers == participatingUsers)&&(identical(other.completedUsers, completedUsers) || other.completedUsers == completedUsers)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.totalRecordedDhikr, totalRecordedDhikr) || other.totalRecordedDhikr == totalRecordedDhikr)&&(identical(other.participatingChildren, participatingChildren) || other.participatingChildren == participatingChildren)&&(identical(other.participatingStaff, participatingStaff) || other.participatingStaff == participatingStaff));
}


@override
int get hashCode => Object.hash(runtimeType,participatingUsers,completedUsers,completionRate,totalRecordedDhikr,participatingChildren,participatingStaff);

@override
String toString() {
  return 'BranchDailyMetrics(participatingUsers: $participatingUsers, completedUsers: $completedUsers, completionRate: $completionRate, totalRecordedDhikr: $totalRecordedDhikr, participatingChildren: $participatingChildren, participatingStaff: $participatingStaff)';
}


}

/// @nodoc
abstract mixin class _$BranchDailyMetricsCopyWith<$Res> implements $BranchDailyMetricsCopyWith<$Res> {
  factory _$BranchDailyMetricsCopyWith(_BranchDailyMetrics value, $Res Function(_BranchDailyMetrics) _then) = __$BranchDailyMetricsCopyWithImpl;
@override @useResult
$Res call({
 int participatingUsers, int completedUsers, double completionRate, int totalRecordedDhikr, int participatingChildren, int participatingStaff
});




}
/// @nodoc
class __$BranchDailyMetricsCopyWithImpl<$Res>
    implements _$BranchDailyMetricsCopyWith<$Res> {
  __$BranchDailyMetricsCopyWithImpl(this._self, this._then);

  final _BranchDailyMetrics _self;
  final $Res Function(_BranchDailyMetrics) _then;

/// Create a copy of BranchDailyMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? participatingUsers = null,Object? completedUsers = null,Object? completionRate = null,Object? totalRecordedDhikr = null,Object? participatingChildren = null,Object? participatingStaff = null,}) {
  return _then(_BranchDailyMetrics(
participatingUsers: null == participatingUsers ? _self.participatingUsers : participatingUsers // ignore: cast_nullable_to_non_nullable
as int,completedUsers: null == completedUsers ? _self.completedUsers : completedUsers // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,totalRecordedDhikr: null == totalRecordedDhikr ? _self.totalRecordedDhikr : totalRecordedDhikr // ignore: cast_nullable_to_non_nullable
as int,participatingChildren: null == participatingChildren ? _self.participatingChildren : participatingChildren // ignore: cast_nullable_to_non_nullable
as int,participatingStaff: null == participatingStaff ? _self.participatingStaff : participatingStaff // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
