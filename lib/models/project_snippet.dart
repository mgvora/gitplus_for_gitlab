import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_snippet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProjectSnippet {
  final int? id;
  final String? title;
  final String? fileName;
  final String? description;
  final String? visibility; // GitLabVisibility
  final Author? author;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? projectId;
  final String? webUrl;
  final String? rawUrl;

  ProjectSnippet({
    this.id,
    this.title,
    this.fileName,
    this.description,
    this.visibility,
    this.author,
    this.updatedAt,
    this.createdAt,
    this.projectId,
    this.webUrl,
    this.rawUrl,
  });

  factory ProjectSnippet.fromJson(Map<String, dynamic> json) =>
      _$ProjectSnippetFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectSnippetToJson(this);
}
