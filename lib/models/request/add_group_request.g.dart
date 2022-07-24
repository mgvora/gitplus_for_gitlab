// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddGroupRequest _$AddGroupRequestFromJson(Map<String, dynamic> json) =>
    AddGroupRequest(
      name: json['name'] as String?,
      path: json['path'] as String?,
      visibility: json['visibility'] as String?,
    );

Map<String, dynamic> _$AddGroupRequestToJson(AddGroupRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('path', instance.path);
  writeNotNull('visibility', instance.visibility);
  return val;
}
