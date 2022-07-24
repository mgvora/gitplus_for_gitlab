// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsRequest _$EventsRequestFromJson(Map<String, dynamic> json) =>
    EventsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      action: json['action'] as String?,
      targetType: json['target_type'] as String?,
      before: json['before'] == null
          ? null
          : DateTime.parse(json['before'] as String),
      after: json['after'] == null
          ? null
          : DateTime.parse(json['after'] as String),
      scope: json['scope'] as String?,
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$EventsRequestToJson(EventsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('action', instance.action);
  writeNotNull('target_type', instance.targetType);
  writeNotNull('before', instance.before?.toIso8601String());
  writeNotNull('after', instance.after?.toIso8601String());
  writeNotNull('scope', instance.scope);
  writeNotNull('sort', instance.sort);
  return val;
}
