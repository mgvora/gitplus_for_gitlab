// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_users_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindUsersRequest _$FindUsersRequestFromJson(Map<String, dynamic> json) =>
    FindUsersRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      search: json['search'] as String?,
      active: json['active'] as bool?,
      blocked: json['blocked'] as bool?,
      external: json['external'] as bool?,
    );

Map<String, dynamic> _$FindUsersRequestToJson(FindUsersRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('search', instance.search);
  writeNotNull('active', instance.active);
  writeNotNull('blocked', instance.blocked);
  writeNotNull('external', instance.external);
  return val;
}
