// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      id: json['id'] as int?,
      body: json['body'] as String?,
      attachement: json['attachement'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      system: json['system'] as bool?,
      noteableId: json['noteable_id'] as int?,
      noteableType: json['noteable_type'] as String?,
      noteableIid: json['noteable_iid'] as int?,
      resolvable: json['resolvable'] as bool?,
      confidential: json['confidential'] as bool?,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'attachement': instance.attachement,
      'author': instance.author,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'system': instance.system,
      'noteable_id': instance.noteableId,
      'noteable_type': instance.noteableType,
      'noteable_iid': instance.noteableIid,
      'resolvable': instance.resolvable,
      'confidential': instance.confidential,
    };
