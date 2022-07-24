import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Issue {
  final int? id;
  final ProjectMilestone? milestone;
  final Author? author;
  final String? description;
  final String? state;
  final int? iid;
  final int? projectId;
  final List<Author>? assignees;
  final Author? assignee;
  final String? type;
  final List<String>? labels;
  final int? upvotes;
  final int? downvotes;
  final int? mergeRequestsCount;
  final String? title;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final DateTime? closedAt;
  final Author? closedBy;
  final bool? subscribed;
  final int? userNotesCount;
  final DateTime? dueDate;
  final String? webUrl;
  final References? references;
  // final ? timeStats;
  final bool? confidential;
  final bool? discussionLocked;
  final String? issueType;
  final TaskCompletionStatus? taskCompletionStatus;
  // final ? weight;
  final bool? hasTasks;
  // final int? movedToId;
  final String? serviceDeskReplyTo;

  Issue({
    this.id,
    this.milestone,
    this.author,
    this.description,
    this.state,
    this.iid,
    this.projectId,
    this.assignees,
    this.assignee,
    this.type,
    this.labels,
    this.upvotes,
    this.downvotes,
    this.mergeRequestsCount,
    this.title,
    this.updatedAt,
    this.createdAt,
    this.closedAt,
    this.closedBy,
    this.subscribed,
    this.userNotesCount,
    this.dueDate,
    this.webUrl,
    this.references,
    this.confidential,
    this.discussionLocked,
    this.issueType,
    this.taskCompletionStatus,
    this.hasTasks,
    this.serviceDeskReplyTo,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}
