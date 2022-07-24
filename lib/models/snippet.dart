import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'snippet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Snippet {
  final int? id;
  final String? title;
  final String? fileName;
  final String? description;
  final String? visibility; // GitLabVisibility
  final Author? author;
  final DateTime? expiresAt;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? projectId;
  final String? webUrl;
  final String? rawUrl;

  Snippet({
    this.id,
    this.title,
    this.fileName,
    this.description,
    this.visibility,
    this.author,
    this.expiresAt,
    this.updatedAt,
    this.createdAt,
    this.projectId,
    this.webUrl,
    this.rawUrl,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);
}
