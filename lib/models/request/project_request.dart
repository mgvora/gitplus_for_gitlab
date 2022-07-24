import 'package:json_annotation/json_annotation.dart';

part 'project_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ProjectRequest {
  final bool? license;
  final bool? statistics;
  final bool? withCustomAttributes;

  ProjectRequest({
    this.license,
    this.statistics,
    this.withCustomAttributes,
  });

  factory ProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectRequestToJson(this);
}
