// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_label_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLabelRequest _$CreateLabelRequestFromJson(Map<String, dynamic> json) =>
    CreateLabelRequest(
      name: json['name'] as String?,
      color: json['color'] as String?,
      description: json['description'] as String?,
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$CreateLabelRequestToJson(CreateLabelRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('color', instance.color);
  writeNotNull('description', instance.description);
  writeNotNull('priority', instance.priority);
  return val;
}
