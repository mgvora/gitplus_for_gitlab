// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_issue_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateIssueRequest _$UpdateIssueRequestFromJson(Map<String, dynamic> json) =>
    UpdateIssueRequest(
      addLabels: json['add_labels'] as String?,
      assigneeId: json['assignee_id'] as int?,
      assigneeIds: (json['assignee_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      confidential: json['confidential'] as bool?,
      description: json['description'] as String?,
      discussionLocked: json['discussion_locked'] as bool?,
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      epicId: json['epic_id'] as int?,
      epicIid: json['epic_iid'] as int?,
      issueType: json['issue_type'] as String?,
      labels: json['labels'] as String?,
      milestoneId: json['milestone_id'] as int?,
      removeLabels: json['remove_labels'] as String?,
      stateEvent: json['state_event'] as String?,
      title: json['title'] as String?,
      updateAt: json['update_at'] as String?,
      weight: json['weight'] as String?,
    );

Map<String, dynamic> _$UpdateIssueRequestToJson(UpdateIssueRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('add_labels', instance.addLabels);
  writeNotNull('assignee_id', instance.assigneeId);
  writeNotNull('assignee_ids', instance.assigneeIds);
  writeNotNull('confidential', instance.confidential);
  writeNotNull('description', instance.description);
  writeNotNull('discussion_locked', instance.discussionLocked);
  writeNotNull('due_date', instance.dueDate?.toIso8601String());
  writeNotNull('epic_id', instance.epicId);
  writeNotNull('epic_iid', instance.epicIid);
  writeNotNull('issue_type', instance.issueType);
  writeNotNull('labels', instance.labels);
  writeNotNull('milestone_id', instance.milestoneId);
  writeNotNull('remove_labels', instance.removeLabels);
  writeNotNull('state_event', instance.stateEvent);
  writeNotNull('title', instance.title);
  writeNotNull('update_at', instance.updateAt);
  writeNotNull('weight', instance.weight);
  return val;
}
