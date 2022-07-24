// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembersRequest _$MembersRequestFromJson(Map<String, dynamic> json) =>
    MembersRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$MembersRequestToJson(MembersRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('query', instance.query);
  return val;
}
