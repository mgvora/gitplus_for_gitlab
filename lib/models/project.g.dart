// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as int?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      nameWithNamespace: json['name_with_namespace'] as String?,
      path: json['path'] as String?,
      pathWithNamespace: json['path_with_namespace'] as String?,
      defaultBranch: json['default_branch'] as String?,
      webUrl: json['web_url'] as String?,
      readmeUrl: json['readme_url'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      forksCount: json['forks_count'] as int?,
      starCount: json['star_count'] as int?,
      visibility: json['visibility'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      lastActivityAt: json['last_activity_at'] == null
          ? null
          : DateTime.parse(json['last_activity_at'] as String),
      namespace: json['namespace'] == null
          ? null
          : ProjectNamespace.fromJson(
              json['namespace'] as Map<String, dynamic>),
      permissions: json['permissions'] == null
          ? null
          : ProjectPermissions.fromJson(
              json['permissions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'name': instance.name,
      'name_with_namespace': instance.nameWithNamespace,
      'path': instance.path,
      'path_with_namespace': instance.pathWithNamespace,
      'default_branch': instance.defaultBranch,
      'web_url': instance.webUrl,
      'readme_url': instance.readmeUrl,
      'avatar_url': instance.avatarUrl,
      'forks_count': instance.forksCount,
      'star_count': instance.starCount,
      'visibility': instance.visibility,
      'created_at': instance.createdAt?.toIso8601String(),
      'last_activity_at': instance.lastActivityAt?.toIso8601String(),
      'namespace': instance.namespace,
      'permissions': instance.permissions,
    };
