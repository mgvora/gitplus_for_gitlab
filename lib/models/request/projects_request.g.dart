// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectsRequest _$ProjectsRequestFromJson(Map<String, dynamic> json) =>
    ProjectsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      search: json['search'] as String?,
      membership: json['membership'] as bool?,
      simple: json['simple'] as bool?,
      starred: json['starred'] as bool?,
      visibility: json['visibility'] as String?,
      orderBy: json['order_by'] as String?,
      sort: json['sort'] as String? ?? "desc",
    );

Map<String, dynamic> _$ProjectsRequestToJson(ProjectsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('search', instance.search);
  writeNotNull('membership', instance.membership);
  writeNotNull('simple', instance.simple);
  writeNotNull('starred', instance.starred);
  writeNotNull('visibility', instance.visibility);
  writeNotNull('order_by', instance.orderBy);
  writeNotNull('sort', instance.sort);
  return val;
}
