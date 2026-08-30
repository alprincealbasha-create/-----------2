// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'central_branch_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CentralBranchMetrics {

 String get branchId; String get branchName; String? get branchCity; int get eligibleUsers; int get participatingUsers; int get completedUsers; double get participationRate; double get completionRate; int get totalRecordedDhikr;
/// Create a copy of CentralBranchMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CentralBranchMetricsCopyWith<CentralBranchMetrics> get copyWith => _$CentralBranchMetricsCopyWithImpl<CentralBranchMetrics>(this as CentralBranchMetrics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CentralBranchMetrics&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.branchCity, branchCity) || other.branchCity == branchCity)&&(identical(other.eligibleUsers, eligibleUsers) || other.eligibleUsers == eligibleUsers)&&(identical(other.participatingUsers, participatingUsers) || other.participatingUsers == participatingUsers)&&(identical(other.completedUsers, completedUsers) || other.completedUsers == completedUsers)&&(identical(other.participationRate, participationRate) || other.participationRate == participationRate)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.totalRecordedDhikr, totalRecordedDhikr) || other.totalRecordedDhikr == totalRecordedDhikr));
}


@override
int get hashCode => Object.hash(runtimeType,branchId,branchName,branchCity,eligibleUsers,participatingUsers,completedUsers,participationRate,completionRate,totalRecordedDhikr);

@override
String toString() {
  return 'CentralBranchMetrics(branchId: $branchId, branchName: $branchName, branchCity: $branchCity, eligibleUsers: $eligibleUsers, participatingUsers: $participatingUsers, completedUsers: $completedUsers, participationRate: $participationRate, completionRate: $completionRate, totalRecordedDhikr: $totalRecordedDhikr)';
}


}

/// @nodoc
abstract mixin class $CentralBranchMetricsCopyWith<$Res>  {
  factory $CentralBranchMetricsCopyWith(CentralBranchMetrics value, $Res Function(CentralBranchMetrics) _then) = _$CentralBranchMetricsCopyWithImpl;
@useResult
$Res call({
 String branchId, String branchName, String? branchCity, int eligibleUsers, int participatingUsers, int completedUsers, double participationRate, double completionRate, int totalRecordedDhikr
});




}
/// @nodoc
class _$CentralBranchMetricsCopyWithImpl<$Res>
    implements $CentralBranchMetricsCopyWith<$Res> {
  _$CentralBranchMetricsCopyWithImpl(this._self, this._then);

  final CentralBranchMetrics _self;
  final $Res Function(CentralBranchMetrics) _then;

/// Create a copy of CentralBranchMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branchId = null,Object? branchName = null,Object? branchCity = freezed,Object? eligibleUsers = null,Object? participatingUsers = null,Object? completedUsers = null,Object? participationRate = null,Object? completionRate = null,Object? totalRecordedDhikr = null,}) {
  return _then(CentralBranchMetrics(
branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,branchCity: freezed == branchCity ? _self.branchCity : branchCity // ignore: cast_nullable_to_non_nullable
as String?,eligibleUsers: null == eligibleUsers ? _self.eligibleUsers : eligibleUsers // ignore: cast_nullable_to_non_nullable
as int,participatingUsers: null == participatingUsers ? _self.participatingUsers : participatingUsers // ignore: cast_nullable_to_non_nullable
as int,completedUsers: null == completedUsers ? _self.completedUsers : completedUsers // ignore: cast_nullable_to_non_nullable
as int,participationRate: null == participationRate ? _self.participationRate : participationRate // ignore: cast_nullable_to_non_nullable
as double,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,totalRecordedDhikr: null == totalRecordedDhikr ? _self.totalRecordedDhikr : totalRecordedDhikr // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CentralBranchMetrics].
extension CentralBranchMetricsPatterns on CentralBranchMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CentralBranchMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CentralBranchMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CentralBranchMetrics value)  $default,){
final _that = this;
switch (_that) {
case _CentralBranchMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CentralBranchMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _CentralBranchMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String branchId,  String branchName,  String? branchCity,  int eligibleUsers,  int participatingUsers,  int completedUsers,  double participationRate,  double completionRate,  int totalRecordedDhikr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CentralBranchMetrics() when $default != null:
return $default(_that.branchId,_that.branchName,_that.branchCity,_that.eligibleUsers,_that.participatingUsers,_that.completedUsers,_that.participationRate,_that.completionRate,_that.totalRecordedDhikr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String branchId,  String branchName,  String? branchCity,  int eligibleUsers,  int participatingUsers,  int completedUsers,  double participationRate,  double completionRate,  int totalRecordedDhikr)  $default,) {final _that = this;
switch (_that) {
case _CentralBranchMetrics():
return $default(_that.branchId,_that.branchName,_that.branchCity,_that.eligibleUsers,_that.participatingUsers,_that.completedUsers,_that.participationRate,_that.completionRate,_that.totalRecordedDhikr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String branchId,  String branchName,  String? branchCity,  int eligibleUsers,  int participatingUsers,  int completedUsers,  double participationRate,  double completionRate,  int totalRecordedDhikr)?  $default,) {final _that = this;
switch (_that) {
case _CentralBranchMetrics() when $default != null:
return $default(_that.branchId,_that.branchName,_that.branchCity,_that.eligibleUsers,_that.participatingUsers,_that.completedUsers,_that.participationRate,_that.completionRate,_that.totalRecordedDhikr);case _:
  return null;

}
}

}

/// @nodoc


class _CentralBranchMetrics implements CentralBranchMetrics {
  const _CentralBranchMetrics({required this.branchId, required this.branchName, this.branchCity, this.eligibleUsers = 0, this.participatingUsers = 0, this.completedUsers = 0, this.participationRate = 0, this.completionRate = 0, this.totalRecordedDhikr = 0});
  

@override final  String branchId;
@override final  String branchName;
@override final  String? branchCity;
@override@JsonKey() final  int eligibleUsers;
@override@JsonKey() final  int participatingUsers;
@override@JsonKey() final  int completedUsers;
@override@JsonKey() final  double participationRate;
@override@JsonKey() final  double completionRate;
@override@JsonKey() final  int totalRecordedDhikr;

/// Create a copy of CentralBranchMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CentralBranchMetricsCopyWith<_CentralBranchMetrics> get copyWith => __$CentralBranchMetricsCopyWithImpl<_CentralBranchMetrics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CentralBranchMetrics&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.branchCity, branchCity) || other.branchCity == branchCity)&&(identical(other.eligibleUsers, eligibleUsers) || other.eligibleUsers == eligibleUsers)&&(identical(other.participatingUsers, participatingUsers) || other.participatingUsers == participatingUsers)&&(identical(other.completedUsers, completedUsers) || other.completedUsers == completedUsers)&&(identical(other.participationRate, participationRate) || other.participationRate == participationRate)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.totalRecordedDhikr, totalRecordedDhikr) || other.totalRecordedDhikr == totalRecordedDhikr));
}


@override
int get hashCode => Object.hash(runtimeType,branchId,branchName,branchCity,eligibleUsers,participatingUsers,completedUsers,participationRate,completionRate,totalRecordedDhikr);

@override
String toString() {
  return 'CentralBranchMetrics(branchId: $branchId, branchName: $branchName, branchCity: $branchCity, eligibleUsers: $eligibleUsers, participatingUsers: $participatingUsers, completedUsers: $completedUsers, participationRate: $participationRate, completionRate: $completionRate, totalRecordedDhikr: $totalRecordedDhikr)';
}


}

/// @nodoc
abstract mixin class _$CentralBranchMetricsCopyWith<$Res> implements $CentralBranchMetricsCopyWith<$Res> {
  factory _$CentralBranchMetricsCopyWith(_CentralBranchMetrics value, $Res Function(_CentralBranchMetrics) _then) = __$CentralBranchMetricsCopyWithImpl;
@override @useResult
$Res call({
 String branchId, String branchName, String? branchCity, int eligibleUsers, int participatingUsers, int completedUsers, double participationRate, double completionRate, int totalRecordedDhikr
});




}
/// @nodoc
class __$CentralBranchMetricsCopyWithImpl<$Res>
    implements _$CentralBranchMetricsCopyWith<$Res> {
  __$CentralBranchMetricsCopyWithImpl(this._self, this._then);

  final _CentralBranchMetrics _self;
  final $Res Function(_CentralBranchMetrics) _then;

/// Create a copy of CentralBranchMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branchId = null,Object? branchName = null,Object? branchCity = freezed,Object? eligibleUsers = null,Object? participatingUsers = null,Object? completedUsers = null,Object? participationRate = null,Object? completionRate = null,Object? totalRecordedDhikr = null,}) {
  return _then(_CentralBranchMetrics(
branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,branchCity: freezed == branchCity ? _self.branchCity : branchCity // ignore: cast_nullable_to_non_nullable
as String?,eligibleUsers: null == eligibleUsers ? _self.eligibleUsers : eligibleUsers // ignore: cast_nullable_to_non_nullable
as int,participatingUsers: null == participatingUsers ? _self.participatingUsers : participatingUsers // ignore: cast_nullable_to_non_nullable
as int,completedUsers: null == completedUsers ? _self.completedUsers : completedUsers // ignore: cast_nullable_to_non_nullable
as int,participationRate: null == participationRate ? _self.participationRate : participationRate // ignore: cast_nullable_to_non_nullable
as double,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,totalRecordedDhikr: null == totalRecordedDhikr ? _self.totalRecordedDhikr : totalRecordedDhikr // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
