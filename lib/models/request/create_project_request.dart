import 'package:json_annotation/json_annotation.dart';

part 'create_project_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CreateProjectRequest {
  final String? name;
  final String? path;
  final String? namespaceId;
  final bool? autoDevopsEnabled;
  final String? description;
  final bool? emailsDisabled;
  final bool? initializeWithReadme;
  final String? visibility; // GitLabVisibility
  final String? defaultBranch;

  CreateProjectRequest({
    this.name,
    this.path,
    this.namespaceId,
    this.autoDevopsEnabled,
    this.description,
    this.emailsDisabled,
    this.initializeWithReadme,
    this.visibility,
    this.defaultBranch,
  });

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProjectRequestToJson(this);
}
