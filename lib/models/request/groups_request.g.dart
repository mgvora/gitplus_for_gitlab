// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupsRequest _$GroupsRequestFromJson(Map<String, dynamic> json) =>
    GroupsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      allAvailable: json['all_available'] as bool?,
      search: json['search'] as String?,
      orderBy: json['order_by'] as String?,
      sort: json['sort'] as String?,
      statistics: json['statistics'] as bool?,
      withCustomAttributes: json['with_custom_attributes'] as bool?,
      owned: json['owned'] as bool?,
      minAccessLevel: json['min_access_level'] as int?,
      topLevelOnly: json['top_level_only'] as bool?,
    );

Map<String, dynamic> _$GroupsRequestToJson(GroupsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('all_available', instance.allAvailable);
  writeNotNull('search', instance.search);
  writeNotNull('order_by', instance.orderBy);
  writeNotNull('sort', instance.sort);
  writeNotNull('statistics', instance.statistics);
  writeNotNull('with_custom_attributes', instance.withCustomAttributes);
  writeNotNull('owned', instance.owned);
  writeNotNull('min_access_level', instance.minAccessLevel);
  writeNotNull('top_level_only', instance.topLevelOnly);
  return val;
}
