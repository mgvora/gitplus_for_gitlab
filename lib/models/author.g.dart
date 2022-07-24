// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as int?,
      name: json['name'] as String? ?? "",
      username: json['username'] as String? ?? "",
      state: json['state'] as String? ?? "",
      avatarUrl: json['avatar_url'] as String? ?? "",
      webUrl: json['web_url'] as String? ?? "",
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'state': instance.state,
      'avatar_url': instance.avatarUrl,
      'web_url': instance.webUrl,
    };
