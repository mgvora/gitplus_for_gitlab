// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_namespace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectNamespace _$ProjectNamespaceFromJson(Map<String, dynamic> json) =>
    ProjectNamespace(
      id: json['id'] as int?,
      name: json['name'] as String?,
      path: json['path'] as String?,
      fullPath: json['full_path'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      webUrl: json['web_url'] as String?,
    );

Map<String, dynamic> _$ProjectNamespaceToJson(ProjectNamespace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'full_path': instance.fullPath,
      'avatar_url': instance.avatarUrl,
      'web_url': instance.webUrl,
    };
