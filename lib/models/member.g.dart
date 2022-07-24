// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['id'] as int? ?? -1,
      username: json['username'] as String? ?? "",
      name: json['name'] as String? ?? "",
      state: json['state'] as String? ?? "",
      avatarUrl: json['avatar_url'] as String? ?? "",
      webUrl: json['web_url'] as String? ?? "",
      accessLevel: json['access_level'] as int? ?? -1,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      membershipState: json['membership_state'] as String? ?? "",
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'state': instance.state,
      'avatar_url': instance.avatarUrl,
      'web_url': instance.webUrl,
      'access_level': instance.accessLevel,
      'created_at': instance.createdAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'membership_state': instance.membershipState,
    };
