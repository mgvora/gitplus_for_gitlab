// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppAccount _$AppAccountFromJson(Map<String, dynamic> json) => AppAccount(
      userId: json['userId'] as int? ?? -1,
      name: json['name'] as String? ?? "",
      username: json['username'] as String? ?? "",
      avatarUrl: json['avatarUrl'] as String? ?? "",
      accessToken: json['accessToken'] as String? ?? "",
      refreshToken: json['refreshToken'] as String? ?? "",
      baseUrl: json['baseUrl'] as String? ?? "gitlab.com",
    );

Map<String, dynamic> _$AppAccountToJson(AppAccount instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'baseUrl': instance.baseUrl,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
