// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMemberRequest _$AddMemberRequestFromJson(Map<String, dynamic> json) =>
    AddMemberRequest(
      id: json['id'] as int? ?? -1,
      userId: json['user_id'] as String?,
      accessLevel: json['access_level'] as int?,
      expiresAt: json['expires_at'] as String?,
      inviteSource: json['invite_source'] as String?,
      tasksProjectId: json['tasks_project_id'] as int?,
    );

Map<String, dynamic> _$AddMemberRequestToJson(AddMemberRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('access_level', instance.accessLevel);
  writeNotNull('expires_at', instance.expiresAt);
  writeNotNull('invite_source', instance.inviteSource);
  writeNotNull('tasks_project_id', instance.tasksProjectId);
  return val;
}
