import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final int? id;
  final String? username;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? webUrl;

  User({
    this.id = -1,
    this.username = "",
    this.name = "",
    this.email = "",
    this.avatarUrl = "",
    this.webUrl = "",
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
