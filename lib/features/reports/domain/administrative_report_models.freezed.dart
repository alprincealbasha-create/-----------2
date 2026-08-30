// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'administrative_report_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportFilterOption {

 String get id; String get label; String? get branchId; String? get classId; ManagedUserType? get role;
/// Create a copy of ReportFilterOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportFilterOptionCopyWith<ReportFilterOption> get copyWith => _$ReportFilterOptionCopyWithImpl<ReportFilterOption>(this as ReportFilterOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportFilterOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,branchId,classId,role);

@override
String toString() {
  return 'ReportFilterOption(id: $id, label: $label, branchId: $branchId, classId: $classId, role: $role)';
}


}

/// @nodoc
abstract mixin class $ReportFilterOptionCopyWith<$Res>  {
  factory $ReportFilterOptionCopyWith(ReportFilterOption value, $Res Function(ReportFilterOption) _then) = _$ReportFilterOptionCopyWithImpl;
@useResult
$Res call({
 String id, String label, String? branchId, String? classId, ManagedUserType? role
});




}
/// @nodoc
class _$ReportFilterOptionCopyWithImpl<$Res>
    implements $ReportFilterOptionCopyWith<$Res> {
  _$ReportFilterOptionCopyWithImpl(this._self, this._then);

  final ReportFilterOption _self;
  final $Res Function(ReportFilterOption) _then;

/// Create a copy of ReportFilterOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? branchId = freezed,Object? classId = freezed,Object? role = freezed,}) {
  return _then(ReportFilterOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ManagedUserType?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportFilterOption].
extension ReportFilterOptionPatterns on ReportFilterOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportFilterOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportFilterOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportFilterOption value)  $default,){
final _that = this;
switch (_that) {
case _ReportFilterOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportFilterOption value)?  $default,){
final _that = this;
switch (_that) {
case _ReportFilterOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String? branchId,  String? classId,  ManagedUserType? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportFilterOption() when $default != null:
return $default(_that.id,_that.label,_that.branchId,_that.classId,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String? branchId,  String? classId,  ManagedUserType? role)  $default,) {final _that = this;
switch (_that) {
case _ReportFilterOption():
return $default(_that.id,_that.label,_that.branchId,_that.classId,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String? branchId,  String? classId,  ManagedUserType? role)?  $default,) {final _that = this;
switch (_that) {
case _ReportFilterOption() when $default != null:
return $default(_that.id,_that.label,_that.branchId,_that.classId,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _ReportFilterOption implements ReportFilterOption {
  const _ReportFilterOption({required this.id, required this.label, this.branchId, this.classId, this.role});
  

@override final  String id;
@override final  String label;
@override final  String? branchId;
@override final  String? classId;
@override final  ManagedUserType? role;

/// Create a copy of ReportFilterOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportFilterOptionCopyWith<_ReportFilterOption> get copyWith => __$ReportFilterOptionCopyWithImpl<_ReportFilterOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportFilterOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,branchId,classId,role);

@override
String toString() {
  return 'ReportFilterOption(id: $id, label: $label, branchId: $branchId, classId: $classId, role: $role)';
}


}

/// @nodoc
abstract mixin class _$ReportFilterOptionCopyWith<$Res> implements $ReportFilterOptionCopyWith<$Res> {
  factory _$ReportFilterOptionCopyWith(_ReportFilterOption value, $Res Function(_ReportFilterOption) _then) = __$ReportFilterOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String? branchId, String? classId, ManagedUserType? role
});




}
/// @nodoc
class __$ReportFilterOptionCopyWithImpl<$Res>
    implements _$ReportFilterOptionCopyWith<$Res> {
  __$ReportFilterOptionCopyWithImpl(this._self, this._then);

  final _ReportFilterOption _self;
  final $Res Function(_ReportFilterOption) _then;

/// Create a copy of ReportFilterOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? branchId = freezed,Object? classId = freezed,Object? role = freezed,}) {
  return _then(_ReportFilterOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ManagedUserType?,
  ));
}


}

/// @nodoc
mixin _$AdministrativeReportOptions {

 List<ReportFilterOption> get branches; List<ReportFilterOption> get classes; List<ReportFilterOption> get users; List<ReportFilterOption> get wirds; List<ReportFilterOption> get dhikrs;
/// Create a copy of AdministrativeReportOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdministrativeReportOptionsCopyWith<AdministrativeReportOptions> get copyWith => _$AdministrativeReportOptionsCopyWithImpl<AdministrativeReportOptions>(this as AdministrativeReportOptions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdministrativeReportOptions&&const DeepCollectionEquality().equals(other.branches, branches)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.users, users)&&const DeepCollectionEquality().equals(other.wirds, wirds)&&const DeepCollectionEquality().equals(other.dhikrs, dhikrs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(branches),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(users),const DeepCollectionEquality().hash(wirds),const DeepCollectionEquality().hash(dhikrs));

@override
String toString() {
  return 'AdministrativeReportOptions(branches: $branches, classes: $classes, users: $users, wirds: $wirds, dhikrs: $dhikrs)';
}


}

/// @nodoc
abstract mixin class $AdministrativeReportOptionsCopyWith<$Res>  {
  factory $AdministrativeReportOptionsCopyWith(AdministrativeReportOptions value, $Res Function(AdministrativeReportOptions) _then) = _$AdministrativeReportOptionsCopyWithImpl;
@useResult
$Res call({
 List<ReportFilterOption> branches, List<ReportFilterOption> classes, List<ReportFilterOption> users, List<ReportFilterOption> wirds, List<ReportFilterOption> dhikrs
});




}
/// @nodoc
class _$AdministrativeReportOptionsCopyWithImpl<$Res>
    implements $AdministrativeReportOptionsCopyWith<$Res> {
  _$AdministrativeReportOptionsCopyWithImpl(this._self, this._then);

  final AdministrativeReportOptions _self;
  final $Res Function(AdministrativeReportOptions) _then;

/// Create a copy of AdministrativeReportOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branches = null,Object? classes = null,Object? users = null,Object? wirds = null,Object? dhikrs = null,}) {
  return _then(AdministrativeReportOptions(
branches: null == branches ? _self.branches : branches // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,wirds: null == wirds ? _self.wirds : wirds // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,dhikrs: null == dhikrs ? _self.dhikrs : dhikrs // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdministrativeReportOptions].
extension AdministrativeReportOptionsPatterns on AdministrativeReportOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdministrativeReportOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdministrativeReportOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdministrativeReportOptions value)  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdministrativeReportOptions value)?  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReportFilterOption> branches,  List<ReportFilterOption> classes,  List<ReportFilterOption> users,  List<ReportFilterOption> wirds,  List<ReportFilterOption> dhikrs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdministrativeReportOptions() when $default != null:
return $default(_that.branches,_that.classes,_that.users,_that.wirds,_that.dhikrs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReportFilterOption> branches,  List<ReportFilterOption> classes,  List<ReportFilterOption> users,  List<ReportFilterOption> wirds,  List<ReportFilterOption> dhikrs)  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportOptions():
return $default(_that.branches,_that.classes,_that.users,_that.wirds,_that.dhikrs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReportFilterOption> branches,  List<ReportFilterOption> classes,  List<ReportFilterOption> users,  List<ReportFilterOption> wirds,  List<ReportFilterOption> dhikrs)?  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportOptions() when $default != null:
return $default(_that.branches,_that.classes,_that.users,_that.wirds,_that.dhikrs);case _:
  return null;

}
}

}

/// @nodoc


class _AdministrativeReportOptions implements AdministrativeReportOptions {
  const _AdministrativeReportOptions({ List<ReportFilterOption> branches = const <ReportFilterOption>[],  List<ReportFilterOption> classes = const <ReportFilterOption>[],  List<ReportFilterOption> users = const <ReportFilterOption>[],  List<ReportFilterOption> wirds = const <ReportFilterOption>[],  List<ReportFilterOption> dhikrs = const <ReportFilterOption>[]}): _branches = branches,_classes = classes,_users = users,_wirds = wirds,_dhikrs = dhikrs;
  

 final  List<ReportFilterOption> _branches;
@override@JsonKey() List<ReportFilterOption> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

 final  List<ReportFilterOption> _classes;
@override@JsonKey() List<ReportFilterOption> get classes {
  if (_classes is EqualUnmodifiableListView) return _classes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classes);
}

 final  List<ReportFilterOption> _users;
@override@JsonKey() List<ReportFilterOption> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

 final  List<ReportFilterOption> _wirds;
@override@JsonKey() List<ReportFilterOption> get wirds {
  if (_wirds is EqualUnmodifiableListView) return _wirds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wirds);
}

 final  List<ReportFilterOption> _dhikrs;
@override@JsonKey() List<ReportFilterOption> get dhikrs {
  if (_dhikrs is EqualUnmodifiableListView) return _dhikrs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dhikrs);
}


/// Create a copy of AdministrativeReportOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdministrativeReportOptionsCopyWith<_AdministrativeReportOptions> get copyWith => __$AdministrativeReportOptionsCopyWithImpl<_AdministrativeReportOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdministrativeReportOptions&&const DeepCollectionEquality().equals(other._branches, _branches)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._users, _users)&&const DeepCollectionEquality().equals(other._wirds, _wirds)&&const DeepCollectionEquality().equals(other._dhikrs, _dhikrs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_branches),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_users),const DeepCollectionEquality().hash(_wirds),const DeepCollectionEquality().hash(_dhikrs));

@override
String toString() {
  return 'AdministrativeReportOptions(branches: $branches, classes: $classes, users: $users, wirds: $wirds, dhikrs: $dhikrs)';
}


}

/// @nodoc
abstract mixin class _$AdministrativeReportOptionsCopyWith<$Res> implements $AdministrativeReportOptionsCopyWith<$Res> {
  factory _$AdministrativeReportOptionsCopyWith(_AdministrativeReportOptions value, $Res Function(_AdministrativeReportOptions) _then) = __$AdministrativeReportOptionsCopyWithImpl;
@override @useResult
$Res call({
 List<ReportFilterOption> branches, List<ReportFilterOption> classes, List<ReportFilterOption> users, List<ReportFilterOption> wirds, List<ReportFilterOption> dhikrs
});




}
/// @nodoc
class __$AdministrativeReportOptionsCopyWithImpl<$Res>
    implements _$AdministrativeReportOptionsCopyWith<$Res> {
  __$AdministrativeReportOptionsCopyWithImpl(this._self, this._then);

  final _AdministrativeReportOptions _self;
  final $Res Function(_AdministrativeReportOptions) _then;

/// Create a copy of AdministrativeReportOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branches = null,Object? classes = null,Object? users = null,Object? wirds = null,Object? dhikrs = null,}) {
  return _then(_AdministrativeReportOptions(
branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,wirds: null == wirds ? _self._wirds : wirds // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,dhikrs: null == dhikrs ? _self._dhikrs : dhikrs // ignore: cast_nullable_to_non_nullable
as List<ReportFilterOption>,
  ));
}


}

/// @nodoc
mixin _$AdministrativeReportFilters {

 DateTime get startDate; DateTime get endDate; AdministrativeReportView get view; String? get branchId; String? get classId; ManagedUserType? get role; String? get userId; String? get wirdId; String? get dhikrId; ReportCompletionStatus? get completionStatus;
/// Create a copy of AdministrativeReportFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdministrativeReportFiltersCopyWith<AdministrativeReportFilters> get copyWith => _$AdministrativeReportFiltersCopyWithImpl<AdministrativeReportFilters>(this as AdministrativeReportFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdministrativeReportFilters&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.view, view) || other.view == view)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.role, role) || other.role == role)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.wirdId, wirdId) || other.wirdId == wirdId)&&(identical(other.dhikrId, dhikrId) || other.dhikrId == dhikrId)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,view,branchId,classId,role,userId,wirdId,dhikrId,completionStatus);

@override
String toString() {
  return 'AdministrativeReportFilters(startDate: $startDate, endDate: $endDate, view: $view, branchId: $branchId, classId: $classId, role: $role, userId: $userId, wirdId: $wirdId, dhikrId: $dhikrId, completionStatus: $completionStatus)';
}


}

/// @nodoc
abstract mixin class $AdministrativeReportFiltersCopyWith<$Res>  {
  factory $AdministrativeReportFiltersCopyWith(AdministrativeReportFilters value, $Res Function(AdministrativeReportFilters) _then) = _$AdministrativeReportFiltersCopyWithImpl;
@useResult
$Res call({
 DateTime startDate, DateTime endDate, AdministrativeReportView view, String? branchId, String? classId, ManagedUserType? role, String? userId, String? wirdId, String? dhikrId, ReportCompletionStatus? completionStatus
});




}
/// @nodoc
class _$AdministrativeReportFiltersCopyWithImpl<$Res>
    implements $AdministrativeReportFiltersCopyWith<$Res> {
  _$AdministrativeReportFiltersCopyWithImpl(this._self, this._then);

  final AdministrativeReportFilters _self;
  final $Res Function(AdministrativeReportFilters) _then;

/// Create a copy of AdministrativeReportFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = null,Object? endDate = null,Object? view = null,Object? branchId = freezed,Object? classId = freezed,Object? role = freezed,Object? userId = freezed,Object? wirdId = freezed,Object? dhikrId = freezed,Object? completionStatus = freezed,}) {
  return _then(AdministrativeReportFilters(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as AdministrativeReportView,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ManagedUserType?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,wirdId: freezed == wirdId ? _self.wirdId : wirdId // ignore: cast_nullable_to_non_nullable
as String?,dhikrId: freezed == dhikrId ? _self.dhikrId : dhikrId // ignore: cast_nullable_to_non_nullable
as String?,completionStatus: freezed == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as ReportCompletionStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdministrativeReportFilters].
extension AdministrativeReportFiltersPatterns on AdministrativeReportFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdministrativeReportFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdministrativeReportFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdministrativeReportFilters value)  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdministrativeReportFilters value)?  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  AdministrativeReportView view,  String? branchId,  String? classId,  ManagedUserType? role,  String? userId,  String? wirdId,  String? dhikrId,  ReportCompletionStatus? completionStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdministrativeReportFilters() when $default != null:
return $default(_that.startDate,_that.endDate,_that.view,_that.branchId,_that.classId,_that.role,_that.userId,_that.wirdId,_that.dhikrId,_that.completionStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  AdministrativeReportView view,  String? branchId,  String? classId,  ManagedUserType? role,  String? userId,  String? wirdId,  String? dhikrId,  ReportCompletionStatus? completionStatus)  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportFilters():
return $default(_that.startDate,_that.endDate,_that.view,_that.branchId,_that.classId,_that.role,_that.userId,_that.wirdId,_that.dhikrId,_that.completionStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startDate,  DateTime endDate,  AdministrativeReportView view,  String? branchId,  String? classId,  ManagedUserType? role,  String? userId,  String? wirdId,  String? dhikrId,  ReportCompletionStatus? completionStatus)?  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportFilters() when $default != null:
return $default(_that.startDate,_that.endDate,_that.view,_that.branchId,_that.classId,_that.role,_that.userId,_that.wirdId,_that.dhikrId,_that.completionStatus);case _:
  return null;

}
}

}

/// @nodoc


class _AdministrativeReportFilters implements AdministrativeReportFilters {
  const _AdministrativeReportFilters({required this.startDate, required this.endDate, this.view = AdministrativeReportView.daily, this.branchId, this.classId, this.role, this.userId, this.wirdId, this.dhikrId, this.completionStatus});
  

@override final  DateTime startDate;
@override final  DateTime endDate;
@override@JsonKey() final  AdministrativeReportView view;
@override final  String? branchId;
@override final  String? classId;
@override final  ManagedUserType? role;
@override final  String? userId;
@override final  String? wirdId;
@override final  String? dhikrId;
@override final  ReportCompletionStatus? completionStatus;

/// Create a copy of AdministrativeReportFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdministrativeReportFiltersCopyWith<_AdministrativeReportFilters> get copyWith => __$AdministrativeReportFiltersCopyWithImpl<_AdministrativeReportFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdministrativeReportFilters&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.view, view) || other.view == view)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.role, role) || other.role == role)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.wirdId, wirdId) || other.wirdId == wirdId)&&(identical(other.dhikrId, dhikrId) || other.dhikrId == dhikrId)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,view,branchId,classId,role,userId,wirdId,dhikrId,completionStatus);

@override
String toString() {
  return 'AdministrativeReportFilters(startDate: $startDate, endDate: $endDate, view: $view, branchId: $branchId, classId: $classId, role: $role, userId: $userId, wirdId: $wirdId, dhikrId: $dhikrId, completionStatus: $completionStatus)';
}


}

/// @nodoc
abstract mixin class _$AdministrativeReportFiltersCopyWith<$Res> implements $AdministrativeReportFiltersCopyWith<$Res> {
  factory _$AdministrativeReportFiltersCopyWith(_AdministrativeReportFilters value, $Res Function(_AdministrativeReportFilters) _then) = __$AdministrativeReportFiltersCopyWithImpl;
@override @useResult
$Res call({
 DateTime startDate, DateTime endDate, AdministrativeReportView view, String? branchId, String? classId, ManagedUserType? role, String? userId, String? wirdId, String? dhikrId, ReportCompletionStatus? completionStatus
});




}
/// @nodoc
class __$AdministrativeReportFiltersCopyWithImpl<$Res>
    implements _$AdministrativeReportFiltersCopyWith<$Res> {
  __$AdministrativeReportFiltersCopyWithImpl(this._self, this._then);

  final _AdministrativeReportFilters _self;
  final $Res Function(_AdministrativeReportFilters) _then;

/// Create a copy of AdministrativeReportFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,Object? view = null,Object? branchId = freezed,Object? classId = freezed,Object? role = freezed,Object? userId = freezed,Object? wirdId = freezed,Object? dhikrId = freezed,Object? completionStatus = freezed,}) {
  return _then(_AdministrativeReportFilters(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as AdministrativeReportView,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ManagedUserType?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,wirdId: freezed == wirdId ? _self.wirdId : wirdId // ignore: cast_nullable_to_non_nullable
as String?,dhikrId: freezed == dhikrId ? _self.dhikrId : dhikrId // ignore: cast_nullable_to_non_nullable
as String?,completionStatus: freezed == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as ReportCompletionStatus?,
  ));
}


}

/// @nodoc
mixin _$AdministrativeReportRow {

 String get assignmentId; DateTime get activityDate; String get branchId; String get branchName; String? get classId; String? get className; String get userId; String get userName; ManagedUserType get userRole; String? get wirdId; String get wirdName; String? get dhikrId; String get dhikrTitle; int get currentCount; int get targetCount; ReportCompletionStatus get completionStatus; DateTime? get completedAt;
/// Create a copy of AdministrativeReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdministrativeReportRowCopyWith<AdministrativeReportRow> get copyWith => _$AdministrativeReportRowCopyWithImpl<AdministrativeReportRow>(this as AdministrativeReportRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdministrativeReportRow&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.activityDate, activityDate) || other.activityDate == activityDate)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.className, className) || other.className == className)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userRole, userRole) || other.userRole == userRole)&&(identical(other.wirdId, wirdId) || other.wirdId == wirdId)&&(identical(other.wirdName, wirdName) || other.wirdName == wirdName)&&(identical(other.dhikrId, dhikrId) || other.dhikrId == dhikrId)&&(identical(other.dhikrTitle, dhikrTitle) || other.dhikrTitle == dhikrTitle)&&(identical(other.currentCount, currentCount) || other.currentCount == currentCount)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,assignmentId,activityDate,branchId,branchName,classId,className,userId,userName,userRole,wirdId,wirdName,dhikrId,dhikrTitle,currentCount,targetCount,completionStatus,completedAt);

@override
String toString() {
  return 'AdministrativeReportRow(assignmentId: $assignmentId, activityDate: $activityDate, branchId: $branchId, branchName: $branchName, classId: $classId, className: $className, userId: $userId, userName: $userName, userRole: $userRole, wirdId: $wirdId, wirdName: $wirdName, dhikrId: $dhikrId, dhikrTitle: $dhikrTitle, currentCount: $currentCount, targetCount: $targetCount, completionStatus: $completionStatus, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $AdministrativeReportRowCopyWith<$Res>  {
  factory $AdministrativeReportRowCopyWith(AdministrativeReportRow value, $Res Function(AdministrativeReportRow) _then) = _$AdministrativeReportRowCopyWithImpl;
@useResult
$Res call({
 String assignmentId, DateTime activityDate, String branchId, String branchName, String? classId, String? className, String userId, String userName, ManagedUserType userRole, String? wirdId, String wirdName, String? dhikrId, String dhikrTitle, int currentCount, int targetCount, ReportCompletionStatus completionStatus, DateTime? completedAt
});




}
/// @nodoc
class _$AdministrativeReportRowCopyWithImpl<$Res>
    implements $AdministrativeReportRowCopyWith<$Res> {
  _$AdministrativeReportRowCopyWithImpl(this._self, this._then);

  final AdministrativeReportRow _self;
  final $Res Function(AdministrativeReportRow) _then;

/// Create a copy of AdministrativeReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assignmentId = null,Object? activityDate = null,Object? branchId = null,Object? branchName = null,Object? classId = freezed,Object? className = freezed,Object? userId = null,Object? userName = null,Object? userRole = null,Object? wirdId = freezed,Object? wirdName = null,Object? dhikrId = freezed,Object? dhikrTitle = null,Object? currentCount = null,Object? targetCount = null,Object? completionStatus = null,Object? completedAt = freezed,}) {
  return _then(AdministrativeReportRow(
assignmentId: null == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String,activityDate: null == activityDate ? _self.activityDate : activityDate // ignore: cast_nullable_to_non_nullable
as DateTime,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as ManagedUserType,wirdId: freezed == wirdId ? _self.wirdId : wirdId // ignore: cast_nullable_to_non_nullable
as String?,wirdName: null == wirdName ? _self.wirdName : wirdName // ignore: cast_nullable_to_non_nullable
as String,dhikrId: freezed == dhikrId ? _self.dhikrId : dhikrId // ignore: cast_nullable_to_non_nullable
as String?,dhikrTitle: null == dhikrTitle ? _self.dhikrTitle : dhikrTitle // ignore: cast_nullable_to_non_nullable
as String,currentCount: null == currentCount ? _self.currentCount : currentCount // ignore: cast_nullable_to_non_nullable
as int,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as ReportCompletionStatus,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdministrativeReportRow].
extension AdministrativeReportRowPatterns on AdministrativeReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdministrativeReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdministrativeReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdministrativeReportRow value)  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdministrativeReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assignmentId,  DateTime activityDate,  String branchId,  String branchName,  String? classId,  String? className,  String userId,  String userName,  ManagedUserType userRole,  String? wirdId,  String wirdName,  String? dhikrId,  String dhikrTitle,  int currentCount,  int targetCount,  ReportCompletionStatus completionStatus,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdministrativeReportRow() when $default != null:
return $default(_that.assignmentId,_that.activityDate,_that.branchId,_that.branchName,_that.classId,_that.className,_that.userId,_that.userName,_that.userRole,_that.wirdId,_that.wirdName,_that.dhikrId,_that.dhikrTitle,_that.currentCount,_that.targetCount,_that.completionStatus,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assignmentId,  DateTime activityDate,  String branchId,  String branchName,  String? classId,  String? className,  String userId,  String userName,  ManagedUserType userRole,  String? wirdId,  String wirdName,  String? dhikrId,  String dhikrTitle,  int currentCount,  int targetCount,  ReportCompletionStatus completionStatus,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportRow():
return $default(_that.assignmentId,_that.activityDate,_that.branchId,_that.branchName,_that.classId,_that.className,_that.userId,_that.userName,_that.userRole,_that.wirdId,_that.wirdName,_that.dhikrId,_that.dhikrTitle,_that.currentCount,_that.targetCount,_that.completionStatus,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assignmentId,  DateTime activityDate,  String branchId,  String branchName,  String? classId,  String? className,  String userId,  String userName,  ManagedUserType userRole,  String? wirdId,  String wirdName,  String? dhikrId,  String dhikrTitle,  int currentCount,  int targetCount,  ReportCompletionStatus completionStatus,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportRow() when $default != null:
return $default(_that.assignmentId,_that.activityDate,_that.branchId,_that.branchName,_that.classId,_that.className,_that.userId,_that.userName,_that.userRole,_that.wirdId,_that.wirdName,_that.dhikrId,_that.dhikrTitle,_that.currentCount,_that.targetCount,_that.completionStatus,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _AdministrativeReportRow implements AdministrativeReportRow {
  const _AdministrativeReportRow({required this.assignmentId, required this.activityDate, required this.branchId, required this.branchName, this.classId, this.className, required this.userId, required this.userName, required this.userRole, this.wirdId, required this.wirdName, this.dhikrId, required this.dhikrTitle, required this.currentCount, required this.targetCount, required this.completionStatus, this.completedAt});
  

@override final  String assignmentId;
@override final  DateTime activityDate;
@override final  String branchId;
@override final  String branchName;
@override final  String? classId;
@override final  String? className;
@override final  String userId;
@override final  String userName;
@override final  ManagedUserType userRole;
@override final  String? wirdId;
@override final  String wirdName;
@override final  String? dhikrId;
@override final  String dhikrTitle;
@override final  int currentCount;
@override final  int targetCount;
@override final  ReportCompletionStatus completionStatus;
@override final  DateTime? completedAt;

/// Create a copy of AdministrativeReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdministrativeReportRowCopyWith<_AdministrativeReportRow> get copyWith => __$AdministrativeReportRowCopyWithImpl<_AdministrativeReportRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdministrativeReportRow&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.activityDate, activityDate) || other.activityDate == activityDate)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.classId, classId) || other.classId == classId)&&(identical(other.className, className) || other.className == className)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userRole, userRole) || other.userRole == userRole)&&(identical(other.wirdId, wirdId) || other.wirdId == wirdId)&&(identical(other.wirdName, wirdName) || other.wirdName == wirdName)&&(identical(other.dhikrId, dhikrId) || other.dhikrId == dhikrId)&&(identical(other.dhikrTitle, dhikrTitle) || other.dhikrTitle == dhikrTitle)&&(identical(other.currentCount, currentCount) || other.currentCount == currentCount)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.completionStatus, completionStatus) || other.completionStatus == completionStatus)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,assignmentId,activityDate,branchId,branchName,classId,className,userId,userName,userRole,wirdId,wirdName,dhikrId,dhikrTitle,currentCount,targetCount,completionStatus,completedAt);

@override
String toString() {
  return 'AdministrativeReportRow(assignmentId: $assignmentId, activityDate: $activityDate, branchId: $branchId, branchName: $branchName, classId: $classId, className: $className, userId: $userId, userName: $userName, userRole: $userRole, wirdId: $wirdId, wirdName: $wirdName, dhikrId: $dhikrId, dhikrTitle: $dhikrTitle, currentCount: $currentCount, targetCount: $targetCount, completionStatus: $completionStatus, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$AdministrativeReportRowCopyWith<$Res> implements $AdministrativeReportRowCopyWith<$Res> {
  factory _$AdministrativeReportRowCopyWith(_AdministrativeReportRow value, $Res Function(_AdministrativeReportRow) _then) = __$AdministrativeReportRowCopyWithImpl;
@override @useResult
$Res call({
 String assignmentId, DateTime activityDate, String branchId, String branchName, String? classId, String? className, String userId, String userName, ManagedUserType userRole, String? wirdId, String wirdName, String? dhikrId, String dhikrTitle, int currentCount, int targetCount, ReportCompletionStatus completionStatus, DateTime? completedAt
});




}
/// @nodoc
class __$AdministrativeReportRowCopyWithImpl<$Res>
    implements _$AdministrativeReportRowCopyWith<$Res> {
  __$AdministrativeReportRowCopyWithImpl(this._self, this._then);

  final _AdministrativeReportRow _self;
  final $Res Function(_AdministrativeReportRow) _then;

/// Create a copy of AdministrativeReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assignmentId = null,Object? activityDate = null,Object? branchId = null,Object? branchName = null,Object? classId = freezed,Object? className = freezed,Object? userId = null,Object? userName = null,Object? userRole = null,Object? wirdId = freezed,Object? wirdName = null,Object? dhikrId = freezed,Object? dhikrTitle = null,Object? currentCount = null,Object? targetCount = null,Object? completionStatus = null,Object? completedAt = freezed,}) {
  return _then(_AdministrativeReportRow(
assignmentId: null == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String,activityDate: null == activityDate ? _self.activityDate : activityDate // ignore: cast_nullable_to_non_nullable
as DateTime,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,classId: freezed == classId ? _self.classId : classId // ignore: cast_nullable_to_non_nullable
as String?,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as ManagedUserType,wirdId: freezed == wirdId ? _self.wirdId : wirdId // ignore: cast_nullable_to_non_nullable
as String?,wirdName: null == wirdName ? _self.wirdName : wirdName // ignore: cast_nullable_to_non_nullable
as String,dhikrId: freezed == dhikrId ? _self.dhikrId : dhikrId // ignore: cast_nullable_to_non_nullable
as String?,dhikrTitle: null == dhikrTitle ? _self.dhikrTitle : dhikrTitle // ignore: cast_nullable_to_non_nullable
as String,currentCount: null == currentCount ? _self.currentCount : currentCount // ignore: cast_nullable_to_non_nullable
as int,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,completionStatus: null == completionStatus ? _self.completionStatus : completionStatus // ignore: cast_nullable_to_non_nullable
as ReportCompletionStatus,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$AdministrativeReportData {

 AdministrativeReportOptions get options; AdministrativeReportFilters get filters; List<AdministrativeReportRow> get rows;
/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdministrativeReportDataCopyWith<AdministrativeReportData> get copyWith => _$AdministrativeReportDataCopyWithImpl<AdministrativeReportData>(this as AdministrativeReportData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdministrativeReportData&&(identical(other.options, options) || other.options == options)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other.rows, rows));
}


@override
int get hashCode => Object.hash(runtimeType,options,filters,const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'AdministrativeReportData(options: $options, filters: $filters, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $AdministrativeReportDataCopyWith<$Res>  {
  factory $AdministrativeReportDataCopyWith(AdministrativeReportData value, $Res Function(AdministrativeReportData) _then) = _$AdministrativeReportDataCopyWithImpl;
@useResult
$Res call({
 AdministrativeReportOptions options, AdministrativeReportFilters filters, List<AdministrativeReportRow> rows
});


$AdministrativeReportOptionsCopyWith<$Res> get options;$AdministrativeReportFiltersCopyWith<$Res> get filters;

}
/// @nodoc
class _$AdministrativeReportDataCopyWithImpl<$Res>
    implements $AdministrativeReportDataCopyWith<$Res> {
  _$AdministrativeReportDataCopyWithImpl(this._self, this._then);

  final AdministrativeReportData _self;
  final $Res Function(AdministrativeReportData) _then;

/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,Object? filters = null,Object? rows = null,}) {
  return _then(AdministrativeReportData(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as AdministrativeReportOptions,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as AdministrativeReportFilters,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<AdministrativeReportRow>,
  ));
}
/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdministrativeReportOptionsCopyWith<$Res> get options {
  
  return $AdministrativeReportOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdministrativeReportFiltersCopyWith<$Res> get filters {
  
  return $AdministrativeReportFiltersCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdministrativeReportData].
extension AdministrativeReportDataPatterns on AdministrativeReportData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdministrativeReportData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdministrativeReportData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdministrativeReportData value)  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdministrativeReportData value)?  $default,){
final _that = this;
switch (_that) {
case _AdministrativeReportData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdministrativeReportOptions options,  AdministrativeReportFilters filters,  List<AdministrativeReportRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdministrativeReportData() when $default != null:
return $default(_that.options,_that.filters,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdministrativeReportOptions options,  AdministrativeReportFilters filters,  List<AdministrativeReportRow> rows)  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportData():
return $default(_that.options,_that.filters,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdministrativeReportOptions options,  AdministrativeReportFilters filters,  List<AdministrativeReportRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _AdministrativeReportData() when $default != null:
return $default(_that.options,_that.filters,_that.rows);case _:
  return null;

}
}

}

/// @nodoc


class _AdministrativeReportData implements AdministrativeReportData {
  const _AdministrativeReportData({required this.options, required this.filters,  List<AdministrativeReportRow> rows = const <AdministrativeReportRow>[]}): _rows = rows;
  

@override final  AdministrativeReportOptions options;
@override final  AdministrativeReportFilters filters;
 final  List<AdministrativeReportRow> _rows;
@override@JsonKey() List<AdministrativeReportRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdministrativeReportDataCopyWith<_AdministrativeReportData> get copyWith => __$AdministrativeReportDataCopyWithImpl<_AdministrativeReportData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdministrativeReportData&&(identical(other.options, options) || other.options == options)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other._rows, _rows));
}


@override
int get hashCode => Object.hash(runtimeType,options,filters,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'AdministrativeReportData(options: $options, filters: $filters, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$AdministrativeReportDataCopyWith<$Res> implements $AdministrativeReportDataCopyWith<$Res> {
  factory _$AdministrativeReportDataCopyWith(_AdministrativeReportData value, $Res Function(_AdministrativeReportData) _then) = __$AdministrativeReportDataCopyWithImpl;
@override @useResult
$Res call({
 AdministrativeReportOptions options, AdministrativeReportFilters filters, List<AdministrativeReportRow> rows
});


@override $AdministrativeReportOptionsCopyWith<$Res> get options;@override $AdministrativeReportFiltersCopyWith<$Res> get filters;

}
/// @nodoc
class __$AdministrativeReportDataCopyWithImpl<$Res>
    implements _$AdministrativeReportDataCopyWith<$Res> {
  __$AdministrativeReportDataCopyWithImpl(this._self, this._then);

  final _AdministrativeReportData _self;
  final $Res Function(_AdministrativeReportData) _then;

/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? options = null,Object? filters = null,Object? rows = null,}) {
  return _then(_AdministrativeReportData(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as AdministrativeReportOptions,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as AdministrativeReportFilters,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<AdministrativeReportRow>,
  ));
}

/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdministrativeReportOptionsCopyWith<$Res> get options {
  
  return $AdministrativeReportOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of AdministrativeReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdministrativeReportFiltersCopyWith<$Res> get filters {
  
  return $AdministrativeReportFiltersCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}

// dart format on
