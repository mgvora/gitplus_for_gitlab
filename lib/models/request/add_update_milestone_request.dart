import 'package:json_annotation/json_annotation.dart';

part 'add_update_milestone_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AddUpdateMilestoneRequest {
  final String? title;
  final String? description;
  final String? dueDate;
  final String? startDate;
  final String? stateEvent; // MilestoneStateEvent

  AddUpdateMilestoneRequest({
    this.title,
    this.description,
    this.dueDate,
    this.startDate,
    this.stateEvent,
  });

  factory AddUpdateMilestoneRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUpdateMilestoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddUpdateMilestoneRequestToJson(this);
}
