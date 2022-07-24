// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_push_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPushData _$EventPushDataFromJson(Map<String, dynamic> json) =>
    EventPushData(
      commitCount: json['commit_count'] as int?,
      action: json['action'] as String?,
      refType: json['ref_type'] as String?,
      commitFrom: json['commit_from'] as String?,
      commitTo: json['commit_to'] as String?,
      ref: json['ref'] as String?,
      commitTitle: json['commit_title'] as String?,
      refCount: json['ref_count'] as int?,
    );

Map<String, dynamic> _$EventPushDataToJson(EventPushData instance) =>
    <String, dynamic>{
      'commit_count': instance.commitCount,
      'action': instance.action,
      'ref_type': instance.refType,
      'commit_from': instance.commitFrom,
      'commit_to': instance.commitTo,
      'ref': instance.ref,
      'commit_title': instance.commitTitle,
      'ref_count': instance.refCount,
    };
