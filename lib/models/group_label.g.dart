// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupLabel _$GroupLabelFromJson(Map<String, dynamic> json) => GroupLabel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      textColor: json['text_color'] as String?,
      description: json['description'] as String?,
      descriptionHtml: json['description_html'] as String?,
      openIssuesCount: json['open_issues_count'] as int?,
      closedIssuesCount: json['closed_issues_count'] as int?,
      openMergeRequestsCount: json['open_merge_requests_count'] as int?,
      subscribed: json['subscribed'] as bool?,
    );

Map<String, dynamic> _$GroupLabelToJson(GroupLabel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'text_color': instance.textColor,
      'description': instance.description,
      'description_html': instance.descriptionHtml,
      'open_issues_count': instance.openIssuesCount,
      'closed_issues_count': instance.closedIssuesCount,
      'open_merge_requests_count': instance.openMergeRequestsCount,
      'subscribed': instance.subscribed,
    };
