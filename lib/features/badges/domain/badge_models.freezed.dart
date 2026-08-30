// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManualBadgeDefinition {

 String get id; String get name; String get emoji; String get description;
/// Create a copy of ManualBadgeDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManualBadgeDefinitionCopyWith<ManualBadgeDefinition> get copyWith => _$ManualBadgeDefinitionCopyWithImpl<ManualBadgeDefinition>(this as ManualBadgeDefinition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManualBadgeDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,emoji,description);

@override
String toString() {
  return 'ManualBadgeDefinition(id: $id, name: $name, emoji: $emoji, description: $description)';
}


}

/// @nodoc
abstract mixin class $ManualBadgeDefinitionCopyWith<$Res>  {
  factory $ManualBadgeDefinitionCopyWith(ManualBadgeDefinition value, $Res Function(ManualBadgeDefinition) _then) = _$ManualBadgeDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String emoji, String description
});




}
/// @nodoc
class _$ManualBadgeDefinitionCopyWithImpl<$Res>
    implements $ManualBadgeDefinitionCopyWith<$Res> {
  _$ManualBadgeDefinitionCopyWithImpl(this._self, this._then);

  final ManualBadgeDefinition _self;
  final $Res Function(ManualBadgeDefinition) _then;

/// Create a copy of ManualBadgeDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? emoji = null,Object? description = null,}) {
  return _then(ManualBadgeDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ManualBadgeDefinition].
extension ManualBadgeDefinitionPatterns on ManualBadgeDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManualBadgeDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManualBadgeDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManualBadgeDefinition value)  $default,){
final _that = this;
switch (_that) {
case _ManualBadgeDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManualBadgeDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _ManualBadgeDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String emoji,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManualBadgeDefinition() when $default != null:
return $default(_that.id,_that.name,_that.emoji,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String emoji,  String description)  $default,) {final _that = this;
switch (_that) {
case _ManualBadgeDefinition():
return $default(_that.id,_that.name,_that.emoji,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String emoji,  String description)?  $default,) {final _that = this;
switch (_that) {
case _ManualBadgeDefinition() when $default != null:
return $default(_that.id,_that.name,_that.emoji,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _ManualBadgeDefinition implements ManualBadgeDefinition {
  const _ManualBadgeDefinition({required this.id, required this.name, required this.emoji, required this.description});
  

@override final  String id;
@override final  String name;
@override final  String emoji;
@override final  String description;

/// Create a copy of ManualBadgeDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManualBadgeDefinitionCopyWith<_ManualBadgeDefinition> get copyWith => __$ManualBadgeDefinitionCopyWithImpl<_ManualBadgeDefinition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManualBadgeDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,emoji,description);

@override
String toString() {
  return 'ManualBadgeDefinition(id: $id, name: $name, emoji: $emoji, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ManualBadgeDefinitionCopyWith<$Res> implements $ManualBadgeDefinitionCopyWith<$Res> {
  factory _$ManualBadgeDefinitionCopyWith(_ManualBadgeDefinition value, $Res Function(_ManualBadgeDefinition) _then) = __$ManualBadgeDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String emoji, String description
});




}
/// @nodoc
class __$ManualBadgeDefinitionCopyWithImpl<$Res>
    implements _$ManualBadgeDefinitionCopyWith<$Res> {
  __$ManualBadgeDefinitionCopyWithImpl(this._self, this._then);

  final _ManualBadgeDefinition _self;
  final $Res Function(_ManualBadgeDefinition) _then;

/// Create a copy of ManualBadgeDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? emoji = null,Object? description = null,}) {
  return _then(_ManualBadgeDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChildRewardOverview {

 String get childId; String get childName; String? get className; int get completedWirds; int get points; int get currentStreak; int get bestStreak; List<RewardBadgeSummary> get badges;
/// Create a copy of ChildRewardOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildRewardOverviewCopyWith<ChildRewardOverview> get copyWith => _$ChildRewardOverviewCopyWithImpl<ChildRewardOverview>(this as ChildRewardOverview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildRewardOverview&&(identical(other.childId, childId) || other.childId == childId)&&(identical(other.childName, childName) || other.childName == childName)&&(identical(other.className, className) || other.className == className)&&(identical(other.completedWirds, completedWirds) || other.completedWirds == completedWirds)&&(identical(other.points, points) || other.points == points)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&const DeepCollectionEquality().equals(other.badges, badges));
}


@override
int get hashCode => Object.hash(runtimeType,childId,childName,className,completedWirds,points,currentStreak,bestStreak,const DeepCollectionEquality().hash(badges));

@override
String toString() {
  return 'ChildRewardOverview(childId: $childId, childName: $childName, className: $className, completedWirds: $completedWirds, points: $points, currentStreak: $currentStreak, bestStreak: $bestStreak, badges: $badges)';
}


}

/// @nodoc
abstract mixin class $ChildRewardOverviewCopyWith<$Res>  {
  factory $ChildRewardOverviewCopyWith(ChildRewardOverview value, $Res Function(ChildRewardOverview) _then) = _$ChildRewardOverviewCopyWithImpl;
@useResult
$Res call({
 String childId, String childName, String? className, int completedWirds, int points, int currentStreak, int bestStreak, List<RewardBadgeSummary> badges
});




}
/// @nodoc
class _$ChildRewardOverviewCopyWithImpl<$Res>
    implements $ChildRewardOverviewCopyWith<$Res> {
  _$ChildRewardOverviewCopyWithImpl(this._self, this._then);

  final ChildRewardOverview _self;
  final $Res Function(ChildRewardOverview) _then;

/// Create a copy of ChildRewardOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childId = null,Object? childName = null,Object? className = freezed,Object? completedWirds = null,Object? points = null,Object? currentStreak = null,Object? bestStreak = null,Object? badges = null,}) {
  return _then(ChildRewardOverview(
childId: null == childId ? _self.childId : childId // ignore: cast_nullable_to_non_nullable
as String,childName: null == childName ? _self.childName : childName // ignore: cast_nullable_to_non_nullable
as String,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,completedWirds: null == completedWirds ? _self.completedWirds : completedWirds // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<RewardBadgeSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildRewardOverview].
extension ChildRewardOverviewPatterns on ChildRewardOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildRewardOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildRewardOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildRewardOverview value)  $default,){
final _that = this;
switch (_that) {
case _ChildRewardOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildRewardOverview value)?  $default,){
final _that = this;
switch (_that) {
case _ChildRewardOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String childId,  String childName,  String? className,  int completedWirds,  int points,  int currentStreak,  int bestStreak,  List<RewardBadgeSummary> badges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildRewardOverview() when $default != null:
return $default(_that.childId,_that.childName,_that.className,_that.completedWirds,_that.points,_that.currentStreak,_that.bestStreak,_that.badges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String childId,  String childName,  String? className,  int completedWirds,  int points,  int currentStreak,  int bestStreak,  List<RewardBadgeSummary> badges)  $default,) {final _that = this;
switch (_that) {
case _ChildRewardOverview():
return $default(_that.childId,_that.childName,_that.className,_that.completedWirds,_that.points,_that.currentStreak,_that.bestStreak,_that.badges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String childId,  String childName,  String? className,  int completedWirds,  int points,  int currentStreak,  int bestStreak,  List<RewardBadgeSummary> badges)?  $default,) {final _that = this;
switch (_that) {
case _ChildRewardOverview() when $default != null:
return $default(_that.childId,_that.childName,_that.className,_that.completedWirds,_that.points,_that.currentStreak,_that.bestStreak,_that.badges);case _:
  return null;

}
}

}

/// @nodoc


class _ChildRewardOverview implements ChildRewardOverview {
  const _ChildRewardOverview({required this.childId, required this.childName, this.className, this.completedWirds = 0, this.points = 0, this.currentStreak = 0, this.bestStreak = 0,  List<RewardBadgeSummary> badges = const <RewardBadgeSummary>[]}): _badges = badges;
  

@override final  String childId;
@override final  String childName;
@override final  String? className;
@override@JsonKey() final  int completedWirds;
@override@JsonKey() final  int points;
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int bestStreak;
 final  List<RewardBadgeSummary> _badges;
@override@JsonKey() List<RewardBadgeSummary> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}


/// Create a copy of ChildRewardOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildRewardOverviewCopyWith<_ChildRewardOverview> get copyWith => __$ChildRewardOverviewCopyWithImpl<_ChildRewardOverview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildRewardOverview&&(identical(other.childId, childId) || other.childId == childId)&&(identical(other.childName, childName) || other.childName == childName)&&(identical(other.className, className) || other.className == className)&&(identical(other.completedWirds, completedWirds) || other.completedWirds == completedWirds)&&(identical(other.points, points) || other.points == points)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&const DeepCollectionEquality().equals(other._badges, _badges));
}


@override
int get hashCode => Object.hash(runtimeType,childId,childName,className,completedWirds,points,currentStreak,bestStreak,const DeepCollectionEquality().hash(_badges));

@override
String toString() {
  return 'ChildRewardOverview(childId: $childId, childName: $childName, className: $className, completedWirds: $completedWirds, points: $points, currentStreak: $currentStreak, bestStreak: $bestStreak, badges: $badges)';
}


}

/// @nodoc
abstract mixin class _$ChildRewardOverviewCopyWith<$Res> implements $ChildRewardOverviewCopyWith<$Res> {
  factory _$ChildRewardOverviewCopyWith(_ChildRewardOverview value, $Res Function(_ChildRewardOverview) _then) = __$ChildRewardOverviewCopyWithImpl;
@override @useResult
$Res call({
 String childId, String childName, String? className, int completedWirds, int points, int currentStreak, int bestStreak, List<RewardBadgeSummary> badges
});




}
/// @nodoc
class __$ChildRewardOverviewCopyWithImpl<$Res>
    implements _$ChildRewardOverviewCopyWith<$Res> {
  __$ChildRewardOverviewCopyWithImpl(this._self, this._then);

  final _ChildRewardOverview _self;
  final $Res Function(_ChildRewardOverview) _then;

/// Create a copy of ChildRewardOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childId = null,Object? childName = null,Object? className = freezed,Object? completedWirds = null,Object? points = null,Object? currentStreak = null,Object? bestStreak = null,Object? badges = null,}) {
  return _then(_ChildRewardOverview(
childId: null == childId ? _self.childId : childId // ignore: cast_nullable_to_non_nullable
as String,childName: null == childName ? _self.childName : childName // ignore: cast_nullable_to_non_nullable
as String,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,completedWirds: null == completedWirds ? _self.completedWirds : completedWirds // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<RewardBadgeSummary>,
  ));
}


}

/// @nodoc
mixin _$RewardBadgeSummary {

 String get code; String get name; String get emoji; String get description;
/// Create a copy of RewardBadgeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardBadgeSummaryCopyWith<RewardBadgeSummary> get copyWith => _$RewardBadgeSummaryCopyWithImpl<RewardBadgeSummary>(this as RewardBadgeSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardBadgeSummary&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,emoji,description);

@override
String toString() {
  return 'RewardBadgeSummary(code: $code, name: $name, emoji: $emoji, description: $description)';
}


}

/// @nodoc
abstract mixin class $RewardBadgeSummaryCopyWith<$Res>  {
  factory $RewardBadgeSummaryCopyWith(RewardBadgeSummary value, $Res Function(RewardBadgeSummary) _then) = _$RewardBadgeSummaryCopyWithImpl;
@useResult
$Res call({
 String code, String name, String emoji, String description
});




}
/// @nodoc
class _$RewardBadgeSummaryCopyWithImpl<$Res>
    implements $RewardBadgeSummaryCopyWith<$Res> {
  _$RewardBadgeSummaryCopyWithImpl(this._self, this._then);

  final RewardBadgeSummary _self;
  final $Res Function(RewardBadgeSummary) _then;

/// Create a copy of RewardBadgeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? emoji = null,Object? description = null,}) {
  return _then(RewardBadgeSummary(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardBadgeSummary].
extension RewardBadgeSummaryPatterns on RewardBadgeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardBadgeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardBadgeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardBadgeSummary value)  $default,){
final _that = this;
switch (_that) {
case _RewardBadgeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardBadgeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RewardBadgeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String emoji,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardBadgeSummary() when $default != null:
return $default(_that.code,_that.name,_that.emoji,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String emoji,  String description)  $default,) {final _that = this;
switch (_that) {
case _RewardBadgeSummary():
return $default(_that.code,_that.name,_that.emoji,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String emoji,  String description)?  $default,) {final _that = this;
switch (_that) {
case _RewardBadgeSummary() when $default != null:
return $default(_that.code,_that.name,_that.emoji,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _RewardBadgeSummary implements RewardBadgeSummary {
  const _RewardBadgeSummary({required this.code, required this.name, required this.emoji, required this.description});
  

@override final  String code;
@override final  String name;
@override final  String emoji;
@override final  String description;

/// Create a copy of RewardBadgeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardBadgeSummaryCopyWith<_RewardBadgeSummary> get copyWith => __$RewardBadgeSummaryCopyWithImpl<_RewardBadgeSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardBadgeSummary&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,emoji,description);

@override
String toString() {
  return 'RewardBadgeSummary(code: $code, name: $name, emoji: $emoji, description: $description)';
}


}

/// @nodoc
abstract mixin class _$RewardBadgeSummaryCopyWith<$Res> implements $RewardBadgeSummaryCopyWith<$Res> {
  factory _$RewardBadgeSummaryCopyWith(_RewardBadgeSummary value, $Res Function(_RewardBadgeSummary) _then) = __$RewardBadgeSummaryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String emoji, String description
});




}
/// @nodoc
class __$RewardBadgeSummaryCopyWithImpl<$Res>
    implements _$RewardBadgeSummaryCopyWith<$Res> {
  __$RewardBadgeSummaryCopyWithImpl(this._self, this._then);

  final _RewardBadgeSummary _self;
  final $Res Function(_RewardBadgeSummary) _then;

/// Create a copy of RewardBadgeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? emoji = null,Object? description = null,}) {
  return _then(_RewardBadgeSummary(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BadgeManagementState {

 List<ManualBadgeDefinition> get manualBadges; List<ChildRewardOverview> get childRewards;
/// Create a copy of BadgeManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadgeManagementStateCopyWith<BadgeManagementState> get copyWith => _$BadgeManagementStateCopyWithImpl<BadgeManagementState>(this as BadgeManagementState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadgeManagementState&&const DeepCollectionEquality().equals(other.manualBadges, manualBadges)&&const DeepCollectionEquality().equals(other.childRewards, childRewards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(manualBadges),const DeepCollectionEquality().hash(childRewards));

@override
String toString() {
  return 'BadgeManagementState(manualBadges: $manualBadges, childRewards: $childRewards)';
}


}

/// @nodoc
abstract mixin class $BadgeManagementStateCopyWith<$Res>  {
  factory $BadgeManagementStateCopyWith(BadgeManagementState value, $Res Function(BadgeManagementState) _then) = _$BadgeManagementStateCopyWithImpl;
@useResult
$Res call({
 List<ManualBadgeDefinition> manualBadges, List<ChildRewardOverview> childRewards
});




}
/// @nodoc
class _$BadgeManagementStateCopyWithImpl<$Res>
    implements $BadgeManagementStateCopyWith<$Res> {
  _$BadgeManagementStateCopyWithImpl(this._self, this._then);

  final BadgeManagementState _self;
  final $Res Function(BadgeManagementState) _then;

/// Create a copy of BadgeManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? manualBadges = null,Object? childRewards = null,}) {
  return _then(BadgeManagementState(
manualBadges: null == manualBadges ? _self.manualBadges : manualBadges // ignore: cast_nullable_to_non_nullable
as List<ManualBadgeDefinition>,childRewards: null == childRewards ? _self.childRewards : childRewards // ignore: cast_nullable_to_non_nullable
as List<ChildRewardOverview>,
  ));
}

}


/// Adds pattern-matching-related methods to [BadgeManagementState].
extension BadgeManagementStatePatterns on BadgeManagementState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BadgeManagementState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BadgeManagementState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BadgeManagementState value)  $default,){
final _that = this;
switch (_that) {
case _BadgeManagementState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BadgeManagementState value)?  $default,){
final _that = this;
switch (_that) {
case _BadgeManagementState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ManualBadgeDefinition> manualBadges,  List<ChildRewardOverview> childRewards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BadgeManagementState() when $default != null:
return $default(_that.manualBadges,_that.childRewards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ManualBadgeDefinition> manualBadges,  List<ChildRewardOverview> childRewards)  $default,) {final _that = this;
switch (_that) {
case _BadgeManagementState():
return $default(_that.manualBadges,_that.childRewards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ManualBadgeDefinition> manualBadges,  List<ChildRewardOverview> childRewards)?  $default,) {final _that = this;
switch (_that) {
case _BadgeManagementState() when $default != null:
return $default(_that.manualBadges,_that.childRewards);case _:
  return null;

}
}

}

/// @nodoc


class _BadgeManagementState implements BadgeManagementState {
  const _BadgeManagementState({ List<ManualBadgeDefinition> manualBadges = const <ManualBadgeDefinition>[],  List<ChildRewardOverview> childRewards = const <ChildRewardOverview>[]}): _manualBadges = manualBadges,_childRewards = childRewards;
  

 final  List<ManualBadgeDefinition> _manualBadges;
@override@JsonKey() List<ManualBadgeDefinition> get manualBadges {
  if (_manualBadges is EqualUnmodifiableListView) return _manualBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_manualBadges);
}

 final  List<ChildRewardOverview> _childRewards;
@override@JsonKey() List<ChildRewardOverview> get childRewards {
  if (_childRewards is EqualUnmodifiableListView) return _childRewards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_childRewards);
}


/// Create a copy of BadgeManagementState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BadgeManagementStateCopyWith<_BadgeManagementState> get copyWith => __$BadgeManagementStateCopyWithImpl<_BadgeManagementState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BadgeManagementState&&const DeepCollectionEquality().equals(other._manualBadges, _manualBadges)&&const DeepCollectionEquality().equals(other._childRewards, _childRewards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_manualBadges),const DeepCollectionEquality().hash(_childRewards));

@override
String toString() {
  return 'BadgeManagementState(manualBadges: $manualBadges, childRewards: $childRewards)';
}


}

/// @nodoc
abstract mixin class _$BadgeManagementStateCopyWith<$Res> implements $BadgeManagementStateCopyWith<$Res> {
  factory _$BadgeManagementStateCopyWith(_BadgeManagementState value, $Res Function(_BadgeManagementState) _then) = __$BadgeManagementStateCopyWithImpl;
@override @useResult
$Res call({
 List<ManualBadgeDefinition> manualBadges, List<ChildRewardOverview> childRewards
});




}
/// @nodoc
class __$BadgeManagementStateCopyWithImpl<$Res>
    implements _$BadgeManagementStateCopyWith<$Res> {
  __$BadgeManagementStateCopyWithImpl(this._self, this._then);

  final _BadgeManagementState _self;
  final $Res Function(_BadgeManagementState) _then;

/// Create a copy of BadgeManagementState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? manualBadges = null,Object? childRewards = null,}) {
  return _then(_BadgeManagementState(
manualBadges: null == manualBadges ? _self._manualBadges : manualBadges // ignore: cast_nullable_to_non_nullable
as List<ManualBadgeDefinition>,childRewards: null == childRewards ? _self._childRewards : childRewards // ignore: cast_nullable_to_non_nullable
as List<ChildRewardOverview>,
  ));
}


}

// dart format on
