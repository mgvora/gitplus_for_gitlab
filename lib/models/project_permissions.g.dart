// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectPermissions _$ProjectPermissionsFromJson(Map<String, dynamic> json) =>
    ProjectPermissions(
      projectAccess: json['project_access'] == null
          ? null
          : PermissionAccess.fromJson(
              json['project_access'] as Map<String, dynamic>),
      groupAccess: json['group_access'] == null
          ? null
          : PermissionAccess.fromJson(
              json['group_access'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectPermissionsToJson(ProjectPermissions instance) =>
    <String, dynamic>{
      'project_access': instance.projectAccess,
      'group_access': instance.groupAccess,
    };
