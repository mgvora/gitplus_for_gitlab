import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merge_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MergeRequest {
  final int? id;
  final int? iid;
  final int? projectId;
  final String? title;
  final String? description;
  final String? state; // MergeRequestState
  final Author? mergedBy;
  final DateTime? mergedAt;
  final Author? closedBy;
  final DateTime? closedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? targetBranch;
  final String? sourceBranch;
  final int? upvotes;
  final int? downvotes;
  final Author? author;
  final Author? assignee;
  final List<Author>? assignees;
  final List<Author>? reviewers;
  final int? sourceProjectId;
  final int? targetProjectId;
  final List<String>? labels;
  final bool? draft;
  final bool? workInProgress;
  final Milestone? milestone;
  final bool? mergeWhenPipelineSucceeds;
  final String? mergeStatus;
  final String? sha;
  final String? mergeCommitSha;
  final String? squashCommitSha;
  final int? userNotesCount;
  final bool? discussionLocked;
  final bool? shouldRemoveSourceBranch;
  final bool? forceRemoveSourceBranch;
  final bool? allowCollaboration;
  final bool? allowMaintenerToPush;
  final String? webUrl;
  final References? references;
  final TimeStats? timeStats;
  final bool? squash;
  final TaskCompletionStatus? taskCompletionStatus;

  MergeRequest({
    this.id,
    this.iid,
    this.projectId,
    this.title,
    this.description,
    this.state,
    this.mergedBy,
    this.mergedAt,
    this.closedBy,
    this.closedAt,
    this.createdAt,
    this.updatedAt,
    this.targetBranch,
    this.sourceBranch,
    this.upvotes,
    this.downvotes,
    this.author,
    this.assignee,
    this.assignees,
    this.reviewers,
    this.sourceProjectId,
    this.targetProjectId,
    this.labels,
    this.draft,
    this.workInProgress,
    this.milestone,
    this.mergeWhenPipelineSucceeds,
    this.mergeStatus,
    this.sha,
    this.mergeCommitSha,
    this.squashCommitSha,
    this.userNotesCount,
    this.discussionLocked,
    this.shouldRemoveSourceBranch,
    this.forceRemoveSourceBranch,
    this.allowCollaboration,
    this.allowMaintenerToPush,
    this.webUrl,
    this.references,
    this.timeStats,
    this.squash,
    this.taskCompletionStatus,
  });

  factory MergeRequest.fromJson(Map<String, dynamic> json) =>
      _$MergeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MergeRequestToJson(this);
}
