// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeRequest _$TreeRequestFromJson(Map<String, dynamic> json) => TreeRequest(
      perPage: json['per_page'] as int? ?? 500,
      page: json['page'] as int?,
      recursive: json['recursive'] as bool?,
      ref: json['ref'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$TreeRequestToJson(TreeRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('recursive', instance.recursive);
  writeNotNull('ref', instance.ref);
  writeNotNull('path', instance.path);
  return val;
}
