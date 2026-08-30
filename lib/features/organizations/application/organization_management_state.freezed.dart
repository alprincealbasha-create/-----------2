// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizationManagementState {

 List<Organization> get organizations; List<Branch> get branches; List<SchoolClass> get classes; List<ChildRecord> get children; String? get selectedOrganizationId; String? get selectedBranchId; String? get selectedClassId;
/// Create a copy of OrganizationManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizationManagementStateCopyWith<OrganizationManagementState> get copyWith => _$OrganizationManagementStateCopyWithImpl<OrganizationManagementState>(this as OrganizationManagementState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationManagementState&&const DeepCollectionEquality().equals(other.organizations, organizations)&&const DeepCollectionEquality().equals(other.branches, branches)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.children, children)&&(identical(other.selectedOrganizationId, selectedOrganizationId) || other.selectedOrganizationId == selectedOrganizationId)&&(identical(other.selectedBranchId, selectedBranchId) || other.selectedBranchId == selectedBranchId)&&(identical(other.selectedClassId, selectedClassId) || other.selectedClassId == selectedClassId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(organizations),const DeepCollectionEquality().hash(branches),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(children),selectedOrganizationId,selectedBranchId,selectedClassId);

@override
String toString() {
  return 'OrganizationManagementState(organizations: $organizations, branches: $branches, classes: $classes, children: $children, selectedOrganizationId: $selectedOrganizationId, selectedBranchId: $selectedBranchId, selectedClassId: $selectedClassId)';
}


}

/// @nodoc
abstract mixin class $OrganizationManagementStateCopyWith<$Res>  {
  factory $OrganizationManagementStateCopyWith(OrganizationManagementState value, $Res Function(OrganizationManagementState) _then) = _$OrganizationManagementStateCopyWithImpl;
@useResult
$Res call({
 List<Organization> organizations, List<Branch> branches, List<SchoolClass> classes, List<ChildRecord> children, String? selectedOrganizationId, String? selectedBranchId, String? selectedClassId
});




}
/// @nodoc
class _$OrganizationManagementStateCopyWithImpl<$Res>
    implements $OrganizationManagementStateCopyWith<$Res> {
  _$OrganizationManagementStateCopyWithImpl(this._self, this._then);

  final OrganizationManagementState _self;
  final $Res Function(OrganizationManagementState) _then;

/// Create a copy of OrganizationManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizations = null,Object? branches = null,Object? classes = null,Object? children = null,Object? selectedOrganizationId = freezed,Object? selectedBranchId = freezed,Object? selectedClassId = freezed,}) {
  return _then(OrganizationManagementState(
organizations: null == organizations ? _self.organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<Organization>,branches: null == branches ? _self.branches : branches // ignore: cast_nullable_to_non_nullable
as List<Branch>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<SchoolClass>,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<ChildRecord>,selectedOrganizationId: freezed == selectedOrganizationId ? _self.selectedOrganizationId : selectedOrganizationId // ignore: cast_nullable_to_non_nullable
as String?,selectedBranchId: freezed == selectedBranchId ? _self.selectedBranchId : selectedBranchId // ignore: cast_nullable_to_non_nullable
as String?,selectedClassId: freezed == selectedClassId ? _self.selectedClassId : selectedClassId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizationManagementState].
extension OrganizationManagementStatePatterns on OrganizationManagementState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizationManagementState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizationManagementState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizationManagementState value)  $default,){
final _that = this;
switch (_that) {
case _OrganizationManagementState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizationManagementState value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizationManagementState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Organization> organizations,  List<Branch> branches,  List<SchoolClass> classes,  List<ChildRecord> children,  String? selectedOrganizationId,  String? selectedBranchId,  String? selectedClassId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizationManagementState() when $default != null:
return $default(_that.organizations,_that.branches,_that.classes,_that.children,_that.selectedOrganizationId,_that.selectedBranchId,_that.selectedClassId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Organization> organizations,  List<Branch> branches,  List<SchoolClass> classes,  List<ChildRecord> children,  String? selectedOrganizationId,  String? selectedBranchId,  String? selectedClassId)  $default,) {final _that = this;
switch (_that) {
case _OrganizationManagementState():
return $default(_that.organizations,_that.branches,_that.classes,_that.children,_that.selectedOrganizationId,_that.selectedBranchId,_that.selectedClassId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Organization> organizations,  List<Branch> branches,  List<SchoolClass> classes,  List<ChildRecord> children,  String? selectedOrganizationId,  String? selectedBranchId,  String? selectedClassId)?  $default,) {final _that = this;
switch (_that) {
case _OrganizationManagementState() when $default != null:
return $default(_that.organizations,_that.branches,_that.classes,_that.children,_that.selectedOrganizationId,_that.selectedBranchId,_that.selectedClassId);case _:
  return null;

}
}

}

/// @nodoc


class _OrganizationManagementState implements OrganizationManagementState {
  const _OrganizationManagementState({ List<Organization> organizations = const <Organization>[],  List<Branch> branches = const <Branch>[],  List<SchoolClass> classes = const <SchoolClass>[],  List<ChildRecord> children = const <ChildRecord>[], this.selectedOrganizationId, this.selectedBranchId, this.selectedClassId}): _organizations = organizations,_branches = branches,_classes = classes,_children = children;
  

 final  List<Organization> _organizations;
@override@JsonKey() List<Organization> get organizations {
  if (_organizations is EqualUnmodifiableListView) return _organizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_organizations);
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

 final  List<ChildRecord> _children;
@override@JsonKey() List<ChildRecord> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}

@override final  String? selectedOrganizationId;
@override final  String? selectedBranchId;
@override final  String? selectedClassId;

/// Create a copy of OrganizationManagementState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationManagementStateCopyWith<_OrganizationManagementState> get copyWith => __$OrganizationManagementStateCopyWithImpl<_OrganizationManagementState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizationManagementState&&const DeepCollectionEquality().equals(other._organizations, _organizations)&&const DeepCollectionEquality().equals(other._branches, _branches)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.selectedOrganizationId, selectedOrganizationId) || other.selectedOrganizationId == selectedOrganizationId)&&(identical(other.selectedBranchId, selectedBranchId) || other.selectedBranchId == selectedBranchId)&&(identical(other.selectedClassId, selectedClassId) || other.selectedClassId == selectedClassId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_organizations),const DeepCollectionEquality().hash(_branches),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_children),selectedOrganizationId,selectedBranchId,selectedClassId);

@override
String toString() {
  return 'OrganizationManagementState(organizations: $organizations, branches: $branches, classes: $classes, children: $children, selectedOrganizationId: $selectedOrganizationId, selectedBranchId: $selectedBranchId, selectedClassId: $selectedClassId)';
}


}

/// @nodoc
abstract mixin class _$OrganizationManagementStateCopyWith<$Res> implements $OrganizationManagementStateCopyWith<$Res> {
  factory _$OrganizationManagementStateCopyWith(_OrganizationManagementState value, $Res Function(_OrganizationManagementState) _then) = __$OrganizationManagementStateCopyWithImpl;
@override @useResult
$Res call({
 List<Organization> organizations, List<Branch> branches, List<SchoolClass> classes, List<ChildRecord> children, String? selectedOrganizationId, String? selectedBranchId, String? selectedClassId
});




}
/// @nodoc
class __$OrganizationManagementStateCopyWithImpl<$Res>
    implements _$OrganizationManagementStateCopyWith<$Res> {
  __$OrganizationManagementStateCopyWithImpl(this._self, this._then);

  final _OrganizationManagementState _self;
  final $Res Function(_OrganizationManagementState) _then;

/// Create a copy of OrganizationManagementState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizations = null,Object? branches = null,Object? classes = null,Object? children = null,Object? selectedOrganizationId = freezed,Object? selectedBranchId = freezed,Object? selectedClassId = freezed,}) {
  return _then(_OrganizationManagementState(
organizations: null == organizations ? _self._organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<Organization>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<Branch>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<SchoolClass>,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<ChildRecord>,selectedOrganizationId: freezed == selectedOrganizationId ? _self.selectedOrganizationId : selectedOrganizationId // ignore: cast_nullable_to_non_nullable
as String?,selectedBranchId: freezed == selectedBranchId ? _self.selectedBranchId : selectedBranchId // ignore: cast_nullable_to_non_nullable
as String?,selectedClassId: freezed == selectedClassId ? _self.selectedClassId : selectedClassId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
