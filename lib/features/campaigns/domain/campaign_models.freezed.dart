// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BranchContribution {

 String get branchId; String get branchName; int get count;
/// Create a copy of BranchContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchContributionCopyWith<BranchContribution> get copyWith => _$BranchContributionCopyWithImpl<BranchContribution>(this as BranchContribution, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchContribution&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,branchId,branchName,count);

@override
String toString() {
  return 'BranchContribution(branchId: $branchId, branchName: $branchName, count: $count)';
}


}

/// @nodoc
abstract mixin class $BranchContributionCopyWith<$Res>  {
  factory $BranchContributionCopyWith(BranchContribution value, $Res Function(BranchContribution) _then) = _$BranchContributionCopyWithImpl;
@useResult
$Res call({
 String branchId, String branchName, int count
});




}
/// @nodoc
class _$BranchContributionCopyWithImpl<$Res>
    implements $BranchContributionCopyWith<$Res> {
  _$BranchContributionCopyWithImpl(this._self, this._then);

  final BranchContribution _self;
  final $Res Function(BranchContribution) _then;

/// Create a copy of BranchContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branchId = null,Object? branchName = null,Object? count = null,}) {
  return _then(BranchContribution(
branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BranchContribution].
extension BranchContributionPatterns on BranchContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BranchContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BranchContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BranchContribution value)  $default,){
final _that = this;
switch (_that) {
case _BranchContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BranchContribution value)?  $default,){
final _that = this;
switch (_that) {
case _BranchContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String branchId,  String branchName,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BranchContribution() when $default != null:
return $default(_that.branchId,_that.branchName,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String branchId,  String branchName,  int count)  $default,) {final _that = this;
switch (_that) {
case _BranchContribution():
return $default(_that.branchId,_that.branchName,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String branchId,  String branchName,  int count)?  $default,) {final _that = this;
switch (_that) {
case _BranchContribution() when $default != null:
return $default(_that.branchId,_that.branchName,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _BranchContribution implements BranchContribution {
  const _BranchContribution({required this.branchId, required this.branchName, this.count = 0});
  

@override final  String branchId;
@override final  String branchName;
@override@JsonKey() final  int count;

/// Create a copy of BranchContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchContributionCopyWith<_BranchContribution> get copyWith => __$BranchContributionCopyWithImpl<_BranchContribution>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchContribution&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,branchId,branchName,count);

@override
String toString() {
  return 'BranchContribution(branchId: $branchId, branchName: $branchName, count: $count)';
}


}

/// @nodoc
abstract mixin class _$BranchContributionCopyWith<$Res> implements $BranchContributionCopyWith<$Res> {
  factory _$BranchContributionCopyWith(_BranchContribution value, $Res Function(_BranchContribution) _then) = __$BranchContributionCopyWithImpl;
@override @useResult
$Res call({
 String branchId, String branchName, int count
});




}
/// @nodoc
class __$BranchContributionCopyWithImpl<$Res>
    implements _$BranchContributionCopyWith<$Res> {
  __$BranchContributionCopyWithImpl(this._self, this._then);

  final _BranchContribution _self;
  final $Res Function(_BranchContribution) _then;

/// Create a copy of BranchContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branchId = null,Object? branchName = null,Object? count = null,}) {
  return _then(_BranchContribution(
branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,branchName: null == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CategoryContribution {

 ManagedUserType get category; int get count;
/// Create a copy of CategoryContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryContributionCopyWith<CategoryContribution> get copyWith => _$CategoryContributionCopyWithImpl<CategoryContribution>(this as CategoryContribution, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryContribution&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,category,count);

@override
String toString() {
  return 'CategoryContribution(category: $category, count: $count)';
}


}

/// @nodoc
abstract mixin class $CategoryContributionCopyWith<$Res>  {
  factory $CategoryContributionCopyWith(CategoryContribution value, $Res Function(CategoryContribution) _then) = _$CategoryContributionCopyWithImpl;
@useResult
$Res call({
 ManagedUserType category, int count
});




}
/// @nodoc
class _$CategoryContributionCopyWithImpl<$Res>
    implements $CategoryContributionCopyWith<$Res> {
  _$CategoryContributionCopyWithImpl(this._self, this._then);

  final CategoryContribution _self;
  final $Res Function(CategoryContribution) _then;

/// Create a copy of CategoryContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? count = null,}) {
  return _then(CategoryContribution(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ManagedUserType,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryContribution].
extension CategoryContributionPatterns on CategoryContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryContribution value)  $default,){
final _that = this;
switch (_that) {
case _CategoryContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryContribution value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ManagedUserType category,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryContribution() when $default != null:
return $default(_that.category,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ManagedUserType category,  int count)  $default,) {final _that = this;
switch (_that) {
case _CategoryContribution():
return $default(_that.category,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ManagedUserType category,  int count)?  $default,) {final _that = this;
switch (_that) {
case _CategoryContribution() when $default != null:
return $default(_that.category,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryContribution implements CategoryContribution {
  const _CategoryContribution({required this.category, this.count = 0});
  

@override final  ManagedUserType category;
@override@JsonKey() final  int count;

/// Create a copy of CategoryContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryContributionCopyWith<_CategoryContribution> get copyWith => __$CategoryContributionCopyWithImpl<_CategoryContribution>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryContribution&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,category,count);

@override
String toString() {
  return 'CategoryContribution(category: $category, count: $count)';
}


}

/// @nodoc
abstract mixin class _$CategoryContributionCopyWith<$Res> implements $CategoryContributionCopyWith<$Res> {
  factory _$CategoryContributionCopyWith(_CategoryContribution value, $Res Function(_CategoryContribution) _then) = __$CategoryContributionCopyWithImpl;
@override @useResult
$Res call({
 ManagedUserType category, int count
});




}
/// @nodoc
class __$CategoryContributionCopyWithImpl<$Res>
    implements _$CategoryContributionCopyWith<$Res> {
  __$CategoryContributionCopyWithImpl(this._self, this._then);

  final _CategoryContribution _self;
  final $Res Function(_CategoryContribution) _then;

/// Create a copy of CategoryContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? count = null,}) {
  return _then(_CategoryContribution(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ManagedUserType,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CampaignDashboardItem {

 String get id; String get name; String get dhikrTitle; int get targetCount; int get currentCount; CampaignStatus get status; List<BranchContribution> get branchContributions; List<CategoryContribution> get categoryContributions;
/// Create a copy of CampaignDashboardItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignDashboardItemCopyWith<CampaignDashboardItem> get copyWith => _$CampaignDashboardItemCopyWithImpl<CampaignDashboardItem>(this as CampaignDashboardItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignDashboardItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dhikrTitle, dhikrTitle) || other.dhikrTitle == dhikrTitle)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.currentCount, currentCount) || other.currentCount == currentCount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.branchContributions, branchContributions)&&const DeepCollectionEquality().equals(other.categoryContributions, categoryContributions));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,dhikrTitle,targetCount,currentCount,status,const DeepCollectionEquality().hash(branchContributions),const DeepCollectionEquality().hash(categoryContributions));

@override
String toString() {
  return 'CampaignDashboardItem(id: $id, name: $name, dhikrTitle: $dhikrTitle, targetCount: $targetCount, currentCount: $currentCount, status: $status, branchContributions: $branchContributions, categoryContributions: $categoryContributions)';
}


}

/// @nodoc
abstract mixin class $CampaignDashboardItemCopyWith<$Res>  {
  factory $CampaignDashboardItemCopyWith(CampaignDashboardItem value, $Res Function(CampaignDashboardItem) _then) = _$CampaignDashboardItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String dhikrTitle, int targetCount, int currentCount, CampaignStatus status, List<BranchContribution> branchContributions, List<CategoryContribution> categoryContributions
});




}
/// @nodoc
class _$CampaignDashboardItemCopyWithImpl<$Res>
    implements $CampaignDashboardItemCopyWith<$Res> {
  _$CampaignDashboardItemCopyWithImpl(this._self, this._then);

  final CampaignDashboardItem _self;
  final $Res Function(CampaignDashboardItem) _then;

/// Create a copy of CampaignDashboardItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? dhikrTitle = null,Object? targetCount = null,Object? currentCount = null,Object? status = null,Object? branchContributions = null,Object? categoryContributions = null,}) {
  return _then(CampaignDashboardItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dhikrTitle: null == dhikrTitle ? _self.dhikrTitle : dhikrTitle // ignore: cast_nullable_to_non_nullable
as String,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,currentCount: null == currentCount ? _self.currentCount : currentCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,branchContributions: null == branchContributions ? _self.branchContributions : branchContributions // ignore: cast_nullable_to_non_nullable
as List<BranchContribution>,categoryContributions: null == categoryContributions ? _self.categoryContributions : categoryContributions // ignore: cast_nullable_to_non_nullable
as List<CategoryContribution>,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignDashboardItem].
extension CampaignDashboardItemPatterns on CampaignDashboardItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignDashboardItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignDashboardItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignDashboardItem value)  $default,){
final _that = this;
switch (_that) {
case _CampaignDashboardItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignDashboardItem value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignDashboardItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String dhikrTitle,  int targetCount,  int currentCount,  CampaignStatus status,  List<BranchContribution> branchContributions,  List<CategoryContribution> categoryContributions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignDashboardItem() when $default != null:
return $default(_that.id,_that.name,_that.dhikrTitle,_that.targetCount,_that.currentCount,_that.status,_that.branchContributions,_that.categoryContributions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String dhikrTitle,  int targetCount,  int currentCount,  CampaignStatus status,  List<BranchContribution> branchContributions,  List<CategoryContribution> categoryContributions)  $default,) {final _that = this;
switch (_that) {
case _CampaignDashboardItem():
return $default(_that.id,_that.name,_that.dhikrTitle,_that.targetCount,_that.currentCount,_that.status,_that.branchContributions,_that.categoryContributions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String dhikrTitle,  int targetCount,  int currentCount,  CampaignStatus status,  List<BranchContribution> branchContributions,  List<CategoryContribution> categoryContributions)?  $default,) {final _that = this;
switch (_that) {
case _CampaignDashboardItem() when $default != null:
return $default(_that.id,_that.name,_that.dhikrTitle,_that.targetCount,_that.currentCount,_that.status,_that.branchContributions,_that.categoryContributions);case _:
  return null;

}
}

}

/// @nodoc


class _CampaignDashboardItem implements CampaignDashboardItem {
  const _CampaignDashboardItem({required this.id, required this.name, required this.dhikrTitle, required this.targetCount, required this.currentCount, required this.status,  List<BranchContribution> branchContributions = const <BranchContribution>[],  List<CategoryContribution> categoryContributions = const <CategoryContribution>[]}): _branchContributions = branchContributions,_categoryContributions = categoryContributions;
  

@override final  String id;
@override final  String name;
@override final  String dhikrTitle;
@override final  int targetCount;
@override final  int currentCount;
@override final  CampaignStatus status;
 final  List<BranchContribution> _branchContributions;
@override@JsonKey() List<BranchContribution> get branchContributions {
  if (_branchContributions is EqualUnmodifiableListView) return _branchContributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branchContributions);
}

 final  List<CategoryContribution> _categoryContributions;
@override@JsonKey() List<CategoryContribution> get categoryContributions {
  if (_categoryContributions is EqualUnmodifiableListView) return _categoryContributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryContributions);
}


/// Create a copy of CampaignDashboardItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignDashboardItemCopyWith<_CampaignDashboardItem> get copyWith => __$CampaignDashboardItemCopyWithImpl<_CampaignDashboardItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignDashboardItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dhikrTitle, dhikrTitle) || other.dhikrTitle == dhikrTitle)&&(identical(other.targetCount, targetCount) || other.targetCount == targetCount)&&(identical(other.currentCount, currentCount) || other.currentCount == currentCount)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._branchContributions, _branchContributions)&&const DeepCollectionEquality().equals(other._categoryContributions, _categoryContributions));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,dhikrTitle,targetCount,currentCount,status,const DeepCollectionEquality().hash(_branchContributions),const DeepCollectionEquality().hash(_categoryContributions));

@override
String toString() {
  return 'CampaignDashboardItem(id: $id, name: $name, dhikrTitle: $dhikrTitle, targetCount: $targetCount, currentCount: $currentCount, status: $status, branchContributions: $branchContributions, categoryContributions: $categoryContributions)';
}


}

/// @nodoc
abstract mixin class _$CampaignDashboardItemCopyWith<$Res> implements $CampaignDashboardItemCopyWith<$Res> {
  factory _$CampaignDashboardItemCopyWith(_CampaignDashboardItem value, $Res Function(_CampaignDashboardItem) _then) = __$CampaignDashboardItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String dhikrTitle, int targetCount, int currentCount, CampaignStatus status, List<BranchContribution> branchContributions, List<CategoryContribution> categoryContributions
});




}
/// @nodoc
class __$CampaignDashboardItemCopyWithImpl<$Res>
    implements _$CampaignDashboardItemCopyWith<$Res> {
  __$CampaignDashboardItemCopyWithImpl(this._self, this._then);

  final _CampaignDashboardItem _self;
  final $Res Function(_CampaignDashboardItem) _then;

/// Create a copy of CampaignDashboardItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? dhikrTitle = null,Object? targetCount = null,Object? currentCount = null,Object? status = null,Object? branchContributions = null,Object? categoryContributions = null,}) {
  return _then(_CampaignDashboardItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dhikrTitle: null == dhikrTitle ? _self.dhikrTitle : dhikrTitle // ignore: cast_nullable_to_non_nullable
as String,targetCount: null == targetCount ? _self.targetCount : targetCount // ignore: cast_nullable_to_non_nullable
as int,currentCount: null == currentCount ? _self.currentCount : currentCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CampaignStatus,branchContributions: null == branchContributions ? _self._branchContributions : branchContributions // ignore: cast_nullable_to_non_nullable
as List<BranchContribution>,categoryContributions: null == categoryContributions ? _self._categoryContributions : categoryContributions // ignore: cast_nullable_to_non_nullable
as List<CategoryContribution>,
  ));
}


}

/// @nodoc
mixin _$CampaignManagementState {

 List<CampaignDashboardItem> get campaigns; List<DhikrDefinition> get dhikrDefinitions;
/// Create a copy of CampaignManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampaignManagementStateCopyWith<CampaignManagementState> get copyWith => _$CampaignManagementStateCopyWithImpl<CampaignManagementState>(this as CampaignManagementState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampaignManagementState&&const DeepCollectionEquality().equals(other.campaigns, campaigns)&&const DeepCollectionEquality().equals(other.dhikrDefinitions, dhikrDefinitions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(campaigns),const DeepCollectionEquality().hash(dhikrDefinitions));

@override
String toString() {
  return 'CampaignManagementState(campaigns: $campaigns, dhikrDefinitions: $dhikrDefinitions)';
}


}

/// @nodoc
abstract mixin class $CampaignManagementStateCopyWith<$Res>  {
  factory $CampaignManagementStateCopyWith(CampaignManagementState value, $Res Function(CampaignManagementState) _then) = _$CampaignManagementStateCopyWithImpl;
@useResult
$Res call({
 List<CampaignDashboardItem> campaigns, List<DhikrDefinition> dhikrDefinitions
});




}
/// @nodoc
class _$CampaignManagementStateCopyWithImpl<$Res>
    implements $CampaignManagementStateCopyWith<$Res> {
  _$CampaignManagementStateCopyWithImpl(this._self, this._then);

  final CampaignManagementState _self;
  final $Res Function(CampaignManagementState) _then;

/// Create a copy of CampaignManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? campaigns = null,Object? dhikrDefinitions = null,}) {
  return _then(CampaignManagementState(
campaigns: null == campaigns ? _self.campaigns : campaigns // ignore: cast_nullable_to_non_nullable
as List<CampaignDashboardItem>,dhikrDefinitions: null == dhikrDefinitions ? _self.dhikrDefinitions : dhikrDefinitions // ignore: cast_nullable_to_non_nullable
as List<DhikrDefinition>,
  ));
}

}


/// Adds pattern-matching-related methods to [CampaignManagementState].
extension CampaignManagementStatePatterns on CampaignManagementState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampaignManagementState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampaignManagementState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampaignManagementState value)  $default,){
final _that = this;
switch (_that) {
case _CampaignManagementState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampaignManagementState value)?  $default,){
final _that = this;
switch (_that) {
case _CampaignManagementState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CampaignDashboardItem> campaigns,  List<DhikrDefinition> dhikrDefinitions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampaignManagementState() when $default != null:
return $default(_that.campaigns,_that.dhikrDefinitions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CampaignDashboardItem> campaigns,  List<DhikrDefinition> dhikrDefinitions)  $default,) {final _that = this;
switch (_that) {
case _CampaignManagementState():
return $default(_that.campaigns,_that.dhikrDefinitions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CampaignDashboardItem> campaigns,  List<DhikrDefinition> dhikrDefinitions)?  $default,) {final _that = this;
switch (_that) {
case _CampaignManagementState() when $default != null:
return $default(_that.campaigns,_that.dhikrDefinitions);case _:
  return null;

}
}

}

/// @nodoc


class _CampaignManagementState implements CampaignManagementState {
  const _CampaignManagementState({ List<CampaignDashboardItem> campaigns = const <CampaignDashboardItem>[],  List<DhikrDefinition> dhikrDefinitions = const <DhikrDefinition>[]}): _campaigns = campaigns,_dhikrDefinitions = dhikrDefinitions;
  

 final  List<CampaignDashboardItem> _campaigns;
@override@JsonKey() List<CampaignDashboardItem> get campaigns {
  if (_campaigns is EqualUnmodifiableListView) return _campaigns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_campaigns);
}

 final  List<DhikrDefinition> _dhikrDefinitions;
@override@JsonKey() List<DhikrDefinition> get dhikrDefinitions {
  if (_dhikrDefinitions is EqualUnmodifiableListView) return _dhikrDefinitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dhikrDefinitions);
}


/// Create a copy of CampaignManagementState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampaignManagementStateCopyWith<_CampaignManagementState> get copyWith => __$CampaignManagementStateCopyWithImpl<_CampaignManagementState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampaignManagementState&&const DeepCollectionEquality().equals(other._campaigns, _campaigns)&&const DeepCollectionEquality().equals(other._dhikrDefinitions, _dhikrDefinitions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_campaigns),const DeepCollectionEquality().hash(_dhikrDefinitions));

@override
String toString() {
  return 'CampaignManagementState(campaigns: $campaigns, dhikrDefinitions: $dhikrDefinitions)';
}


}

/// @nodoc
abstract mixin class _$CampaignManagementStateCopyWith<$Res> implements $CampaignManagementStateCopyWith<$Res> {
  factory _$CampaignManagementStateCopyWith(_CampaignManagementState value, $Res Function(_CampaignManagementState) _then) = __$CampaignManagementStateCopyWithImpl;
@override @useResult
$Res call({
 List<CampaignDashboardItem> campaigns, List<DhikrDefinition> dhikrDefinitions
});




}
/// @nodoc
class __$CampaignManagementStateCopyWithImpl<$Res>
    implements _$CampaignManagementStateCopyWith<$Res> {
  __$CampaignManagementStateCopyWithImpl(this._self, this._then);

  final _CampaignManagementState _self;
  final $Res Function(_CampaignManagementState) _then;

/// Create a copy of CampaignManagementState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? campaigns = null,Object? dhikrDefinitions = null,}) {
  return _then(_CampaignManagementState(
campaigns: null == campaigns ? _self._campaigns : campaigns // ignore: cast_nullable_to_non_nullable
as List<CampaignDashboardItem>,dhikrDefinitions: null == dhikrDefinitions ? _self._dhikrDefinitions : dhikrDefinitions // ignore: cast_nullable_to_non_nullable
as List<DhikrDefinition>,
  ));
}


}

// dart format on
