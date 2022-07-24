// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_labels_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectLabelsRequest _$ProjectLabelsRequestFromJson(
        Map<String, dynamic> json) =>
    ProjectLabelsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      withCounts: json['with_counts'] as bool?,
      includeAncestorGroups: json['include_ancestor_groups'] as bool?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$ProjectLabelsRequestToJson(
    ProjectLabelsRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('with_counts', instance.withCounts);
  writeNotNull('include_ancestor_groups', instance.includeAncestorGroups);
  writeNotNull('search', instance.search);
  return val;
}
