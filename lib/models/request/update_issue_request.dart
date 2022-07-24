import 'package:json_annotation/json_annotation.dart';

part 'update_issue_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UpdateIssueRequest {
  final String? addLabels;
  final int? assigneeId;
  final List<int>? assigneeIds;
  final bool? confidential;
  final String? description;
  final bool? discussionLocked;
  final DateTime? dueDate;
  final int? epicId; // GitLab premium
  final int? epicIid; // GitLab premium
  final String? issueType;
  final String? labels;
  final int? milestoneId;
  final String? removeLabels;
  final String? stateEvent; // IssueStateEvent
  final String? title;
  final String? updateAt;
  final String? weight; // GitLab premium

  UpdateIssueRequest({
    this.addLabels,
    this.assigneeId,
    this.assigneeIds,
    this.confidential,
    this.description,
    this.discussionLocked,
    this.dueDate,
    this.epicId,
    this.epicIid,
    this.issueType,
    this.labels,
    this.milestoneId,
    this.removeLabels,
    this.stateEvent,
    this.title,
    this.updateAt,
    this.weight,
  });

  factory UpdateIssueRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateIssueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateIssueRequestToJson(this);
}
