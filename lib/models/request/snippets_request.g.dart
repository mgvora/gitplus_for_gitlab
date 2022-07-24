// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippets_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnippetsRequest _$SnippetsRequestFromJson(Map<String, dynamic> json) =>
    SnippetsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$SnippetsRequestToJson(SnippetsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  return val;
}
