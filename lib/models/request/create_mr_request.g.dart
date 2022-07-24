// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_mr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMRRequest _$CreateMRRequestFromJson(Map<String, dynamic> json) =>
    CreateMRRequest(
      sourceBranch: json['source_branch'] as String?,
      targetBranch: json['target_branch'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      assigneeId: json['assignee_id'] as int?,
      assigneeIds: (json['assignee_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      reviewerIds: (json['reviewer_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      labels: json['labels'] as String?,
      milestoneId: json['milestone_id'] as int?,
      removeSourceBranch: json['remove_source_branch'] as bool?,
      allowCollaboration: json['allow_collaboration'] as bool?,
      allowMaintenerToPush: json['allow_maintener_to_push'] as bool?,
      approvalsBeforeMerge: json['approvals_before_merge'] as int?,
      squash: json['squash'] as bool?,
    );

Map<String, dynamic> _$CreateMRRequestToJson(CreateMRRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source_branch', instance.sourceBranch);
  writeNotNull('target_branch', instance.targetBranch);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('assignee_id', instance.assigneeId);
  writeNotNull('assignee_ids', instance.assigneeIds);
  writeNotNull('reviewer_ids', instance.reviewerIds);
  writeNotNull('labels', instance.labels);
  writeNotNull('milestone_id', instance.milestoneId);
  writeNotNull('remove_source_branch', instance.removeSourceBranch);
  writeNotNull('allow_collaboration', instance.allowCollaboration);
  writeNotNull('allow_maintener_to_push', instance.allowMaintenerToPush);
  writeNotNull('approvals_before_merge', instance.approvalsBeforeMerge);
  writeNotNull('squash', instance.squash);
  return val;
}
