import 'package:json_annotation/json_annotation.dart';

part 'group_milestone.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GroupMilestone {
  final int? id;
  final int? iid;
  final int? groupId;
  final String? title;
  final String? description;
  final DateTime? dueDate;
  final DateTime? startDate;
  final String? state; // MilestoneState
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final bool? expired;
  final String? webUrl;

  GroupMilestone({
    this.id,
    this.iid,
    this.groupId,
    this.title,
    this.description,
    this.dueDate,
    this.startDate,
    this.state,
    this.updatedAt,
    this.createdAt,
    this.expired,
    this.webUrl,
  });

  factory GroupMilestone.fromJson(Map<String, dynamic> json) =>
      _$GroupMilestoneFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMilestoneToJson(this);
}
