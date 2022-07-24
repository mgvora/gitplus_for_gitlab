// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tree _$TreeFromJson(Map<String, dynamic> json) => Tree(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      path: json['path'] as String?,
      mode: json['mode'] as String?,
    );

Map<String, dynamic> _$TreeToJson(Tree instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'path': instance.path,
      'mode': instance.mode,
    };
