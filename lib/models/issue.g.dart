// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      id: json['id'] as int?,
      milestone: json['milestone'] == null
          ? null
          : ProjectMilestone.fromJson(
              json['milestone'] as Map<String, dynamic>),
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      description: json['description'] as String?,
      state: json['state'] as String?,
      iid: json['iid'] as int?,
      projectId: json['project_id'] as int?,
      assignees: (json['assignees'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      assignee: json['assignee'] == null
          ? null
          : Author.fromJson(json['assignee'] as Map<String, dynamic>),
      type: json['type'] as String?,
      labels:
          (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList(),
      upvotes: json['upvotes'] as int?,
      downvotes: json['downvotes'] as int?,
      mergeRequestsCount: json['merge_requests_count'] as int?,
      title: json['title'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
      closedBy: json['closed_by'] == null
          ? null
          : Author.fromJson(json['closed_by'] as Map<String, dynamic>),
      subscribed: json['subscribed'] as bool?,
      userNotesCount: json['user_notes_count'] as int?,
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      webUrl: json['web_url'] as String?,
      references: json['references'] == null
          ? null
          : References.fromJson(json['references'] as Map<String, dynamic>),
      confidential: json['confidential'] as bool?,
      discussionLocked: json['discussion_locked'] as bool?,
      issueType: json['issue_type'] as String?,
      taskCompletionStatus: json['task_completion_status'] == null
          ? null
          : TaskCompletionStatus.fromJson(
              json['task_completion_status'] as Map<String, dynamic>),
      hasTasks: json['has_tasks'] as bool?,
      serviceDeskReplyTo: json['service_desk_reply_to'] as String?,
    );

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'id': instance.id,
      'milestone': instance.milestone,
      'author': instance.author,
      'description': instance.description,
      'state': instance.state,
      'iid': instance.iid,
      'project_id': instance.projectId,
      'assignees': instance.assignees,
      'assignee': instance.assignee,
      'type': instance.type,
      'labels': instance.labels,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'merge_requests_count': instance.mergeRequestsCount,
      'title': instance.title,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'closed_at': instance.closedAt?.toIso8601String(),
      'closed_by': instance.closedBy,
      'subscribed': instance.subscribed,
      'user_notes_count': instance.userNotesCount,
      'due_date': instance.dueDate?.toIso8601String(),
      'web_url': instance.webUrl,
      'references': instance.references,
      'confidential': instance.confidential,
      'discussion_locked': instance.discussionLocked,
      'issue_type': instance.issueType,
      'task_completion_status': instance.taskCompletionStatus,
      'has_tasks': instance.hasTasks,
      'service_desk_reply_to': instance.serviceDeskReplyTo,
    };
