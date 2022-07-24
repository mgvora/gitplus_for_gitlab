import 'package:json_annotation/json_annotation.dart';

part 'milestone.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Milestone {
  final int? id;
  final int? iid;
  final int? projectId;
  final String? title;
  final String? description;
  final DateTime? dueDate;
  final DateTime? startDate;
  final String? state; // MilestoneState
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final bool? expired;

  Milestone({
    this.id,
    this.iid,
    this.projectId,
    this.title,
    this.description,
    this.dueDate,
    this.startDate,
    this.state,
    this.updatedAt,
    this.createdAt,
    this.expired,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) =>
      _$MilestoneFromJson(json);

  Map<String, dynamic> toJson() => _$MilestoneToJson(this);
}
