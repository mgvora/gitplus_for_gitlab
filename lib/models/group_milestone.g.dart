// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_milestone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMilestone _$GroupMilestoneFromJson(Map<String, dynamic> json) =>
    GroupMilestone(
      id: json['id'] as int?,
      iid: json['iid'] as int?,
      groupId: json['group_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      state: json['state'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      expired: json['expired'] as bool?,
      webUrl: json['web_url'] as String?,
    );

Map<String, dynamic> _$GroupMilestoneToJson(GroupMilestone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iid': instance.iid,
      'group_id': instance.groupId,
      'title': instance.title,
      'description': instance.description,
      'due_date': instance.dueDate?.toIso8601String(),
      'start_date': instance.startDate?.toIso8601String(),
      'state': instance.state,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'expired': instance.expired,
      'web_url': instance.webUrl,
    };
