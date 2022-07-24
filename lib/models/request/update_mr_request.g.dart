// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_mr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMRRequest _$UpdateMRRequestFromJson(Map<String, dynamic> json) =>
    UpdateMRRequest(
      targetBranch: json['target_branch'] as String?,
      title: json['title'] as String?,
      assigneeId: json['assignee_id'] as int?,
      assigneeIds: (json['assignee_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      reviewerIds: (json['reviewer_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      milestoneId: json['milestone_id'] as int?,
      labels: json['labels'] as String?,
      addLabels: json['add_labels'] as String?,
      removeLabels: json['remove_labels'] as String?,
      description: json['description'] as String?,
      stateEvent: json['state_event'] as String?,
      removeSourceBranch: json['remove_source_branch'] as bool?,
      squash: json['squash'] as bool?,
      discussionLocked: json['discussion_locked'] as bool?,
      allowCollaboration: json['allow_collaboration'] as bool?,
      allowMaintainerToPush: json['allow_maintainer_to_push'] as bool?,
    );

Map<String, dynamic> _$UpdateMRRequestToJson(UpdateMRRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('target_branch', instance.targetBranch);
  writeNotNull('title', instance.title);
  writeNotNull('assignee_id', instance.assigneeId);
  writeNotNull('assignee_ids', instance.assigneeIds);
  writeNotNull('reviewer_ids', instance.reviewerIds);
  writeNotNull('milestone_id', instance.milestoneId);
  writeNotNull('labels', instance.labels);
  writeNotNull('add_labels', instance.addLabels);
  writeNotNull('remove_labels', instance.removeLabels);
  writeNotNull('description', instance.description);
  writeNotNull('state_event', instance.stateEvent);
  writeNotNull('remove_source_branch', instance.removeSourceBranch);
  writeNotNull('squash', instance.squash);
  writeNotNull('discussion_locked', instance.discussionLocked);
  writeNotNull('allow_collaboration', instance.allowCollaboration);
  writeNotNull('allow_maintainer_to_push', instance.allowMaintainerToPush);
  return val;
}
