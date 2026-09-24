import 'package:freezed_annotation/freezed_annotation.dart';

part 'dhikr_definition.freezed.dart';
part 'dhikr_definition.g.dart';

@JsonEnum(valueField: 'value')
enum DhikrDefinitionStatus {
  draft('draft', 'مسودة'),
  inReview('in_review', 'قيد المراجعة'),
  approved('approved', 'معتمد'),
  archived('archived', 'مؤرشف');

  const DhikrDefinitionStatus(this.value, this.arabicLabel);

  final String value;
  final String arabicLabel;
}

@freezed
abstract class DhikrDefinition with _$DhikrDefinition {
  const factory DhikrDefinition({
    required String id,
    @JsonKey(name: 'owner_branch_id') String? ownerBranchId,
    required String title,
    @JsonKey(name: 'display_text') required String displayText,
    String? description,
    @JsonKey(name: 'default_target') required int defaultTarget,
    required DhikrDefinitionStatus status,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'source_reference') String? sourceReference,
    @JsonKey(name: 'content_version') @Default(1) int contentVersion,
    @JsonKey(name: 'content_checksum') String? contentChecksum,
    @JsonKey(name: 'reviewed_by') String? reviewedBy,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
  }) = _DhikrDefinition;

  factory DhikrDefinition.fromJson(Map<String, Object?> json) =>
      _$DhikrDefinitionFromJson(json);
}
