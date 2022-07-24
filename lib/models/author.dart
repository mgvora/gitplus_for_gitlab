import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Author {
  final int? id;
  final String? name;
  final String? username;
  final String? state; // AuthorState
  final String? avatarUrl;
  final String? webUrl;

  Author({
    this.id,
    this.name = "",
    this.username = "",
    this.state = "",
    this.avatarUrl = "",
    this.webUrl = "",
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
