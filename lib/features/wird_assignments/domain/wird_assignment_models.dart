import 'package:ward_al_rawdah/features/dhikr_library/domain/dhikr_definition.dart';

enum WirdLifecycleStatus {
  draft('draft', 'مسودة'),
  scheduled('scheduled', 'مجدول'),
  active('active', 'نشط'),
  ended('ended', 'منتهٍ'),
  cancelled('cancelled', 'ملغى');

  const WirdLifecycleStatus(this.value, this.arabicLabel);
  final String value;
  final String arabicLabel;

  static WirdLifecycleStatus parse(String value) =>
      values.firstWhere((item) => item.value == value);
}

enum AssignmentScope {
  organization('organization', 'جميع المؤسسة'),
  branch('branch', 'فرع'),
  schoolClass('class', 'صف'),
  role('role', 'دور'),
  user('user', 'مستخدم');

  const AssignmentScope(this.value, this.arabicLabel);
  final String value;
  final String arabicLabel;
}

class WirdContent {
  const WirdContent({
    required this.id,
    required this.dhikrId,
    required this.title,
    required this.targetCount,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.description,
  });

  factory WirdContent.fromJson(Map<String, dynamic> json) => WirdContent(
    id: json['id'] as String,
    dhikrId: json['dhikr_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    targetCount: (json['target_count'] as num).toInt(),
    startAt: DateTime.parse(json['start_at'] as String),
    endAt: DateTime.parse(json['end_at'] as String),
    status: WirdLifecycleStatus.parse(json['status'] as String),
  );

  final String id;
  final String dhikrId;
  final String title;
  final String? description;
  final int targetCount;
  final DateTime startAt;
  final DateTime endAt;
  final WirdLifecycleStatus status;
}

class AudienceBranch {
  const AudienceBranch({required this.id, required this.name});
  final String id;
  final String name;
}

class AudienceClass {
  const AudienceClass({
    required this.id,
    required this.branchId,
    required this.name,
  });
  final String id;
  final String branchId;
  final String name;
}

class AudienceUser {
  const AudienceUser({
    required this.id,
    required this.name,
    required this.role,
    this.branchId,
  });
  final String id;
  final String name;
  final String role;
  final String? branchId;
}

class AssignmentDraft {
  const AssignmentDraft({
    required this.scope,
    this.branchId,
    this.classId,
    this.role,
    this.userId,
  });
  final AssignmentScope scope;
  final String? branchId;
  final String? classId;
  final String? role;
  final String? userId;

  Map<String, Object?> toJson() => {
    'scope_type': scope.value,
    'branch_id': branchId,
    'class_id': classId,
    'role': role,
    'user_id': userId,
  };
}

class WirdDraft {
  const WirdDraft({
    required this.dhikrId,
    required this.title,
    required this.targetCount,
    required this.startAt,
    required this.endAt,
    required this.assignments,
    this.description,
  });
  final String dhikrId;
  final String title;
  final String? description;
  final int targetCount;
  final DateTime startAt;
  final DateTime endAt;
  final List<AssignmentDraft> assignments;
}

class WirdManagementData {
  const WirdManagementData({
    this.wirds = const [],
    this.dhikr = const [],
    this.branches = const [],
    this.classes = const [],
    this.users = const [],
    this.lastMaterializedCount,
  });
  final List<WirdContent> wirds;
  final List<DhikrDefinition> dhikr;
  final List<AudienceBranch> branches;
  final List<AudienceClass> classes;
  final List<AudienceUser> users;
  final int? lastMaterializedCount;
}

class TodayWird {
  const TodayWird({
    required this.id,
    required this.title,
    required this.dhikrTitle,
    required this.dhikrText,
    required this.targetCount,
    required this.startAt,
    required this.endAt,
    required this.timezoneName,
    required this.assignmentScope,
  });
  factory TodayWird.fromJson(Map<String, dynamic> json) => TodayWird(
    id: json['id'] as String,
    title: json['title'] as String,
    dhikrTitle: json['dhikr_title'] as String,
    dhikrText: json['dhikr_text'] as String,
    targetCount: (json['target_count'] as num).toInt(),
    startAt: DateTime.parse(json['start_at'] as String),
    endAt: DateTime.parse(json['end_at'] as String),
    timezoneName: json['timezone_name'] as String,
    assignmentScope: json['assignment_scope'] as String,
  );
  final String id;
  final String title;
  final String dhikrTitle;
  final String dhikrText;
  final int targetCount;
  final DateTime startAt;
  final DateTime endAt;
  final String timezoneName;
  final String assignmentScope;
}
