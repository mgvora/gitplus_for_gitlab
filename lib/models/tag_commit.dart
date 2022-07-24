import 'package:json_annotation/json_annotation.dart';

part 'tag_commit.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TagCommit {
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

  TagCommit({
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
  });

  factory TagCommit.fromJson(Map<String, dynamic> json) =>
      _$TagCommitFromJson(json);

  Map<String, dynamic> toJson() => _$TagCommitToJson(this);
}
