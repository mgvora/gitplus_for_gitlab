// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_labels_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupLabelsRequest _$GroupLabelsRequestFromJson(Map<String, dynamic> json) =>
    GroupLabelsRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      withCounts: json['with_counts'] as bool?,
      includeAncestorGroups: json['include_ancestor_groups'] as bool?,
      includeDescendantGroups: json['include_descendant_groups'] as bool?,
      onlyGroupLabels: json['only_group_labels'] as bool?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$GroupLabelsRequestToJson(GroupLabelsRequest instance) {
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
  writeNotNull('include_descendant_groups', instance.includeDescendantGroups);
  writeNotNull('only_group_labels', instance.onlyGroupLabels);
  writeNotNull('search', instance.search);
  return val;
}
