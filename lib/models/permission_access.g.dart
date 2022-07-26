// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionAccess _$PermissionAccessFromJson(Map<String, dynamic> json) =>
    PermissionAccess(
      accessLevel: json['access_level'] as int?,
      notificationLevel: json['notification_level'] as int?,
    );

Map<String, dynamic> _$PermissionAccessToJson(PermissionAccess instance) =>
    <String, dynamic>{
      'access_level': instance.accessLevel,
      'notification_level': instance.notificationLevel,
    };
