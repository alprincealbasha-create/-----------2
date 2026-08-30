// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wird_program_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WirdProgram {

 String get id;@JsonKey(name: 'organization_id') String get organizationId; String get name;@JsonKey(name: 'dhikr_definition_id') String get dhikrDefinitionId;@JsonKey(name: 'dhikr_title_snapshot') String get dhikrTitleSnapshot;@JsonKey(name: 'dhikr_text_snapshot') String get dhikrTextSnapshot;@JsonKey(name: 'target_count') int get targetCount;@JsonKey(name: 'starts_on') DateTime get startsOn;@JsonKey(name: 'ends_on') DateTime get endsOn;@JsonKey(name: 'audience_name') String get audienceName;@JsonKey(name: 'scope_type') WirdAssignmentScope get scopeType;
/// Create a copy of WirdProgram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WirdProgramCopyWith<WirdProgram> get copyWith => _$WirdProgramCopyWithImpl<WirdProgram>(this as WirdProgram, _$identity);

  /// Serializes this WirdProgram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WirdProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.name, name) || other.name == name)&&(identical(other.dhikrDefinitionId, dhikrDefinitionId) || other.dhikrDefinitionId == dhikrDefinitionId)&&(identical(other.dhikrTitleSnapshot, dhikrTitleSnapshot) || other.dhikrTitleSnapshot == dhikrTitleSnapshot)&&(identical(other.dhikrTextSnapshot, dhikrTextSnapshot) || other.dhikrTextSnapshot == dhikrTextSnapshot)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.audienceName, audienceName) || other.audienceName == audienceName)&&(identical(other.scopeType, scopeType) || other.scopeType == scopeType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,organizationId,name,dhikrDefinitionId,dhikrTitleSnapshot,dhikrTextSnapshot,targetCount,startsOn,endsOn,audienceName,scopeType);

@override
String toString() {
  return 'WirdProgram(id: $id, organizationId: $organizationId, name: $name, dhikrDefinitionId: $dhikrDefinitionId, dhikrTitleSnapshot: $dhikrTitleSnapshot, dhikrTextSnapshot: $dhikrTextSnapshot, targetCount: $targetCount, startsOn: $startsOn, endsOn: $endsOn, audienceName: $audienceName, scopeType: $scopeType)';
}


}

/// @nodoc
abstract mixin class $WirdProgramCopyWith<$Res>  {
  factory $WirdProgramCopyWith(WirdProgram value, $Res Function(WirdProgram) _then) = _$WirdProgramCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'organization_id') String organizationId, String name,@JsonKey(name: 'dhikr_definition_id') String dhikrDefinitionId,@JsonKey(name: 'dhikr_title_snapshot') String dhikrTitleSnapshot,@JsonKey(name: 'dhikr_text_snapshot') String dhikrTextSnapshot,@JsonKey(name: 'target_count') int targetCount,@JsonKey(name: 'starts_on') DateTime startsOn,@JsonKey(name: 'ends_on') DateTime endsOn,@JsonKey(name: 'audience_name') String audienceName,@JsonKey(name: 'scope_type') WirdAssignmentScope scopeType
});




}
/// @nodoc
class _$WirdProgramCopyWithImpl<$Res>
    implements $WirdProgramCopyWith<$Res> {
  _$WirdProgramCopyWithImpl(this._self, this._then);

  final WirdProgram _self;
  final $Res Function(WirdProgram) _then;

/// Create a copy of WirdProgram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? organizationId = null,Object? name = null,Object? dhikrDefinitionId = null,Object? dhikrTitleSnapshot = null,Object? dhikrTextSnapshot = null,Object? targetCount = null,Object? startsOn = null,Object? endsOn = null,Object? audienceName = null,Object? scopeType = null,}) {
  return _then(WirdProgram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dhikrDefinitionId: null == dhikrDefinitionId ? _self.dhikrDefinitionId : dhikrDefinitionId // ignore: cast_nullable_to_non_nullable
as String,dhikrTitleSnapshot: null == dhikrTitleSnapshot ? _self.dhikrTitleSnapshot : dhikrTitleSnapshot // ignore: cast_nullable_to_non_nullable
as String,dhikrTextSnapshot: null == dhikrTextSnapshot ? _self.dhikrTextSnapshot : dhikrTextSnapshot // ignore: cast_nullable_to_non_nullable
as String,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,audienceName: null == audienceName ? _self.audienceName : audienceName // ignore: cast_nullable_to_non_nullable
as String,scopeType: null == scopeType ? _self.scopeType : scopeType // ignore: cast_nullable_to_non_nullable
as WirdAssignmentScope,
  ));
}

}


/// Adds pattern-matching-related methods to [WirdProgram].
extension WirdProgramPatterns on WirdProgram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WirdProgram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WirdProgram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WirdProgram value)  $default,){
final _that = this;
switch (_that) {
case _WirdProgram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WirdProgram value)?  $default,){
final _that = this;
switch (_that) {
case _WirdProgram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'organization_id')  String organizationId,  String name, @JsonKey(name: 'dhikr_definition_id')  String dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot')  String dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot')  String dhikrTextSnapshot, @JsonKey(name: 'target_count')  int targetCount, @JsonKey(name: 'starts_on')  DateTime startsOn, @JsonKey(name: 'ends_on')  DateTime endsOn, @JsonKey(name: 'audience_name')  String audienceName, @JsonKey(name: 'scope_type')  WirdAssignmentScope scopeType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WirdProgram() when $default != null:
return $default(_that.id,_that.organizationId,_that.name,_that.dhikrDefinitionId,_that.dhikrTitleSnapshot,_that.dhikrTextSnapshot,_that.targetCount,_that.startsOn,_that.endsOn,_that.audienceName,_that.scopeType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'organization_id')  String organizationId,  String name, @JsonKey(name: 'dhikr_definition_id')  String dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot')  String dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot')  String dhikrTextSnapshot, @JsonKey(name: 'target_count')  int targetCount, @JsonKey(name: 'starts_on')  DateTime startsOn, @JsonKey(name: 'ends_on')  DateTime endsOn, @JsonKey(name: 'audience_name')  String audienceName, @JsonKey(name: 'scope_type')  WirdAssignmentScope scopeType)  $default,) {final _that = this;
switch (_that) {
case _WirdProgram():
return $default(_that.id,_that.organizationId,_that.name,_that.dhikrDefinitionId,_that.dhikrTitleSnapshot,_that.dhikrTextSnapshot,_that.targetCount,_that.startsOn,_that.endsOn,_that.audienceName,_that.scopeType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'organization_id')  String organizationId,  String name, @JsonKey(name: 'dhikr_definition_id')  String dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot')  String dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot')  String dhikrTextSnapshot, @JsonKey(name: 'target_count')  int targetCount, @JsonKey(name: 'starts_on')  DateTime startsOn, @JsonKey(name: 'ends_on')  DateTime endsOn, @JsonKey(name: 'audience_name')  String audienceName, @JsonKey(name: 'scope_type')  WirdAssignmentScope scopeType)?  $default,) {final _that = this;
switch (_that) {
case _WirdProgram() when $default != null:
return $default(_that.id,_that.organizationId,_that.name,_that.dhikrDefinitionId,_that.dhikrTitleSnapshot,_that.dhikrTextSnapshot,_that.targetCount,_that.startsOn,_that.endsOn,_that.audienceName,_that.scopeType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WirdProgram implements WirdProgram {
  const _WirdProgram({required this.id, @JsonKey(name: 'organization_id') required this.organizationId, required this.name, @JsonKey(name: 'dhikr_definition_id') required this.dhikrDefinitionId, @JsonKey(name: 'dhikr_title_snapshot') required this.dhikrTitleSnapshot, @JsonKey(name: 'dhikr_text_snapshot') required this.dhikrTextSnapshot, @JsonKey(name: 'target_count') required this.targetCount, @JsonKey(name: 'starts_on') required this.startsOn, @JsonKey(name: 'ends_on') required this.endsOn, @JsonKey(name: 'audience_name') required this.audienceName, @JsonKey(name: 'scope_type') required this.scopeType});
  factory _WirdProgram.fromJson(Map<String, dynamic> json) => _$WirdProgramFromJson(json);

@override final  String id;
@override@JsonKey(name: 'organization_id') final  String organizationId;
@override final  String name;
@override@JsonKey(name: 'dhikr_definition_id') final  String dhikrDefinitionId;
@override@JsonKey(name: 'dhikr_title_snapshot') final  String dhikrTitleSnapshot;
@override@JsonKey(name: 'dhikr_text_snapshot') final  String dhikrTextSnapshot;
@override@JsonKey(name: 'target_count') final  int targetCount;
@override@JsonKey(name: 'starts_on') final  DateTime startsOn;
@override@JsonKey(name: 'ends_on') final  DateTime endsOn;
@override@JsonKey(name: 'audience_name') final  String audienceName;
@override@JsonKey(name: 'scope_type') final  WirdAssignmentScope scopeType;

/// Create a copy of WirdProgram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WirdProgramCopyWith<_WirdProgram> get copyWith => __$WirdProgramCopyWithImpl<_WirdProgram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WirdProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WirdProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.name, name) || other.name == name)&&(identical(other.dhikrDefinitionId, dhikrDefinitionId) || other.dhikrDefinitionId == dhikrDefinitionId)&&(identical(other.dhikrTitleSnapshot, dhikrTitleSnapshot) || other.dhikrTitleSnapshot == dhikrTitleSnapshot)&&(identical(other.dhikrTextSnapshot, dhikrTextSnapshot) || other.dhikrTextSnapshot == dhikrTextSnapshot)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.audienceName, audienceName) || other.audienceName == audienceName)&&(identical(other.scopeType, scopeType) || other.scopeType == scopeType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,organizationId,name,dhikrDefinitionId,dhikrTitleSnapshot,dhikrTextSnapshot,targetCount,startsOn,endsOn,audienceName,scopeType);

@override
String toString() {
  return 'WirdProgram(id: $id, organizationId: $organizationId, name: $name, dhikrDefinitionId: $dhikrDefinitionId, dhikrTitleSnapshot: $dhikrTitleSnapshot, dhikrTextSnapshot: $dhikrTextSnapshot, targetCount: $targetCount, startsOn: $startsOn, endsOn: $endsOn, audienceName: $audienceName, scopeType: $scopeType)';
}


}

/// @nodoc
abstract mixin class _$WirdProgramCopyWith<$Res> implements $WirdProgramCopyWith<$Res> {
  factory _$WirdProgramCopyWith(_WirdProgram value, $Res Function(_WirdProgram) _then) = __$WirdProgramCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'organization_id') String organizationId, String name,@JsonKey(name: 'dhikr_definition_id') String dhikrDefinitionId,@JsonKey(name: 'dhikr_title_snapshot') String dhikrTitleSnapshot,@JsonKey(name: 'dhikr_text_snapshot') String dhikrTextSnapshot,@JsonKey(name: 'target_count') int targetCount,@JsonKey(name: 'starts_on') DateTime startsOn,@JsonKey(name: 'ends_on') DateTime endsOn,@JsonKey(name: 'audience_name') String audienceName,@JsonKey(name: 'scope_type') WirdAssignmentScope scopeType
});




}
/// @nodoc
class __$WirdProgramCopyWithImpl<$Res>
    implements _$WirdProgramCopyWith<$Res> {
  __$WirdProgramCopyWithImpl(this._self, this._then);

  final _WirdProgram _self;
  final $Res Function(_WirdProgram) _then;

/// Create a copy of WirdProgram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? organizationId = null,Object? name = null,Object? dhikrDefinitionId = null,Object? dhikrTitleSnapshot = null,Object? dhikrTextSnapshot = null,Object? targetCount = null,Object? startsOn = null,Object? endsOn = null,Object? audienceName = null,Object? scopeType = null,}) {
  return _then(_WirdProgram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dhikrDefinitionId: null == dhikrDefinitionId ? _self.dhikrDefinitionId : dhikrDefinitionId // ignore: cast_nullable_to_non_nullable
as String,dhikrTitleSnapshot: null == dhikrTitleSnapshot ? _self.dhikrTitleSnapshot : dhikrTitleSnapshot // ignore: cast_nullable_to_non_nullable
as String,dhikrTextSnapshot: null == dhikrTextSnapshot ? _self.dhikrTextSnapshot : dhikrTextSnapshot // ignore: cast_nullable_to_non_nullable
as String,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,audienceName: null == audienceName ? _self.audienceName : audienceName // ignore: cast_nullable_to_non_nullable
as String,scopeType: null == scopeType ? _self.scopeType : scopeType // ignore: cast_nullable_to_non_nullable
as WirdAssignmentScope,
  ));
}


}

/// @nodoc
mixin _$WirdProgramCreationState {

 List<WirdProgram> get programs; List<DhikrDefinition> get dhikrDefinitions; List<Branch> get branches; List<SchoolClass> get classes; List<ManagedUser> get users; int? get lastAssignedCount;
/// Create a copy of WirdProgramCreationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WirdProgramCreationStateCopyWith<WirdProgramCreationState> get copyWith => _$WirdProgramCreationStateCopyWithImpl<WirdProgramCreationState>(this as WirdProgramCreationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WirdProgramCreationState&&const DeepCollectionEquality().equals(other.programs, programs)&&const DeepCollectionEquality().equals(other.dhikrDefinitions, dhikrDefinitions)&&const DeepCollectionEquality().equals(other.branches, branches)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.lastAssignedCount, lastAssignedCount) || other.lastAssignedCount == lastAssignedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(programs),const DeepCollectionEquality().hash(dhikrDefinitions),const DeepCollectionEquality().hash(branches),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(users),lastAssignedCount);

@override
String toString() {
  return 'WirdProgramCreationState(programs: $programs, dhikrDefinitions: $dhikrDefinitions, branches: $branches, classes: $classes, users: $users, lastAssignedCount: $lastAssignedCount)';
}


}

/// @nodoc
abstract mixin class $WirdProgramCreationStateCopyWith<$Res>  {
  factory $WirdProgramCreationStateCopyWith(WirdProgramCreationState value, $Res Function(WirdProgramCreationState) _then) = _$WirdProgramCreationStateCopyWithImpl;
@useResult
$Res call({
 List<WirdProgram> programs, List<DhikrDefinition> dhikrDefinitions, List<Branch> branches, List<SchoolClass> classes, List<ManagedUser> users, int? lastAssignedCount
});




}
/// @nodoc
class _$WirdProgramCreationStateCopyWithImpl<$Res>
    implements $WirdProgramCreationStateCopyWith<$Res> {
  _$WirdProgramCreationStateCopyWithImpl(this._self, this._then);

  final WirdProgramCreationState _self;
  final $Res Function(WirdProgramCreationState) _then;

/// Create a copy of WirdProgramCreationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? programs = null,Object? dhikrDefinitions = null,Object? branches = null,Object? classes = null,Object? users = null,Object? lastAssignedCount = freezed,}) {
  return _then(WirdProgramCreationState(
programs: null == programs ? _self.programs : programs // ignore: cast_nullable_to_non_nullable
as List<WirdProgram>,dhikrDefinitions: null == dhikrDefinitions ? _self.dhikrDefinitions : dhikrDefinitions // ignore: cast_nullable_to_non_nullable
as List<DhikrDefinition>,branches: null == branches ? _self.branches : branches // ignore: cast_nullable_to_non_nullable
as List<Branch>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<SchoolClass>,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<ManagedUser>,lastAssignedCount: freezed == lastAssignedCount ? _self.lastAssignedCount : lastAssignedCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [WirdProgramCreationState].
extension WirdProgramCreationStatePatterns on WirdProgramCreationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WirdProgramCreationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WirdProgramCreationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WirdProgramCreationState value)  $default,){
final _that = this;
switch (_that) {
case _WirdProgramCreationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WirdProgramCreationState value)?  $default,){
final _that = this;
switch (_that) {
case _WirdProgramCreationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WirdProgram> programs,  List<DhikrDefinition> dhikrDefinitions,  List<Branch> branches,  List<SchoolClass> classes,  List<ManagedUser> users,  int? lastAssignedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WirdProgramCreationState() when $default != null:
return $default(_that.programs,_that.dhikrDefinitions,_that.branches,_that.classes,_that.users,_that.lastAssignedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WirdProgram> programs,  List<DhikrDefinition> dhikrDefinitions,  List<Branch> branches,  List<SchoolClass> classes,  List<ManagedUser> users,  int? lastAssignedCount)  $default,) {final _that = this;
switch (_that) {
case _WirdProgramCreationState():
return $default(_that.programs,_that.dhikrDefinitions,_that.branches,_that.classes,_that.users,_that.lastAssignedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WirdProgram> programs,  List<DhikrDefinition> dhikrDefinitions,  List<Branch> branches,  List<SchoolClass> classes,  List<ManagedUser> users,  int? lastAssignedCount)?  $default,) {final _that = this;
switch (_that) {
case _WirdProgramCreationState() when $default != null:
return $default(_that.programs,_that.dhikrDefinitions,_that.branches,_that.classes,_that.users,_that.lastAssignedCount);case _:
  return null;

}
}

}

/// @nodoc


class _WirdProgramCreationState implements WirdProgramCreationState {
  const _WirdProgramCreationState({ List<WirdProgram> programs = const <WirdProgram>[],  List<DhikrDefinition> dhikrDefinitions = const <DhikrDefinition>[],  List<Branch> branches = const <Branch>[],  List<SchoolClass> classes = const <SchoolClass>[],  List<ManagedUser> users = const <ManagedUser>[], this.lastAssignedCount}): _programs = programs,_dhikrDefinitions = dhikrDefinitions,_branches = branches,_classes = classes,_users = users;
  

 final  List<WirdProgram> _programs;
@override@JsonKey() List<WirdProgram> get programs {
  if (_programs is EqualUnmodifiableListView) return _programs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_programs);
}

 final  List<DhikrDefinition> _dhikrDefinitions;
@override@JsonKey() List<DhikrDefinition> get dhikrDefinitions {
  if (_dhikrDefinitions is EqualUnmodifiableListView) return _dhikrDefinitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dhikrDefinitions);
}

 final  List<Branch> _branches;
@override@JsonKey() List<Branch> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

 final  List<SchoolClass> _classes;
@override@JsonKey() List<SchoolClass> get classes {
  if (_classes is EqualUnmodifiableListView) return _classes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classes);
}

 final  List<ManagedUser> _users;
@override@JsonKey() List<ManagedUser> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override final  int? lastAssignedCount;

/// Create a copy of WirdProgramCreationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WirdProgramCreationStateCopyWith<_WirdProgramCreationState> get copyWith => __$WirdProgramCreationStateCopyWithImpl<_WirdProgramCreationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WirdProgramCreationState&&const DeepCollectionEquality().equals(other._programs, _programs)&&const DeepCollectionEquality().equals(other._dhikrDefinitions, _dhikrDefinitions)&&const DeepCollectionEquality().equals(other._branches, _branches)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.lastAssignedCount, lastAssignedCount) || other.lastAssignedCount == lastAssignedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_programs),const DeepCollectionEquality().hash(_dhikrDefinitions),const DeepCollectionEquality().hash(_branches),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_users),lastAssignedCount);

@override
String toString() {
  return 'WirdProgramCreationState(programs: $programs, dhikrDefinitions: $dhikrDefinitions, branches: $branches, classes: $classes, users: $users, lastAssignedCount: $lastAssignedCount)';
}


}

/// @nodoc
abstract mixin class _$WirdProgramCreationStateCopyWith<$Res> implements $WirdProgramCreationStateCopyWith<$Res> {
  factory _$WirdProgramCreationStateCopyWith(_WirdProgramCreationState value, $Res Function(_WirdProgramCreationState) _then) = __$WirdProgramCreationStateCopyWithImpl;
@override @useResult
$Res call({
 List<WirdProgram> programs, List<DhikrDefinition> dhikrDefinitions, List<Branch> branches, List<SchoolClass> classes, List<ManagedUser> users, int? lastAssignedCount
});




}
/// @nodoc
class __$WirdProgramCreationStateCopyWithImpl<$Res>
    implements _$WirdProgramCreationStateCopyWith<$Res> {
  __$WirdProgramCreationStateCopyWithImpl(this._self, this._then);

  final _WirdProgramCreationState _self;
  final $Res Function(_WirdProgramCreationState) _then;

/// Create a copy of WirdProgramCreationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? programs = null,Object? dhikrDefinitions = null,Object? branches = null,Object? classes = null,Object? users = null,Object? lastAssignedCount = freezed,}) {
  return _then(_WirdProgramCreationState(
programs: null == programs ? _self._programs : programs // ignore: cast_nullable_to_non_nullable
as List<WirdProgram>,dhikrDefinitions: null == dhikrDefinitions ? _self._dhikrDefinitions : dhikrDefinitions // ignore: cast_nullable_to_non_nullable
as List<DhikrDefinition>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<Branch>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<SchoolClass>,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<ManagedUser>,lastAssignedCount: freezed == lastAssignedCount ? _self.lastAssignedCount : lastAssignedCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
