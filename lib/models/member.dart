import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Member {
  final int? id;
  final String? username;
  final String? name;
  final String? state; // MemberStates
  final String? avatarUrl;
  final String? webUrl;
  final int? accessLevel; // MemberAccessLevel
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final String? membershipState;

  Member({
    this.id = -1,
    this.username = "",
    this.name = "",
    this.state = "",
    this.avatarUrl = "",
    this.webUrl = "",
    this.accessLevel = -1,
    this.createdAt,
    this.expiresAt,
    this.membershipState = "",
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
