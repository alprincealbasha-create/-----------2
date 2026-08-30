import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';
import 'package:ward_al_rawdah/features/users/domain/branch_user_models.dart';

part 'campaign_models.freezed.dart';

enum CampaignStatus {
  active('active', 'نشطة'),
  completed('completed', 'مكتملة'),
  archived('archived', 'مؤرشفة');

  const CampaignStatus(this.value, this.arabicLabel);

  final String value;
  final String arabicLabel;

  static CampaignStatus parse(String value) =>
      CampaignStatus.values.firstWhere((item) => item.value == value);
}

@freezed
abstract class BranchContribution with _$BranchContribution {
  const factory BranchContribution({
    required String branchId,
    required String branchName,
    @Default(0) int count,
  }) = _BranchContribution;
}

@freezed
abstract class CategoryContribution with _$CategoryContribution {
  const factory CategoryContribution({
    required ManagedUserType category,
    @Default(0) int count,
  }) = _CategoryContribution;
}

@freezed
abstract class CampaignDashboardItem with _$CampaignDashboardItem {
  const factory CampaignDashboardItem({
    required String id,
    required String name,
    required String dhikrTitle,
    required int targetCount,
    required int currentCount,
    required CampaignStatus status,
    @Default(<BranchContribution>[])
    List<BranchContribution> branchContributions,
    @Default(<CategoryContribution>[])
    List<CategoryContribution> categoryContributions,
  }) = _CampaignDashboardItem;

  factory CampaignDashboardItem.fromRpc(Map<String, Object?> row) {
    final branches = (row['branch_contributions'] as List<dynamic>? ?? const [])
        .map((item) {
          final value = Map<String, Object?>.from(item as Map);
          return BranchContribution(
            branchId: value['branch_id']! as String,
            branchName: value['branch_name']! as String,
            count: (value['count'] as num?)?.toInt() ?? 0,
          );
        })
        .toList(growable: false);
    final categories =
        (row['category_contributions'] as List<dynamic>? ?? const [])
            .map((item) {
              final value = Map<String, Object?>.from(item as Map);
              return CategoryContribution(
                category: _parseUserType(value['category']! as String),
                count: (value['count'] as num?)?.toInt() ?? 0,
              );
            })
            .toList(growable: false);
    return CampaignDashboardItem(
      id: row['campaign_id']! as String,
      name: row['campaign_name']! as String,
      dhikrTitle: row['dhikr_title']! as String,
      targetCount: (row['target_count']! as num).toInt(),
      currentCount: (row['current_count']! as num).toInt(),
      status: CampaignStatus.parse(row['campaign_status']! as String),
      branchContributions: branches,
      categoryContributions: categories,
    );
  }
}

@freezed
abstract class CampaignManagementState with _$CampaignManagementState {
  const factory CampaignManagementState({
    @Default(<CampaignDashboardItem>[]) List<CampaignDashboardItem> campaigns,
    @Default(<DhikrDefinition>[]) List<DhikrDefinition> dhikrDefinitions,
  }) = _CampaignManagementState;
}

ManagedUserType _parseUserType(String value) =>
    ManagedUserType.values.firstWhere((item) => item.value == value);
