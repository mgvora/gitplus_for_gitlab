// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchesRequest _$BranchesRequestFromJson(Map<String, dynamic> json) =>
    BranchesRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      id: json['id'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$BranchesRequestToJson(BranchesRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('id', instance.id);
  writeNotNull('search', instance.search);
  return val;
}
