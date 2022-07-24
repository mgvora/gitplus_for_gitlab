// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starrers_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarrersRequest _$StarrersRequestFromJson(Map<String, dynamic> json) =>
    StarrersRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$StarrersRequestToJson(StarrersRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('search', instance.search);
  return val;
}
