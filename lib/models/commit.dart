import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commit.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Commit {
  final String? id;
  final String? shortId;
  final DateTime? createdAt;
  final List<String>? parentIds;
  final String? title;
  final String? message;
  final String? authorName;
  final String? authorEmail;
  final DateTime? authoredDate;
  final String? commiterName;
  final String? commiterEmail;
  final DateTime? commiterDate;
  final String? webUrl;
  final CommitStats? stats;
  final int? projectId;

  Commit({
    this.id,
    this.shortId,
    this.createdAt,
    this.parentIds,
    this.title,
    this.message,
    this.authorName,
    this.authorEmail,
    this.authoredDate,
    this.commiterName,
    this.commiterEmail,
    this.commiterDate,
    this.webUrl,
    this.stats,
    this.projectId,
  });

  factory Commit.fromJson(Map<String, dynamic> json) => _$CommitFromJson(json);

  Map<String, dynamic> toJson() => _$CommitToJson(this);
}
