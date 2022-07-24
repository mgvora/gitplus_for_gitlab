// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_project_label_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProjectLabelRequest _$UpdateProjectLabelRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProjectLabelRequest(
      newName: json['new_name'] as String?,
      color: json['color'] as String?,
      description: json['description'] as String?,
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$UpdateProjectLabelRequestToJson(
    UpdateProjectLabelRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('new_name', instance.newName);
  writeNotNull('color', instance.color);
  writeNotNull('description', instance.description);
  writeNotNull('priority', instance.priority);
  return val;
}
