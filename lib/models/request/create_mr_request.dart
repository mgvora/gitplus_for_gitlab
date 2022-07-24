import 'package:json_annotation/json_annotation.dart';

part 'create_mr_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CreateMRRequest {
  final String? sourceBranch;
  final String? targetBranch;
  final String? title;
  final String? description;
  final int? assigneeId;
  final List<int>? assigneeIds;
  final List<int>? reviewerIds;
  final String? labels; // Labels for MR as a comma-separated list
  final int? milestoneId;
  final bool? removeSourceBranch;
  final bool? allowCollaboration;
  final bool? allowMaintenerToPush;
  final int? approvalsBeforeMerge;
  final bool? squash;

  CreateMRRequest({
    this.sourceBranch,
    this.targetBranch,
    this.title,
    this.description,
    this.assigneeId,
    this.assigneeIds,
    this.reviewerIds,
    this.labels,
    this.milestoneId,
    this.removeSourceBranch,
    this.allowCollaboration,
    this.allowMaintenerToPush,
    this.approvalsBeforeMerge,
    this.squash,
  });

  factory CreateMRRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMRRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMRRequestToJson(this);
}
