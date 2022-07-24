// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as int?,
      webUrl: json['web_url'] as String?,
      name: json['name'] as String?,
      path: json['path'] as String?,
      description: json['description'] as String?,
      visibility: json['visibility'] as String?,
      shareWithGroupLock: json['share_with_group_lock'] as bool?,
      requireTwoFactorAuthentication:
          json['require_two_factor_authentication'] as bool?,
      twoFactorGracePeriod: json['two_factor_grace_period'] as int?,
      projectCreationLevel: json['project_creation_level'] as String?,
      autoDevopsEnabled: json['auto_devops_enabled'] as bool?,
      subgroupCreationLevel: json['subgroup_creation_level'] as String?,
      emailsDisabled: json['emails_disabled'] as bool?,
      mentionsDisabled: json['mentions_disabled'] as bool?,
      lfsEnabled: json['lfs_enabled'] as bool?,
      defaultBranchProtection: json['default_branch_protection'] as int?,
      avatarUrl: json['avatar_url'] as String?,
      requestAccessEnabled: json['request_access_enabled'] as bool?,
      fullName: json['full_name'] as String?,
      fullPath: json['full_path'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      parentId: json['parent_id'] as int?,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'web_url': instance.webUrl,
      'name': instance.name,
      'path': instance.path,
      'description': instance.description,
      'visibility': instance.visibility,
      'share_with_group_lock': instance.shareWithGroupLock,
      'require_two_factor_authentication':
          instance.requireTwoFactorAuthentication,
      'two_factor_grace_period': instance.twoFactorGracePeriod,
      'project_creation_level': instance.projectCreationLevel,
      'auto_devops_enabled': instance.autoDevopsEnabled,
      'subgroup_creation_level': instance.subgroupCreationLevel,
      'emails_disabled': instance.emailsDisabled,
      'mentions_disabled': instance.mentionsDisabled,
      'lfs_enabled': instance.lfsEnabled,
      'default_branch_protection': instance.defaultBranchProtection,
      'avatar_url': instance.avatarUrl,
      'request_access_enabled': instance.requestAccessEnabled,
      'full_name': instance.fullName,
      'full_path': instance.fullPath,
      'created_at': instance.createdAt?.toIso8601String(),
      'parent_id': instance.parentId,
    };
