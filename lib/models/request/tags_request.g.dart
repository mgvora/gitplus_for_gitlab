// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagsRequest _$TagsRequestFromJson(Map<String, dynamic> json) => TagsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      orderBy: json['order_by'] as String?,
      sort: json['sort'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$TagsRequestToJson(TagsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('order_by', instance.orderBy);
  writeNotNull('sort', instance.sort);
  writeNotNull('search', instance.search);
  return val;
}
