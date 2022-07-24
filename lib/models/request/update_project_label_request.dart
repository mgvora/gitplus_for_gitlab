import 'package:json_annotation/json_annotation.dart';

part 'update_project_label_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UpdateProjectLabelRequest {
  final String? newName;
  final String? color;
  final String? description;
  final int? priority;

  UpdateProjectLabelRequest({
    this.newName,
    this.color,
    this.description,
    this.priority,
  });

  factory UpdateProjectLabelRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectLabelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProjectLabelRequestToJson(this);
}
