// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_wird_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarnedBadge {

 String get code; String get name; String get emoji; String get description;
/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarnedBadgeCopyWith<EarnedBadge> get copyWith => _$EarnedBadgeCopyWithImpl<EarnedBadge>(this as EarnedBadge, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarnedBadge&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,emoji,description);

@override
String toString() {
  return 'EarnedBadge(code: $code, name: $name, emoji: $emoji, description: $description)';
}


}

/// @nodoc
abstract mixin class $EarnedBadgeCopyWith<$Res>  {
  factory $EarnedBadgeCopyWith(EarnedBadge value, $Res Function(EarnedBadge) _then) = _$EarnedBadgeCopyWithImpl;
@useResult
$Res call({
 String code, String name, String emoji, String description
});




}
/// @nodoc
class _$EarnedBadgeCopyWithImpl<$Res>
    implements $EarnedBadgeCopyWith<$Res> {
  _$EarnedBadgeCopyWithImpl(this._self, this._then);

  final EarnedBadge _self;
  final $Res Function(EarnedBadge) _then;

/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? emoji = null,Object? description = null,}) {
  return _then(EarnedBadge(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EarnedBadge].
extension EarnedBadgePatterns on EarnedBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarnedBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarnedBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarnedBadge value)  $default,){
final _that = this;
switch (_that) {
case _EarnedBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarnedBadge value)?  $default,){
final _that = this;
switch (_that) {
case _EarnedBadge() when $default != null:
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
case _EarnedBadge() when $default != null:
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
case _EarnedBadge():
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
case _EarnedBadge() when $default != null:
return $default(_that.code,_that.name,_that.emoji,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _EarnedBadge implements EarnedBadge {
  const _EarnedBadge({required this.code, required this.name, required this.emoji, required this.description});
  

@override final  String code;
@override final  String name;
@override final  String emoji;
@override final  String description;

/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarnedBadgeCopyWith<_EarnedBadge> get copyWith => __$EarnedBadgeCopyWithImpl<_EarnedBadge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarnedBadge&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,emoji,description);

@override
String toString() {
  return 'EarnedBadge(code: $code, name: $name, emoji: $emoji, description: $description)';
}


}

/// @nodoc
abstract mixin class _$EarnedBadgeCopyWith<$Res> implements $EarnedBadgeCopyWith<$Res> {
  factory _$EarnedBadgeCopyWith(_EarnedBadge value, $Res Function(_EarnedBadge) _then) = __$EarnedBadgeCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String emoji, String description
});




}
/// @nodoc
class __$EarnedBadgeCopyWithImpl<$Res>
    implements _$EarnedBadgeCopyWith<$Res> {
  __$EarnedBadgeCopyWithImpl(this._self, this._then);

  final _EarnedBadge _self;
  final $Res Function(_EarnedBadge) _then;

/// Create a copy of EarnedBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? emoji = null,Object? description = null,}) {
  return _then(_EarnedBadge(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChildReward {

 int get points; int get completedWirds; int get currentStreak; int get bestStreak; List<EarnedBadge> get badges; String? get badge;
/// Create a copy of ChildReward
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildRewardCopyWith<ChildReward> get copyWith => _$ChildRewardCopyWithImpl<ChildReward>(this as ChildReward, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildReward&&(identical(other.points, points) || other.points == points)&&(identical(other.completedWirds, completedWirds) || other.completedWirds == completedWirds)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&const DeepCollectionEquality().equals(other.badges, badges)&&(identical(other.badge, badge) || other.badge == badge));
}


@override
int get hashCode => Object.hash(runtimeType,points,completedWirds,currentStreak,bestStreak,const DeepCollectionEquality().hash(badges),badge);

@override
String toString() {
  return 'ChildReward(points: $points, completedWirds: $completedWirds, currentStreak: $currentStreak, bestStreak: $bestStreak, badges: $badges, badge: $badge)';
}


}

/// @nodoc
abstract mixin class $ChildRewardCopyWith<$Res>  {
  factory $ChildRewardCopyWith(ChildReward value, $Res Function(ChildReward) _then) = _$ChildRewardCopyWithImpl;
@useResult
$Res call({
 int points, int completedWirds, int currentStreak, int bestStreak, List<EarnedBadge> badges, String? badge
});




}
/// @nodoc
class _$ChildRewardCopyWithImpl<$Res>
    implements $ChildRewardCopyWith<$Res> {
  _$ChildRewardCopyWithImpl(this._self, this._then);

  final ChildReward _self;
  final $Res Function(ChildReward) _then;

/// Create a copy of ChildReward
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? completedWirds = null,Object? currentStreak = null,Object? bestStreak = null,Object? badges = null,Object? badge = freezed,}) {
  return _then(ChildReward(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,completedWirds: null == completedWirds ? _self.completedWirds : completedWirds // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<EarnedBadge>,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildReward].
extension ChildRewardPatterns on ChildReward {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildReward value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildReward() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildReward value)  $default,){
final _that = this;
switch (_that) {
case _ChildReward():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildReward value)?  $default,){
final _that = this;
switch (_that) {
case _ChildReward() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int points,  int completedWirds,  int currentStreak,  int bestStreak,  List<EarnedBadge> badges,  String? badge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildReward() when $default != null:
return $default(_that.points,_that.completedWirds,_that.currentStreak,_that.bestStreak,_that.badges,_that.badge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int points,  int completedWirds,  int currentStreak,  int bestStreak,  List<EarnedBadge> badges,  String? badge)  $default,) {final _that = this;
switch (_that) {
case _ChildReward():
return $default(_that.points,_that.completedWirds,_that.currentStreak,_that.bestStreak,_that.badges,_that.badge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int points,  int completedWirds,  int currentStreak,  int bestStreak,  List<EarnedBadge> badges,  String? badge)?  $default,) {final _that = this;
switch (_that) {
case _ChildReward() when $default != null:
return $default(_that.points,_that.completedWirds,_that.currentStreak,_that.bestStreak,_that.badges,_that.badge);case _:
  return null;

}
}

}

/// @nodoc


class _ChildReward implements ChildReward {
  const _ChildReward({this.points = 0, this.completedWirds = 0, this.currentStreak = 0, this.bestStreak = 0,  List<EarnedBadge> badges = const <EarnedBadge>[], this.badge}): _badges = badges;
  

@override@JsonKey() final  int points;
@override@JsonKey() final  int completedWirds;
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int bestStreak;
 final  List<EarnedBadge> _badges;
@override@JsonKey() List<EarnedBadge> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

@override final  String? badge;

/// Create a copy of ChildReward
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildRewardCopyWith<_ChildReward> get copyWith => __$ChildRewardCopyWithImpl<_ChildReward>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildReward&&(identical(other.points, points) || other.points == points)&&(identical(other.completedWirds, completedWirds) || other.completedWirds == completedWirds)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&const DeepCollectionEquality().equals(other._badges, _badges)&&(identical(other.badge, badge) || other.badge == badge));
}


@override
int get hashCode => Object.hash(runtimeType,points,completedWirds,currentStreak,bestStreak,const DeepCollectionEquality().hash(_badges),badge);

@override
String toString() {
  return 'ChildReward(points: $points, completedWirds: $completedWirds, currentStreak: $currentStreak, bestStreak: $bestStreak, badges: $badges, badge: $badge)';
}


}

/// @nodoc
abstract mixin class _$ChildRewardCopyWith<$Res> implements $ChildRewardCopyWith<$Res> {
  factory _$ChildRewardCopyWith(_ChildReward value, $Res Function(_ChildReward) _then) = __$ChildRewardCopyWithImpl;
@override @useResult
$Res call({
 int points, int completedWirds, int currentStreak, int bestStreak, List<EarnedBadge> badges, String? badge
});




}
/// @nodoc
class __$ChildRewardCopyWithImpl<$Res>
    implements _$ChildRewardCopyWith<$Res> {
  __$ChildRewardCopyWithImpl(this._self, this._then);

  final _ChildReward _self;
  final $Res Function(_ChildReward) _then;

/// Create a copy of ChildReward
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? completedWirds = null,Object? currentStreak = null,Object? bestStreak = null,Object? badges = null,Object? badge = freezed,}) {
  return _then(_ChildReward(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,completedWirds: null == completedWirds ? _self.completedWirds : completedWirds // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<EarnedBadge>,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ChildWirdState {

 ManagedWird? get wird; ChildReward get reward;
/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildWirdStateCopyWith<ChildWirdState> get copyWith => _$ChildWirdStateCopyWithImpl<ChildWirdState>(this as ChildWirdState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildWirdState&&(identical(other.wird, wird) || other.wird == wird)&&(identical(other.reward, reward) || other.reward == reward));
}


@override
int get hashCode => Object.hash(runtimeType,wird,reward);

@override
String toString() {
  return 'ChildWirdState(wird: $wird, reward: $reward)';
}


}

/// @nodoc
abstract mixin class $ChildWirdStateCopyWith<$Res>  {
  factory $ChildWirdStateCopyWith(ChildWirdState value, $Res Function(ChildWirdState) _then) = _$ChildWirdStateCopyWithImpl;
@useResult
$Res call({
 ManagedWird? wird, ChildReward reward
});


$ManagedWirdCopyWith<$Res>? get wird;$ChildRewardCopyWith<$Res> get reward;

}
/// @nodoc
class _$ChildWirdStateCopyWithImpl<$Res>
    implements $ChildWirdStateCopyWith<$Res> {
  _$ChildWirdStateCopyWithImpl(this._self, this._then);

  final ChildWirdState _self;
  final $Res Function(ChildWirdState) _then;

/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wird = freezed,Object? reward = null,}) {
  return _then(ChildWirdState(
wird: freezed == wird ? _self.wird : wird // ignore: cast_nullable_to_non_nullable
as ManagedWird?,reward: null == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as ChildReward,
  ));
}
/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedWirdCopyWith<$Res>? get wird {
    if (_self.wird == null) {
    return null;
  }

  return $ManagedWirdCopyWith<$Res>(_self.wird!, (value) {
    return _then(_self.copyWith(wird: value));
  });
}/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildRewardCopyWith<$Res> get reward {
  
  return $ChildRewardCopyWith<$Res>(_self.reward, (value) {
    return _then(_self.copyWith(reward: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChildWirdState].
extension ChildWirdStatePatterns on ChildWirdState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildWirdState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildWirdState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildWirdState value)  $default,){
final _that = this;
switch (_that) {
case _ChildWirdState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildWirdState value)?  $default,){
final _that = this;
switch (_that) {
case _ChildWirdState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ManagedWird? wird,  ChildReward reward)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildWirdState() when $default != null:
return $default(_that.wird,_that.reward);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ManagedWird? wird,  ChildReward reward)  $default,) {final _that = this;
switch (_that) {
case _ChildWirdState():
return $default(_that.wird,_that.reward);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ManagedWird? wird,  ChildReward reward)?  $default,) {final _that = this;
switch (_that) {
case _ChildWirdState() when $default != null:
return $default(_that.wird,_that.reward);case _:
  return null;

}
}

}

/// @nodoc


class _ChildWirdState implements ChildWirdState {
  const _ChildWirdState({this.wird, this.reward = const ChildReward()});
  

@override final  ManagedWird? wird;
@override@JsonKey() final  ChildReward reward;

/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildWirdStateCopyWith<_ChildWirdState> get copyWith => __$ChildWirdStateCopyWithImpl<_ChildWirdState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildWirdState&&(identical(other.wird, wird) || other.wird == wird)&&(identical(other.reward, reward) || other.reward == reward));
}


@override
int get hashCode => Object.hash(runtimeType,wird,reward);

@override
String toString() {
  return 'ChildWirdState(wird: $wird, reward: $reward)';
}


}

/// @nodoc
abstract mixin class _$ChildWirdStateCopyWith<$Res> implements $ChildWirdStateCopyWith<$Res> {
  factory _$ChildWirdStateCopyWith(_ChildWirdState value, $Res Function(_ChildWirdState) _then) = __$ChildWirdStateCopyWithImpl;
@override @useResult
$Res call({
 ManagedWird? wird, ChildReward reward
});


@override $ManagedWirdCopyWith<$Res>? get wird;@override $ChildRewardCopyWith<$Res> get reward;

}
/// @nodoc
class __$ChildWirdStateCopyWithImpl<$Res>
    implements _$ChildWirdStateCopyWith<$Res> {
  __$ChildWirdStateCopyWithImpl(this._self, this._then);

  final _ChildWirdState _self;
  final $Res Function(_ChildWirdState) _then;

/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wird = freezed,Object? reward = null,}) {
  return _then(_ChildWirdState(
wird: freezed == wird ? _self.wird : wird // ignore: cast_nullable_to_non_nullable
as ManagedWird?,reward: null == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as ChildReward,
  ));
}

/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedWirdCopyWith<$Res>? get wird {
    if (_self.wird == null) {
    return null;
  }

  return $ManagedWirdCopyWith<$Res>(_self.wird!, (value) {
    return _then(_self.copyWith(wird: value));
  });
}/// Create a copy of ChildWirdState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildRewardCopyWith<$Res> get reward {
  
  return $ChildRewardCopyWith<$Res>(_self.reward, (value) {
    return _then(_self.copyWith(reward: value));
  });
}
}

// dart format on
