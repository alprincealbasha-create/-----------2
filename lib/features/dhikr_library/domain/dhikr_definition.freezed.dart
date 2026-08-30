// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dhikr_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DhikrDefinition {

 String get id; String get title;@JsonKey(name: 'display_text') String get displayText; String? get description;@JsonKey(name: 'default_target') int get defaultTarget; DhikrDefinitionStatus get status;@JsonKey(name: 'created_by') String get createdBy;@JsonKey(name: 'source_reference') String? get sourceReference;@JsonKey(name: 'content_version') int get contentVersion;@JsonKey(name: 'content_checksum') String? get contentChecksum;@JsonKey(name: 'reviewed_by') String? get reviewedBy;@JsonKey(name: 'reviewed_at') DateTime? get reviewedAt;
/// Create a copy of DhikrDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DhikrDefinitionCopyWith<DhikrDefinition> get copyWith => _$DhikrDefinitionCopyWithImpl<DhikrDefinition>(this as DhikrDefinition, _$identity);

  /// Serializes this DhikrDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DhikrDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.displayText, displayText) || other.displayText == displayText)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultTarget, defaultTarget) || other.defaultTarget == defaultTarget)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.sourceReference, sourceReference) || other.sourceReference == sourceReference)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.contentChecksum, contentChecksum) || other.contentChecksum == contentChecksum)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,displayText,description,defaultTarget,status,createdBy,sourceReference,contentVersion,contentChecksum,reviewedBy,reviewedAt);

@override
String toString() {
  return 'DhikrDefinition(id: $id, title: $title, displayText: $displayText, description: $description, defaultTarget: $defaultTarget, status: $status, createdBy: $createdBy, sourceReference: $sourceReference, contentVersion: $contentVersion, contentChecksum: $contentChecksum, reviewedBy: $reviewedBy, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class $DhikrDefinitionCopyWith<$Res>  {
  factory $DhikrDefinitionCopyWith(DhikrDefinition value, $Res Function(DhikrDefinition) _then) = _$DhikrDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, String title,@JsonKey(name: 'display_text') String displayText, String? description,@JsonKey(name: 'default_target') int defaultTarget, DhikrDefinitionStatus status,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'source_reference') String? sourceReference,@JsonKey(name: 'content_version') int contentVersion,@JsonKey(name: 'content_checksum') String? contentChecksum,@JsonKey(name: 'reviewed_by') String? reviewedBy,@JsonKey(name: 'reviewed_at') DateTime? reviewedAt
});




}
/// @nodoc
class _$DhikrDefinitionCopyWithImpl<$Res>
    implements $DhikrDefinitionCopyWith<$Res> {
  _$DhikrDefinitionCopyWithImpl(this._self, this._then);

  final DhikrDefinition _self;
  final $Res Function(DhikrDefinition) _then;

/// Create a copy of DhikrDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? displayText = null,Object? description = freezed,Object? defaultTarget = null,Object? status = null,Object? createdBy = null,Object? sourceReference = freezed,Object? contentVersion = null,Object? contentChecksum = freezed,Object? reviewedBy = freezed,Object? reviewedAt = freezed,}) {
  return _then(DhikrDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,displayText: null == displayText ? _self.displayText : displayText // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultTarget: null == defaultTarget ? _self.defaultTarget : defaultTarget // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DhikrDefinitionStatus,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,sourceReference: freezed == sourceReference ? _self.sourceReference : sourceReference // ignore: cast_nullable_to_non_nullable
as String?,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as int,contentChecksum: freezed == contentChecksum ? _self.contentChecksum : contentChecksum // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DhikrDefinition].
extension DhikrDefinitionPatterns on DhikrDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DhikrDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DhikrDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DhikrDefinition value)  $default,){
final _that = this;
switch (_that) {
case _DhikrDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DhikrDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _DhikrDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'display_text')  String displayText,  String? description, @JsonKey(name: 'default_target')  int defaultTarget,  DhikrDefinitionStatus status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'source_reference')  String? sourceReference, @JsonKey(name: 'content_version')  int contentVersion, @JsonKey(name: 'content_checksum')  String? contentChecksum, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DhikrDefinition() when $default != null:
return $default(_that.id,_that.title,_that.displayText,_that.description,_that.defaultTarget,_that.status,_that.createdBy,_that.sourceReference,_that.contentVersion,_that.contentChecksum,_that.reviewedBy,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'display_text')  String displayText,  String? description, @JsonKey(name: 'default_target')  int defaultTarget,  DhikrDefinitionStatus status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'source_reference')  String? sourceReference, @JsonKey(name: 'content_version')  int contentVersion, @JsonKey(name: 'content_checksum')  String? contentChecksum, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt)  $default,) {final _that = this;
switch (_that) {
case _DhikrDefinition():
return $default(_that.id,_that.title,_that.displayText,_that.description,_that.defaultTarget,_that.status,_that.createdBy,_that.sourceReference,_that.contentVersion,_that.contentChecksum,_that.reviewedBy,_that.reviewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @JsonKey(name: 'display_text')  String displayText,  String? description, @JsonKey(name: 'default_target')  int defaultTarget,  DhikrDefinitionStatus status, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'source_reference')  String? sourceReference, @JsonKey(name: 'content_version')  int contentVersion, @JsonKey(name: 'content_checksum')  String? contentChecksum, @JsonKey(name: 'reviewed_by')  String? reviewedBy, @JsonKey(name: 'reviewed_at')  DateTime? reviewedAt)?  $default,) {final _that = this;
switch (_that) {
case _DhikrDefinition() when $default != null:
return $default(_that.id,_that.title,_that.displayText,_that.description,_that.defaultTarget,_that.status,_that.createdBy,_that.sourceReference,_that.contentVersion,_that.contentChecksum,_that.reviewedBy,_that.reviewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DhikrDefinition implements DhikrDefinition {
  const _DhikrDefinition({required this.id, required this.title, @JsonKey(name: 'display_text') required this.displayText, this.description, @JsonKey(name: 'default_target') required this.defaultTarget, required this.status, @JsonKey(name: 'created_by') required this.createdBy, @JsonKey(name: 'source_reference') this.sourceReference, @JsonKey(name: 'content_version') this.contentVersion = 1, @JsonKey(name: 'content_checksum') this.contentChecksum, @JsonKey(name: 'reviewed_by') this.reviewedBy, @JsonKey(name: 'reviewed_at') this.reviewedAt});
  factory _DhikrDefinition.fromJson(Map<String, dynamic> json) => _$DhikrDefinitionFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey(name: 'display_text') final  String displayText;
@override final  String? description;
@override@JsonKey(name: 'default_target') final  int defaultTarget;
@override final  DhikrDefinitionStatus status;
@override@JsonKey(name: 'created_by') final  String createdBy;
@override@JsonKey(name: 'source_reference') final  String? sourceReference;
@override@JsonKey(name: 'content_version') final  int contentVersion;
@override@JsonKey(name: 'content_checksum') final  String? contentChecksum;
@override@JsonKey(name: 'reviewed_by') final  String? reviewedBy;
@override@JsonKey(name: 'reviewed_at') final  DateTime? reviewedAt;

/// Create a copy of DhikrDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DhikrDefinitionCopyWith<_DhikrDefinition> get copyWith => __$DhikrDefinitionCopyWithImpl<_DhikrDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DhikrDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DhikrDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.displayText, displayText) || other.displayText == displayText)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultTarget, defaultTarget) || other.defaultTarget == defaultTarget)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.sourceReference, sourceReference) || other.sourceReference == sourceReference)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.contentChecksum, contentChecksum) || other.contentChecksum == contentChecksum)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,displayText,description,defaultTarget,status,createdBy,sourceReference,contentVersion,contentChecksum,reviewedBy,reviewedAt);

@override
String toString() {
  return 'DhikrDefinition(id: $id, title: $title, displayText: $displayText, description: $description, defaultTarget: $defaultTarget, status: $status, createdBy: $createdBy, sourceReference: $sourceReference, contentVersion: $contentVersion, contentChecksum: $contentChecksum, reviewedBy: $reviewedBy, reviewedAt: $reviewedAt)';
}


}

/// @nodoc
abstract mixin class _$DhikrDefinitionCopyWith<$Res> implements $DhikrDefinitionCopyWith<$Res> {
  factory _$DhikrDefinitionCopyWith(_DhikrDefinition value, $Res Function(_DhikrDefinition) _then) = __$DhikrDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@JsonKey(name: 'display_text') String displayText, String? description,@JsonKey(name: 'default_target') int defaultTarget, DhikrDefinitionStatus status,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'source_reference') String? sourceReference,@JsonKey(name: 'content_version') int contentVersion,@JsonKey(name: 'content_checksum') String? contentChecksum,@JsonKey(name: 'reviewed_by') String? reviewedBy,@JsonKey(name: 'reviewed_at') DateTime? reviewedAt
});




}
/// @nodoc
class __$DhikrDefinitionCopyWithImpl<$Res>
    implements _$DhikrDefinitionCopyWith<$Res> {
  __$DhikrDefinitionCopyWithImpl(this._self, this._then);

  final _DhikrDefinition _self;
  final $Res Function(_DhikrDefinition) _then;

/// Create a copy of DhikrDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? displayText = null,Object? description = freezed,Object? defaultTarget = null,Object? status = null,Object? createdBy = null,Object? sourceReference = freezed,Object? contentVersion = null,Object? contentChecksum = freezed,Object? reviewedBy = freezed,Object? reviewedAt = freezed,}) {
  return _then(_DhikrDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,displayText: null == displayText ? _self.displayText : displayText // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,defaultTarget: null == defaultTarget ? _self.defaultTarget : defaultTarget // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DhikrDefinitionStatus,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,sourceReference: freezed == sourceReference ? _self.sourceReference : sourceReference // ignore: cast_nullable_to_non_nullable
as String?,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as int,contentChecksum: freezed == contentChecksum ? _self.contentChecksum : contentChecksum // ignore: cast_nullable_to_non_nullable
as String?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
