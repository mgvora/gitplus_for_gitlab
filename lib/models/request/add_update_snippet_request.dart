import 'package:json_annotation/json_annotation.dart';

part 'add_update_snippet_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AddUpdateSnippetRequest {
  final String? title;
  final String? fileName;
  final String? content;
  final String? description;
  final String? visibility; // GitLabVisibility

  AddUpdateSnippetRequest({
    this.title,
    this.fileName,
    this.content,
    this.description,
    this.visibility,
  });

  factory AddUpdateSnippetRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUpdateSnippetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddUpdateSnippetRequestToJson(this);
}
