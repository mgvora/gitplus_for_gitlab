// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commit _$CommitFromJson(Map<String, dynamic> json) => Commit(
      id: json['id'] as String?,
      shortId: json['short_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      parentIds: (json['parent_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      title: json['title'] as String?,
      message: json['message'] as String?,
      authorName: json['author_name'] as String?,
      authorEmail: json['author_email'] as String?,
      authoredDate: json['authored_date'] == null
          ? null
          : DateTime.parse(json['authored_date'] as String),
      commiterName: json['commiter_name'] as String?,
      commiterEmail: json['commiter_email'] as String?,
      commiterDate: json['commiter_date'] == null
          ? null
          : DateTime.parse(json['commiter_date'] as String),
      webUrl: json['web_url'] as String?,
      stats: json['stats'] == null
          ? null
          : CommitStats.fromJson(json['stats'] as Map<String, dynamic>),
      projectId: json['project_id'] as int?,
    );

Map<String, dynamic> _$CommitToJson(Commit instance) => <String, dynamic>{
      'id': instance.id,
      'short_id': instance.shortId,
      'created_at': instance.createdAt?.toIso8601String(),
      'parent_ids': instance.parentIds,
      'title': instance.title,
      'message': instance.message,
      'author_name': instance.authorName,
      'author_email': instance.authorEmail,
      'authored_date': instance.authoredDate?.toIso8601String(),
      'commiter_name': instance.commiterName,
      'commiter_email': instance.commiterEmail,
      'commiter_date': instance.commiterDate?.toIso8601String(),
      'web_url': instance.webUrl,
      'stats': instance.stats,
      'project_id': instance.projectId,
    };
