// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merge_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MergeRequest _$MergeRequestFromJson(Map<String, dynamic> json) => MergeRequest(
      id: json['id'] as int?,
      iid: json['iid'] as int?,
      projectId: json['project_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      state: json['state'] as String?,
      mergedBy: json['merged_by'] == null
          ? null
          : Author.fromJson(json['merged_by'] as Map<String, dynamic>),
      mergedAt: json['merged_at'] == null
          ? null
          : DateTime.parse(json['merged_at'] as String),
      closedBy: json['closed_by'] == null
          ? null
          : Author.fromJson(json['closed_by'] as Map<String, dynamic>),
      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      targetBranch: json['target_branch'] as String?,
      sourceBranch: json['source_branch'] as String?,
      upvotes: json['upvotes'] as int?,
      downvotes: json['downvotes'] as int?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      assignee: json['assignee'] == null
          ? null
          : Author.fromJson(json['assignee'] as Map<String, dynamic>),
      assignees: (json['assignees'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewers: (json['reviewers'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceProjectId: json['source_project_id'] as int?,
      targetProjectId: json['target_project_id'] as int?,
      labels:
          (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList(),
      draft: json['draft'] as bool?,
      workInProgress: json['work_in_progress'] as bool?,
      milestone: json['milestone'] == null
          ? null
          : Milestone.fromJson(json['milestone'] as Map<String, dynamic>),
      mergeWhenPipelineSucceeds: json['merge_when_pipeline_succeeds'] as bool?,
      mergeStatus: json['merge_status'] as String?,
      sha: json['sha'] as String?,
      mergeCommitSha: json['merge_commit_sha'] as String?,
      squashCommitSha: json['squash_commit_sha'] as String?,
      userNotesCount: json['user_notes_count'] as int?,
      discussionLocked: json['discussion_locked'] as bool?,
      shouldRemoveSourceBranch: json['should_remove_source_branch'] as bool?,
      forceRemoveSourceBranch: json['force_remove_source_branch'] as bool?,
      allowCollaboration: json['allow_collaboration'] as bool?,
      allowMaintenerToPush: json['allow_maintener_to_push'] as bool?,
      webUrl: json['web_url'] as String?,
      references: json['references'] == null
          ? null
          : References.fromJson(json['references'] as Map<String, dynamic>),
      timeStats: json['time_stats'] == null
          ? null
          : TimeStats.fromJson(json['time_stats'] as Map<String, dynamic>),
      squash: json['squash'] as bool?,
      taskCompletionStatus: json['task_completion_status'] == null
          ? null
          : TaskCompletionStatus.fromJson(
              json['task_completion_status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MergeRequestToJson(MergeRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iid': instance.iid,
      'project_id': instance.projectId,
      'title': instance.title,
      'description': instance.description,
      'state': instance.state,
      'merged_by': instance.mergedBy,
      'merged_at': instance.mergedAt?.toIso8601String(),
      'closed_by': instance.closedBy,
      'closed_at': instance.closedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'target_branch': instance.targetBranch,
      'source_branch': instance.sourceBranch,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'author': instance.author,
      'assignee': instance.assignee,
      'assignees': instance.assignees,
      'reviewers': instance.reviewers,
      'source_project_id': instance.sourceProjectId,
      'target_project_id': instance.targetProjectId,
      'labels': instance.labels,
      'draft': instance.draft,
      'work_in_progress': instance.workInProgress,
      'milestone': instance.milestone,
      'merge_when_pipeline_succeeds': instance.mergeWhenPipelineSucceeds,
      'merge_status': instance.mergeStatus,
      'sha': instance.sha,
      'merge_commit_sha': instance.mergeCommitSha,
      'squash_commit_sha': instance.squashCommitSha,
      'user_notes_count': instance.userNotesCount,
      'discussion_locked': instance.discussionLocked,
      'should_remove_source_branch': instance.shouldRemoveSourceBranch,
      'force_remove_source_branch': instance.forceRemoveSourceBranch,
      'allow_collaboration': instance.allowCollaboration,
      'allow_maintener_to_push': instance.allowMaintenerToPush,
      'web_url': instance.webUrl,
      'references': instance.references,
      'time_stats': instance.timeStats,
      'squash': instance.squash,
      'task_completion_status': instance.taskCompletionStatus,
    };
