// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_journey_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmployeeJourneyState {

 ManagedUser get employee; ManagedWird? get currentWird; int get currentCount; List<ManagedWird> get history; SchoolClass? get schoolClass; List<ManagedUser> get classChildren;
/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeJourneyStateCopyWith<EmployeeJourneyState> get copyWith => _$EmployeeJourneyStateCopyWithImpl<EmployeeJourneyState>(this as EmployeeJourneyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeJourneyState&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.currentWird, currentWird) || other.currentWird == currentWird)&&(identical(other.currentCount, currentCount) || other.currentCount == currentCount)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.schoolClass, schoolClass) || other.schoolClass == schoolClass)&&const DeepCollectionEquality().equals(other.classChildren, classChildren));
}


@override
int get hashCode => Object.hash(runtimeType,employee,currentWird,currentCount,const DeepCollectionEquality().hash(history),schoolClass,const DeepCollectionEquality().hash(classChildren));

@override
String toString() {
  return 'EmployeeJourneyState(employee: $employee, currentWird: $currentWird, currentCount: $currentCount, history: $history, schoolClass: $schoolClass, classChildren: $classChildren)';
}


}

/// @nodoc
abstract mixin class $EmployeeJourneyStateCopyWith<$Res>  {
  factory $EmployeeJourneyStateCopyWith(EmployeeJourneyState value, $Res Function(EmployeeJourneyState) _then) = _$EmployeeJourneyStateCopyWithImpl;
@useResult
$Res call({
 ManagedUser employee, ManagedWird? currentWird, int currentCount, List<ManagedWird> history, SchoolClass? schoolClass, List<ManagedUser> classChildren
});


$ManagedUserCopyWith<$Res> get employee;$ManagedWirdCopyWith<$Res>? get currentWird;$SchoolClassCopyWith<$Res>? get schoolClass;

}
/// @nodoc
class _$EmployeeJourneyStateCopyWithImpl<$Res>
    implements $EmployeeJourneyStateCopyWith<$Res> {
  _$EmployeeJourneyStateCopyWithImpl(this._self, this._then);

  final EmployeeJourneyState _self;
  final $Res Function(EmployeeJourneyState) _then;

/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employee = null,Object? currentWird = freezed,Object? currentCount = null,Object? history = null,Object? schoolClass = freezed,Object? classChildren = null,}) {
  return _then(EmployeeJourneyState(
employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as ManagedUser,currentWird: freezed == currentWird ? _self.currentWird : currentWird // ignore: cast_nullable_to_non_nullable
as ManagedWird?,currentCount: null == currentCount ? _self.currentCount : currentCount // ignore: cast_nullable_to_non_nullable
as int,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<ManagedWird>,schoolClass: freezed == schoolClass ? _self.schoolClass : schoolClass // ignore: cast_nullable_to_non_nullable
as SchoolClass?,classChildren: null == classChildren ? _self.classChildren : classChildren // ignore: cast_nullable_to_non_nullable
as List<ManagedUser>,
  ));
}
/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedUserCopyWith<$Res> get employee {
  
  return $ManagedUserCopyWith<$Res>(_self.employee, (value) {
    return _then(_self.copyWith(employee: value));
  });
}/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedWirdCopyWith<$Res>? get currentWird {
    if (_self.currentWird == null) {
    return null;
  }

  return $ManagedWirdCopyWith<$Res>(_self.currentWird!, (value) {
    return _then(_self.copyWith(currentWird: value));
  });
}/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SchoolClassCopyWith<$Res>? get schoolClass {
    if (_self.schoolClass == null) {
    return null;
  }

  return $SchoolClassCopyWith<$Res>(_self.schoolClass!, (value) {
    return _then(_self.copyWith(schoolClass: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmployeeJourneyState].
extension EmployeeJourneyStatePatterns on EmployeeJourneyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeJourneyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeJourneyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeJourneyState value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeJourneyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeJourneyState value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeJourneyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ManagedUser employee,  ManagedWird? currentWird,  int currentCount,  List<ManagedWird> history,  SchoolClass? schoolClass,  List<ManagedUser> classChildren)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeJourneyState() when $default != null:
return $default(_that.employee,_that.currentWird,_that.currentCount,_that.history,_that.schoolClass,_that.classChildren);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ManagedUser employee,  ManagedWird? currentWird,  int currentCount,  List<ManagedWird> history,  SchoolClass? schoolClass,  List<ManagedUser> classChildren)  $default,) {final _that = this;
switch (_that) {
case _EmployeeJourneyState():
return $default(_that.employee,_that.currentWird,_that.currentCount,_that.history,_that.schoolClass,_that.classChildren);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ManagedUser employee,  ManagedWird? currentWird,  int currentCount,  List<ManagedWird> history,  SchoolClass? schoolClass,  List<ManagedUser> classChildren)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeJourneyState() when $default != null:
return $default(_that.employee,_that.currentWird,_that.currentCount,_that.history,_that.schoolClass,_that.classChildren);case _:
  return null;

}
}

}

/// @nodoc


class _EmployeeJourneyState implements EmployeeJourneyState {
  const _EmployeeJourneyState({required this.employee, this.currentWird, this.currentCount = 0,  List<ManagedWird> history = const <ManagedWird>[], this.schoolClass,  List<ManagedUser> classChildren = const <ManagedUser>[]}): _history = history,_classChildren = classChildren;
  

@override final  ManagedUser employee;
@override final  ManagedWird? currentWird;
@override@JsonKey() final  int currentCount;
 final  List<ManagedWird> _history;
@override@JsonKey() List<ManagedWird> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override final  SchoolClass? schoolClass;
 final  List<ManagedUser> _classChildren;
@override@JsonKey() List<ManagedUser> get classChildren {
  if (_classChildren is EqualUnmodifiableListView) return _classChildren;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classChildren);
}


/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeJourneyStateCopyWith<_EmployeeJourneyState> get copyWith => __$EmployeeJourneyStateCopyWithImpl<_EmployeeJourneyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeJourneyState&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.currentWird, currentWird) || other.currentWird == currentWird)&&(identical(other.currentCount, currentCount) || other.currentCount == currentCount)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.schoolClass, schoolClass) || other.schoolClass == schoolClass)&&const DeepCollectionEquality().equals(other._classChildren, _classChildren));
}


@override
int get hashCode => Object.hash(runtimeType,employee,currentWird,currentCount,const DeepCollectionEquality().hash(_history),schoolClass,const DeepCollectionEquality().hash(_classChildren));

@override
String toString() {
  return 'EmployeeJourneyState(employee: $employee, currentWird: $currentWird, currentCount: $currentCount, history: $history, schoolClass: $schoolClass, classChildren: $classChildren)';
}


}

/// @nodoc
abstract mixin class _$EmployeeJourneyStateCopyWith<$Res> implements $EmployeeJourneyStateCopyWith<$Res> {
  factory _$EmployeeJourneyStateCopyWith(_EmployeeJourneyState value, $Res Function(_EmployeeJourneyState) _then) = __$EmployeeJourneyStateCopyWithImpl;
@override @useResult
$Res call({
 ManagedUser employee, ManagedWird? currentWird, int currentCount, List<ManagedWird> history, SchoolClass? schoolClass, List<ManagedUser> classChildren
});


@override $ManagedUserCopyWith<$Res> get employee;@override $ManagedWirdCopyWith<$Res>? get currentWird;@override $SchoolClassCopyWith<$Res>? get schoolClass;

}
/// @nodoc
class __$EmployeeJourneyStateCopyWithImpl<$Res>
    implements _$EmployeeJourneyStateCopyWith<$Res> {
  __$EmployeeJourneyStateCopyWithImpl(this._self, this._then);

  final _EmployeeJourneyState _self;
  final $Res Function(_EmployeeJourneyState) _then;

/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employee = null,Object? currentWird = freezed,Object? currentCount = null,Object? history = null,Object? schoolClass = freezed,Object? classChildren = null,}) {
  return _then(_EmployeeJourneyState(
employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as ManagedUser,currentWird: freezed == currentWird ? _self.currentWird : currentWird // ignore: cast_nullable_to_non_nullable
as ManagedWird?,currentCount: null == currentCount ? _self.currentCount : currentCount // ignore: cast_nullable_to_non_nullable
as int,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ManagedWird>,schoolClass: freezed == schoolClass ? _self.schoolClass : schoolClass // ignore: cast_nullable_to_non_nullable
as SchoolClass?,classChildren: null == classChildren ? _self._classChildren : classChildren // ignore: cast_nullable_to_non_nullable
as List<ManagedUser>,
  ));
}

/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedUserCopyWith<$Res> get employee {
  
  return $ManagedUserCopyWith<$Res>(_self.employee, (value) {
    return _then(_self.copyWith(employee: value));
  });
}/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManagedWirdCopyWith<$Res>? get currentWird {
    if (_self.currentWird == null) {
    return null;
  }

  return $ManagedWirdCopyWith<$Res>(_self.currentWird!, (value) {
    return _then(_self.copyWith(currentWird: value));
  });
}/// Create a copy of EmployeeJourneyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SchoolClassCopyWith<$Res>? get schoolClass {
    if (_self.schoolClass == null) {
    return null;
  }

  return $SchoolClassCopyWith<$Res>(_self.schoolClass!, (value) {
    return _then(_self.copyWith(schoolClass: value));
  });
}
}

// dart format on
