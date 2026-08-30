// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'managed_wird.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManagedWird {

 String get id;@JsonKey(name: 'branch_id') String get branchId;@JsonKey(name: 'assigned_user_id') String? get assignedUserId; String get title; String? get details;@JsonKey(name: 'target_count') int? get targetCount; ManagedWirdStatus get status;@JsonKey(name: 'assigned_at') DateTime? get assignedAt;@JsonKey(name: 'completed_at') DateTime? get completedAt;@JsonKey(name: 'wird_program_id') String? get wirdProgramId;@JsonKey(name: 'dhikr_definition_id') String? get dhikrDefinitionId;@JsonKey(name: 'dhikr_title_snapshot') String? get dhikrTitleSnapshot;@JsonKey(name: 'dhikr_text_snapshot') String? get dhikrTextSnapshot;@JsonKey(name: 'available_from') DateTime? get availableFrom;@JsonKey(name: 'available_until') DateTime? get availableUntil;@JsonKey(name: 'availability_timezone') String? get availabilityTimezone;
/// Create a copy of ManagedWird
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManagedWirdCopyWith<ManagedWird> get copyWith => _$ManagedWirdCopyWithImpl<ManagedWird>(this as ManagedWird, _$identity);

  /// Serializes this ManagedWird to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagedWird&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.assignedUserId, assignedUserId) || other.assignedUserId == assignedUserId)&&(identical(other.title, title) || other.title == title)&&(identical(other.details, details) || other.details == details)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.assignedAt, assignedAt) || other.assignedAt == assignedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.wirdProgramId, wirdProgramId) || other.wirdProgramId == wirdProgramId)&&(identical(other.dhikrDefinitionId, dhikrDefinitionId) || other.dhikrDefinitionId == dhikrDefinitionId)&&(identical(other.dhikrTitleSnapshot, dhikrTitleSnapshot) || other.dhikrTitleSnapshot == dhikrTitleSnapshot)&&(identical(other.dhikrTextSnapshot, dhikrTextSnapshot) || other.dhikrTextSnapshot == dhikrTextSnapshot)&&(identical(other.availableFrom, availableFrom) || other.availableFrom == availableFrom)&&(identical(other.availableUntil, availableUntil) || other.availableUntil == availableUntil)&&(identical(other.availabilityTimezone, availabilityTimezone) || other.availabilityTimezone == availabilityTimezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,assignedUserId,title,details,targetCount,status,assignedAt,completedAt,wirdProgramId,dhikrDefinitionId,dhikrTitleSnapshot,dhikrTextSnapshot,availableFrom,availableUntil,availabilityTimezone);

@override
String toString() {
  return 'ManagedWird(id: $id, branchId: $branchId, assignedUserId: $assignedUserId, title: $title, details: $details, targetCount: $targetCount, status: $status, assignedAt: $assignedAt, completedAt: $completedAt, wirdProgramId: $wirdProgramId, dhikrDefinitionId: $dhikrDefinitionId, dhikrTitleSnapshot: $dhikrTitleSnapshot, dhikrTextSnapshot: $dhikrTextSnapshot, availableFrom: $availableFrom, availableUntil: $availableUntil, availabilityTimezone: $availabilityTimezone)';
}


}

/// @nodoc
abstract mixin class $ManagedWirdCopyWith<$Res>  {
  factory $ManagedWirdCopyWith(ManagedWird value, $Res Function(ManagedWird) _then) = _$ManagedWirdCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'branch_id') String branchId,@JsonKey(name: 'assigned_user_id') String? assignedUserId, String title, String? details,@JsonKey(name: 'target_count') int? targetCount, ManagedWirdStatus status,@JsonKey(name: 'assigned_at') DateTime? assignedAt,@JsonKey(name: 'completed_at') DateTime? completedAt,@JsonKey(name: 'wird_program_id') String? wirdProgramId,@JsonKey(name: 'dhikr_definition_id') String? dhikrDefinitionId,@JsonKey(name: 'dhikr_title_snapshot') String? dhikrTitleSnapshot,@JsonKey(name: 'dhikr_text_snapshot') String? dhikrTextSnapshot,@JsonKey(name: 'available_from') DateTime? availableFrom,@JsonKey(name: 'available_until') DateTime? availableUntil,@JsonKey(name: 'availability_timezone') String? availabilityTimezone
});




}
/// @nodoc
class _$ManagedWirdCopyWithImpl<$Res>
    implements $ManagedWirdCopyWith<$Res> {
  _$ManagedWirdCopyWithImpl(this._self, this._then);

  final ManagedWird _self;
  final $Res Function(ManagedWird) _then;

/// Create a copy of ManagedWird
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = null,Object? assignedUserId = freezed,Object? title = null,Object? details = freezed,Object? targetCount = freezed,Object? status = null,Object? assignedAt = freezed,Object? completedAt = freezed,Object? wirdProgramId = freezed,Object? dhikrDefinitionId = freezed,Object? dhikrTitleSnapshot = freezed,Object? dhikrTextSnapshot = freezed,Object? availableFrom = freezed,Object? availableUntil = freezed,Object? availabilityTimezone = freezed,}) {
  return _then(ManagedWird(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,assignedUserId: freezed == assignedUserId ? _self.assignedUserId : assignedUserId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,targetCount: freezed == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ManagedWirdStatus,assignedAt: freezed == assignedAt ? _self.assignedAt : assignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,wirdProgramId: freezed == wirdProgramId ? _self.wirdProgramId : wirdProgramId // ignore: cast_nullable_to_non_nullable
as String?,dhikrDefinitionId: freezed == dhikrDefinitionId ? _self.dhikrDefinitionId : dhikrDefinitionId // ignore: cast_nullable_to_non_nullable
as String?,dhikrTitleSnapshot: freezed == dhikrTitleSnapshot ? _self.dhikrTitleSnapshot : dhikrTitleSnapshot // ignore: cast_nullable_to_non_nullable
as String?,dhikrTextSnapshot: freezed == dhikrTextSnapshot ? _self.dhikrTextSnapshot : dhikrTextSnapshot // ignore: cast_nullable_to_non_nullable
as String?,availableFrom: freezed == availableFrom ? _self.availableFrom : availableFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,availableUntil: freezed == availableUntil ? _self.availableUntil : availableUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,availabilityTimezone: freezed == availabilityTimezone ? _self.availabilityTimezone : availabilityTimezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ManagedWird].
extension ManagedWirdPatterns on ManagedWird {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManagedWird value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManagedWird() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManagedWird value)  $default,){
final _that = this;
switch (_that) {
case _ManagedWird():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManagedWird value)?  $default,){
final _that = this;
switch (_that) {
case _ManagedWird() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'branch_id')  String branchId, @JsonKey(name: 'assigned_user_id')  String? assignedUserId,  String title,  String? details, @JsonKey(name: 'target_count')  int? targetCount,  ManagedWirdStatus status, @JsonKey(name: 'assigned_at')  DateTime? assignedAt, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'wird_program_id')  String? wirdProgramId, @JsonKey(name: 'dhikr_definition_id')  String? dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot')  String? dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot')  String? dhikrTextSnapshot, @JsonKey(name: 'available_from')  DateTime? availableFrom, @JsonKey(name: 'available_until')  DateTime? availableUntil, @JsonKey(name: 'availability_timezone')  String? availabilityTimezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManagedWird() when $default != null:
return $default(_that.id,_that.branchId,_that.assignedUserId,_that.title,_that.details,_that.targetCount,_that.status,_that.assignedAt,_that.completedAt,_that.wirdProgramId,_that.dhikrDefinitionId,_that.dhikrTitleSnapshot,_that.dhikrTextSnapshot,_that.availableFrom,_that.availableUntil,_that.availabilityTimezone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'branch_id')  String branchId, @JsonKey(name: 'assigned_user_id')  String? assignedUserId,  String title,  String? details, @JsonKey(name: 'target_count')  int? targetCount,  ManagedWirdStatus status, @JsonKey(name: 'assigned_at')  DateTime? assignedAt, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'wird_program_id')  String? wirdProgramId, @JsonKey(name: 'dhikr_definition_id')  String? dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot')  String? dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot')  String? dhikrTextSnapshot, @JsonKey(name: 'available_from')  DateTime? availableFrom, @JsonKey(name: 'available_until')  DateTime? availableUntil, @JsonKey(name: 'availability_timezone')  String? availabilityTimezone)  $default,) {final _that = this;
switch (_that) {
case _ManagedWird():
return $default(_that.id,_that.branchId,_that.assignedUserId,_that.title,_that.details,_that.targetCount,_that.status,_that.assignedAt,_that.completedAt,_that.wirdProgramId,_that.dhikrDefinitionId,_that.dhikrTitleSnapshot,_that.dhikrTextSnapshot,_that.availableFrom,_that.availableUntil,_that.availabilityTimezone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'branch_id')  String branchId, @JsonKey(name: 'assigned_user_id')  String? assignedUserId,  String title,  String? details, @JsonKey(name: 'target_count')  int? targetCount,  ManagedWirdStatus status, @JsonKey(name: 'assigned_at')  DateTime? assignedAt, @JsonKey(name: 'completed_at')  DateTime? completedAt, @JsonKey(name: 'wird_program_id')  String? wirdProgramId, @JsonKey(name: 'dhikr_definition_id')  String? dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot')  String? dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot')  String? dhikrTextSnapshot, @JsonKey(name: 'available_from')  DateTime? availableFrom, @JsonKey(name: 'available_until')  DateTime? availableUntil, @JsonKey(name: 'availability_timezone')  String? availabilityTimezone)?  $default,) {final _that = this;
switch (_that) {
case _ManagedWird() when $default != null:
return $default(_that.id,_that.branchId,_that.assignedUserId,_that.title,_that.details,_that.targetCount,_that.status,_that.assignedAt,_that.completedAt,_that.wirdProgramId,_that.dhikrDefinitionId,_that.dhikrTitleSnapshot,_that.dhikrTextSnapshot,_that.availableFrom,_that.availableUntil,_that.availabilityTimezone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ManagedWird implements ManagedWird {
  const _ManagedWird({required this.id, @JsonKey(name: 'branch_id') required this.branchId, @JsonKey(name: 'assigned_user_id') this.assignedUserId, required this.title, this.details, @JsonKey(name: 'target_count') this.targetCount, required this.status, @JsonKey(name: 'assigned_at') this.assignedAt, @JsonKey(name: 'completed_at') this.completedAt, @JsonKey(name: 'wird_program_id') this.wirdProgramId, @JsonKey(name: 'dhikr_definition_id') this.dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot') this.dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot') this.dhikrTextSnapshot, @JsonKey(name: 'available_from') this.availableFrom, @JsonKey(name: 'available_until') this.availableUntil, @JsonKey(name: 'availability_timezone') this.availabilityTimezone});
  factory _ManagedWird.fromJson(Map<String, dynamic> json) => _$ManagedWirdFromJson(json);

@override final  String id;
@override@JsonKey(name: 'branch_id') final  String branchId;
@override@JsonKey(name: 'assigned_user_id') final  String? assignedUserId;
@override final  String title;
@override final  String? details;
@override@JsonKey(name: 'target_count') final  int? targetCount;
@override final  ManagedWirdStatus status;
@override@JsonKey(name: 'assigned_at') final  DateTime? assignedAt;
@override@JsonKey(name: 'completed_at') final  DateTime? completedAt;
@override@JsonKey(name: 'wird_program_id') final  String? wirdProgramId;
@override@JsonKey(name: 'dhikr_definition_id') final  String? dhikrDefinitionId;
@override@JsonKey(name: 'dhikr_title_snapshot') final  String? dhikrTitleSnapshot;
@override@JsonKey(name: 'dhikr_text_snapshot') final  String? dhikrTextSnapshot;
@override@JsonKey(name: 'available_from') final  DateTime? availableFrom;
@override@JsonKey(name: 'available_until') final  DateTime? availableUntil;
@override@JsonKey(name: 'availability_timezone') final  String? availabilityTimezone;

/// Create a copy of ManagedWird
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManagedWirdCopyWith<_ManagedWird> get copyWith => __$ManagedWirdCopyWithImpl<_ManagedWird>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManagedWirdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManagedWird&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.assignedUserId, assignedUserId) || other.assignedUserId == assignedUserId)&&(identical(other.title, title) || other.title == title)&&(identical(other.details, details) || other.details == details)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.assignedAt, assignedAt) || other.assignedAt == assignedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.wirdProgramId, wirdProgramId) || other.wirdProgramId == wirdProgramId)&&(identical(other.dhikrDefinitionId, dhikrDefinitionId) || other.dhikrDefinitionId == dhikrDefinitionId)&&(identical(other.dhikrTitleSnapshot, dhikrTitleSnapshot) || other.dhikrTitleSnapshot == dhikrTitleSnapshot)&&(identical(other.dhikrTextSnapshot, dhikrTextSnapshot) || other.dhikrTextSnapshot == dhikrTextSnapshot)&&(identical(other.availableFrom, availableFrom) || other.availableFrom == availableFrom)&&(identical(other.availableUntil, availableUntil) || other.availableUntil == availableUntil)&&(identical(other.availabilityTimezone, availabilityTimezone) || other.availabilityTimezone == availabilityTimezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,assignedUserId,title,details,targetCount,status,assignedAt,completedAt,wirdProgramId,dhikrDefinitionId,dhikrTitleSnapshot,dhikrTextSnapshot,availableFrom,availableUntil,availabilityTimezone);

@override
String toString() {
  return 'ManagedWird(id: $id, branchId: $branchId, assignedUserId: $assignedUserId, title: $title, details: $details, targetCount: $targetCount, status: $status, assignedAt: $assignedAt, completedAt: $completedAt, wirdProgramId: $wirdProgramId, dhikrDefinitionId: $dhikrDefinitionId, dhikrTitleSnapshot: $dhikrTitleSnapshot, dhikrTextSnapshot: $dhikrTextSnapshot, availableFrom: $availableFrom, availableUntil: $availableUntil, availabilityTimezone: $availabilityTimezone)';
}


}

/// @nodoc
abstract mixin class _$ManagedWirdCopyWith<$Res> implements $ManagedWirdCopyWith<$Res> {
  factory _$ManagedWirdCopyWith(_ManagedWird value, $Res Function(_ManagedWird) _then) = __$ManagedWirdCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'branch_id') String branchId,@JsonKey(name: 'assigned_user_id') String? assignedUserId, String title, String? details,@JsonKey(name: 'target_count') int? targetCount, ManagedWirdStatus status,@JsonKey(name: 'assigned_at') DateTime? assignedAt,@JsonKey(name: 'completed_at') DateTime? completedAt,@JsonKey(name: 'wird_program_id') String? wirdProgramId,@JsonKey(name: 'dhikr_definition_id') String? dhikrDefinitionId,@JsonKey(name: 'dhikr_title_snapshot') String? dhikrTitleSnapshot,@JsonKey(name: 'dhikr_text_snapshot') String? dhikrTextSnapshot,@JsonKey(name: 'available_from') DateTime? availableFrom,@JsonKey(name: 'available_until') DateTime? availableUntil,@JsonKey(name: 'availability_timezone') String? availabilityTimezone
});




}
/// @nodoc
class __$ManagedWirdCopyWithImpl<$Res>
    implements _$ManagedWirdCopyWith<$Res> {
  __$ManagedWirdCopyWithImpl(this._self, this._then);

  final _ManagedWird _self;
  final $Res Function(_ManagedWird) _then;

/// Create a copy of ManagedWird
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = null,Object? assignedUserId = freezed,Object? title = null,Object? details = freezed,Object? targetCount = freezed,Object? status = null,Object? assignedAt = freezed,Object? completedAt = freezed,Object? wirdProgramId = freezed,Object? dhikrDefinitionId = freezed,Object? dhikrTitleSnapshot = freezed,Object? dhikrTextSnapshot = freezed,Object? availableFrom = freezed,Object? availableUntil = freezed,Object? availabilityTimezone = freezed,}) {
  return _then(_ManagedWird(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,assignedUserId: freezed == assignedUserId ? _self.assignedUserId : assignedUserId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,targetCount: freezed == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ManagedWirdStatus,assignedAt: freezed == assignedAt ? _self.assignedAt : assignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,wirdProgramId: freezed == wirdProgramId ? _self.wirdProgramId : wirdProgramId // ignore: cast_nullable_to_non_nullable
as String?,dhikrDefinitionId: freezed == dhikrDefinitionId ? _self.dhikrDefinitionId : dhikrDefinitionId // ignore: cast_nullable_to_non_nullable
as String?,dhikrTitleSnapshot: freezed == dhikrTitleSnapshot ? _self.dhikrTitleSnapshot : dhikrTitleSnapshot // ignore: cast_nullable_to_non_nullable
as String?,dhikrTextSnapshot: freezed == dhikrTextSnapshot ? _self.dhikrTextSnapshot : dhikrTextSnapshot // ignore: cast_nullable_to_non_nullable
as String?,availableFrom: freezed == availableFrom ? _self.availableFrom : availableFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,availableUntil: freezed == availableUntil ? _self.availableUntil : availableUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,availabilityTimezone: freezed == availabilityTimezone ? _self.availabilityTimezone : availabilityTimezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
