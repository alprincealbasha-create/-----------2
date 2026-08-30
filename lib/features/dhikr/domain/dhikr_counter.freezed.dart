// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dhikr_counter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DhikrCounter {

 String get id; String? get managedWirdId; String get title; int get target; int get count; DhikrCompletionState get completionState; int get pendingSyncCount; DhikrSyncState get syncState; DateTime? get completedAt;
/// Create a copy of DhikrCounter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DhikrCounterCopyWith<DhikrCounter> get copyWith => _$DhikrCounterCopyWithImpl<DhikrCounter>(this as DhikrCounter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DhikrCounter&&(identical(other.id, id) || other.id == id)&&(identical(other.managedWirdId, managedWirdId) || other.managedWirdId == managedWirdId)&&(identical(other.title, title) || other.title == title)&&(identical(other.target, target) || other.target == target)&&(identical(other.count, count) || other.count == count)&&(identical(other.completionState, completionState) || other.completionState == completionState)&&(identical(other.pendingSyncCount, pendingSyncCount) || other.pendingSyncCount == pendingSyncCount)&&(identical(other.syncState, syncState) || other.syncState == syncState)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,managedWirdId,title,target,count,completionState,pendingSyncCount,syncState,completedAt);

@override
String toString() {
  return 'DhikrCounter(id: $id, managedWirdId: $managedWirdId, title: $title, target: $target, count: $count, completionState: $completionState, pendingSyncCount: $pendingSyncCount, syncState: $syncState, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $DhikrCounterCopyWith<$Res>  {
  factory $DhikrCounterCopyWith(DhikrCounter value, $Res Function(DhikrCounter) _then) = _$DhikrCounterCopyWithImpl;
@useResult
$Res call({
 String id, String? managedWirdId, String title, int target, int count, DhikrCompletionState completionState, int pendingSyncCount, DhikrSyncState syncState, DateTime? completedAt
});




}
/// @nodoc
class _$DhikrCounterCopyWithImpl<$Res>
    implements $DhikrCounterCopyWith<$Res> {
  _$DhikrCounterCopyWithImpl(this._self, this._then);

  final DhikrCounter _self;
  final $Res Function(DhikrCounter) _then;

/// Create a copy of DhikrCounter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? managedWirdId = freezed,Object? title = null,Object? target = null,Object? count = null,Object? completionState = null,Object? pendingSyncCount = null,Object? syncState = null,Object? completedAt = freezed,}) {
  return _then(DhikrCounter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,managedWirdId: freezed == managedWirdId ? _self.managedWirdId : managedWirdId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,completionState: null == completionState ? _self.completionState : completionState // ignore: cast_nullable_to_non_nullable
as DhikrCompletionState,pendingSyncCount: null == pendingSyncCount ? _self.pendingSyncCount : pendingSyncCount // ignore: cast_nullable_to_non_nullable
as int,syncState: null == syncState ? _self.syncState : syncState // ignore: cast_nullable_to_non_nullable
as DhikrSyncState,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DhikrCounter].
extension DhikrCounterPatterns on DhikrCounter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DhikrCounter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DhikrCounter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DhikrCounter value)  $default,){
final _that = this;
switch (_that) {
case _DhikrCounter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DhikrCounter value)?  $default,){
final _that = this;
switch (_that) {
case _DhikrCounter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? managedWirdId,  String title,  int target,  int count,  DhikrCompletionState completionState,  int pendingSyncCount,  DhikrSyncState syncState,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DhikrCounter() when $default != null:
return $default(_that.id,_that.managedWirdId,_that.title,_that.target,_that.count,_that.completionState,_that.pendingSyncCount,_that.syncState,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? managedWirdId,  String title,  int target,  int count,  DhikrCompletionState completionState,  int pendingSyncCount,  DhikrSyncState syncState,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _DhikrCounter():
return $default(_that.id,_that.managedWirdId,_that.title,_that.target,_that.count,_that.completionState,_that.pendingSyncCount,_that.syncState,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? managedWirdId,  String title,  int target,  int count,  DhikrCompletionState completionState,  int pendingSyncCount,  DhikrSyncState syncState,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _DhikrCounter() when $default != null:
return $default(_that.id,_that.managedWirdId,_that.title,_that.target,_that.count,_that.completionState,_that.pendingSyncCount,_that.syncState,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _DhikrCounter extends DhikrCounter {
  const _DhikrCounter({required this.id, this.managedWirdId, required this.title, required this.target, required this.count, required this.completionState, required this.pendingSyncCount, required this.syncState, this.completedAt}): super._();
  

@override final  String id;
@override final  String? managedWirdId;
@override final  String title;
@override final  int target;
@override final  int count;
@override final  DhikrCompletionState completionState;
@override final  int pendingSyncCount;
@override final  DhikrSyncState syncState;
@override final  DateTime? completedAt;

/// Create a copy of DhikrCounter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DhikrCounterCopyWith<_DhikrCounter> get copyWith => __$DhikrCounterCopyWithImpl<_DhikrCounter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DhikrCounter&&(identical(other.id, id) || other.id == id)&&(identical(other.managedWirdId, managedWirdId) || other.managedWirdId == managedWirdId)&&(identical(other.title, title) || other.title == title)&&(identical(other.target, target) || other.target == target)&&(identical(other.count, count) || other.count == count)&&(identical(other.completionState, completionState) || other.completionState == completionState)&&(identical(other.pendingSyncCount, pendingSyncCount) || other.pendingSyncCount == pendingSyncCount)&&(identical(other.syncState, syncState) || other.syncState == syncState)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,managedWirdId,title,target,count,completionState,pendingSyncCount,syncState,completedAt);

@override
String toString() {
  return 'DhikrCounter(id: $id, managedWirdId: $managedWirdId, title: $title, target: $target, count: $count, completionState: $completionState, pendingSyncCount: $pendingSyncCount, syncState: $syncState, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$DhikrCounterCopyWith<$Res> implements $DhikrCounterCopyWith<$Res> {
  factory _$DhikrCounterCopyWith(_DhikrCounter value, $Res Function(_DhikrCounter) _then) = __$DhikrCounterCopyWithImpl;
@override @useResult
$Res call({
 String id, String? managedWirdId, String title, int target, int count, DhikrCompletionState completionState, int pendingSyncCount, DhikrSyncState syncState, DateTime? completedAt
});




}
/// @nodoc
class __$DhikrCounterCopyWithImpl<$Res>
    implements _$DhikrCounterCopyWith<$Res> {
  __$DhikrCounterCopyWithImpl(this._self, this._then);

  final _DhikrCounter _self;
  final $Res Function(_DhikrCounter) _then;

/// Create a copy of DhikrCounter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? managedWirdId = freezed,Object? title = null,Object? target = null,Object? count = null,Object? completionState = null,Object? pendingSyncCount = null,Object? syncState = null,Object? completedAt = freezed,}) {
  return _then(_DhikrCounter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,managedWirdId: freezed == managedWirdId ? _self.managedWirdId : managedWirdId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,completionState: null == completionState ? _self.completionState : completionState // ignore: cast_nullable_to_non_nullable
as DhikrCompletionState,pendingSyncCount: null == pendingSyncCount ? _self.pendingSyncCount : pendingSyncCount // ignore: cast_nullable_to_non_nullable
as int,syncState: null == syncState ? _self.syncState : syncState // ignore: cast_nullable_to_non_nullable
as DhikrSyncState,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
