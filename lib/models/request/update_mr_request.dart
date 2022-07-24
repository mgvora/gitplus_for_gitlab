import 'package:json_annotation/json_annotation.dart';

part 'update_mr_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UpdateMRRequest {
  final String? targetBranch;
  final String? title;
  final int? assigneeId;
  final List<int>? assigneeIds;
  final List<int>? reviewerIds;
  final int? milestoneId;
  final String? labels;
  final String? addLabels;
  final String? removeLabels;
  final String? description;
  final String? stateEvent;
  final bool? removeSourceBranch;
  final bool? squash;
  final bool? discussionLocked;
  final bool? allowCollaboration;
  final bool? allowMaintainerToPush;

  UpdateMRRequest({
    this.targetBranch,
    this.title,
    this.assigneeId,
    this.assigneeIds,
    this.reviewerIds,
    this.milestoneId,
    this.labels,
    this.addLabels,
    this.removeLabels,
    this.description,
    this.stateEvent,
    this.removeSourceBranch,
    this.squash,
    this.discussionLocked,
    this.allowCollaboration,
    this.allowMaintainerToPush,
  });

  factory UpdateMRRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMRRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMRRequestToJson(this);
}
