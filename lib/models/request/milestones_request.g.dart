// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestones_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MilestonesRequest _$MilestonesRequestFromJson(Map<String, dynamic> json) =>
    MilestonesRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      id: json['id'] as int?,
      iids: (json['iids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      state: json['state'] as String?,
      title: json['title'] as String?,
      search: json['search'] as String?,
      includeParentMilestones: json['include_parent_milestones'] as bool?,
    );

Map<String, dynamic> _$MilestonesRequestToJson(MilestonesRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('id', instance.id);
  writeNotNull('iids', instance.iids);
  writeNotNull('state', instance.state);
  writeNotNull('title', instance.title);
  writeNotNull('search', instance.search);
  writeNotNull('include_parent_milestones', instance.includeParentMilestones);
  return val;
}
