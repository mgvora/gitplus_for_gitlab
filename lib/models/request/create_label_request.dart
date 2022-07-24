import 'package:json_annotation/json_annotation.dart';

part 'create_label_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CreateLabelRequest {
  final String? name;
  final String? color;
  final String? description;
  final int? priority; // for project only

  CreateLabelRequest({
    this.name,
    this.color,
    this.description,
    this.priority,
  });

  factory CreateLabelRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLabelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLabelRequestToJson(this);
}
