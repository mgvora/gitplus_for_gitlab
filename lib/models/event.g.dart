// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as int?,
      projectId: json['project_id'] as int?,
      targetId: json['target_id'] as int?,
      targetIid: json['target_iid'] as int?,
      actionName: json['action_name'] as String?,
      targetType: json['target_type'] as String?,
      targetTitle: json['target_title'] as String?,
      authorId: json['author_id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      note: json['note'] == null
          ? null
          : Note.fromJson(json['note'] as Map<String, dynamic>),
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      pushData: json['push_data'] == null
          ? null
          : EventPushData.fromJson(json['push_data'] as Map<String, dynamic>),
      authorUsername: json['author_username'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'target_id': instance.targetId,
      'target_iid': instance.targetIid,
      'action_name': instance.actionName,
      'target_type': instance.targetType,
      'target_title': instance.targetTitle,
      'author_id': instance.authorId,
      'created_at': instance.createdAt?.toIso8601String(),
      'note': instance.note,
      'author': instance.author,
      'push_data': instance.pushData,
      'author_username': instance.authorUsername,
    };
