// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
      id: json['id'] as int?,
      title: json['title'] as String?,
      fileName: json['file_name'] as String?,
      description: json['description'] as String?,
      visibility: json['visibility'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      projectId: json['project_id'] as int?,
      webUrl: json['web_url'] as String?,
      rawUrl: json['raw_url'] as String?,
    );

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'file_name': instance.fileName,
      'description': instance.description,
      'visibility': instance.visibility,
      'author': instance.author,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'project_id': instance.projectId,
      'web_url': instance.webUrl,
      'raw_url': instance.rawUrl,
    };
