// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commits_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitsReqest _$CommitsReqestFromJson(Map<String, dynamic> json) =>
    CommitsReqest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      refName: json['ref_name'] as String?,
      since: json['since'] == null
          ? null
          : DateTime.parse(json['since'] as String),
      until: json['until'] == null
          ? null
          : DateTime.parse(json['until'] as String),
      path: json['path'] as String?,
      all: json['all'] as bool?,
      withStatus: json['with_status'] as bool?,
      firstParent: json['first_parent'] as bool?,
      order: json['order'] as String?,
      trailers: json['trailers'] as bool?,
    );

Map<String, dynamic> _$CommitsReqestToJson(CommitsReqest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('ref_name', instance.refName);
  writeNotNull('since', instance.since?.toIso8601String());
  writeNotNull('until', instance.until?.toIso8601String());
  writeNotNull('path', instance.path);
  writeNotNull('all', instance.all);
  writeNotNull('with_status', instance.withStatus);
  writeNotNull('first_parent', instance.firstParent);
  writeNotNull('order', instance.order);
  writeNotNull('trailers', instance.trailers);
  return val;
}
