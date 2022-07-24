import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'app_account.g.dart';

@JsonSerializable()
class AppAccount {
  int? userId;
  String? name;
  String? username;
  String? avatarUrl;
  String? baseUrl;
  String? accessToken;
  String? refreshToken;

  AppAccount({
    this.userId = -1,
    this.name = "",
    this.username = "",
    this.avatarUrl = "",
    this.accessToken = "",
    this.refreshToken = "",
    this.baseUrl = "gitlab.com",
  });

  String toJsonString() => json.encode(toJson());

  factory AppAccount.fromJson(Map<String, dynamic> json) =>
      _$AppAccountFromJson(json);

  Map<String, dynamic> toJson() => _$AppAccountToJson(this);
}
