// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diff_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiffRequest _$DiffRequestFromJson(Map<String, dynamic> json) => DiffRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$DiffRequestToJson(DiffRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  return val;
}
