// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_projects_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupProjectsRequest _$GroupProjectsRequestFromJson(
        Map<String, dynamic> json) =>
    GroupProjectsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      id: json['id'] as int?,
      archived: json['archived'] as bool?,
      visibility: json['visibility'] as String?,
      orderBy: json['order_by'] as String?,
      sort: json['sort'] as String?,
      search: json['search'] as String?,
      simple: json['simple'] as bool?,
      owned: json['owned'] as bool?,
      starred: json['starred'] as bool?,
      withIssuesEnabled: json['with_issues_enabled'] as bool?,
      withMergeRequestsEnabled: json['with_merge_requests_enabled'] as bool?,
      withShared: json['with_shared'] as bool?,
      includeSubgroups: json['include_subgroups'] as bool?,
      minAccessLevel: json['min_access_level'] as int?,
    );

Map<String, dynamic> _$GroupProjectsRequestToJson(
    GroupProjectsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('id', instance.id);
  writeNotNull('archived', instance.archived);
  writeNotNull('visibility', instance.visibility);
  writeNotNull('order_by', instance.orderBy);
  writeNotNull('sort', instance.sort);
  writeNotNull('search', instance.search);
  writeNotNull('simple', instance.simple);
  writeNotNull('owned', instance.owned);
  writeNotNull('starred', instance.starred);
  writeNotNull('with_issues_enabled', instance.withIssuesEnabled);
  writeNotNull(
      'with_merge_requests_enabled', instance.withMergeRequestsEnabled);
  writeNotNull('with_shared', instance.withShared);
  writeNotNull('include_subgroups', instance.includeSubgroups);
  writeNotNull('min_access_level', instance.minAccessLevel);
  return val;
}
