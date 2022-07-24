// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectRequest _$ProjectRequestFromJson(Map<String, dynamic> json) =>
    ProjectRequest(
      license: json['license'] as bool?,
      statistics: json['statistics'] as bool?,
      withCustomAttributes: json['with_custom_attributes'] as bool?,
    );

Map<String, dynamic> _$ProjectRequestToJson(ProjectRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('license', instance.license);
  writeNotNull('statistics', instance.statistics);
  writeNotNull('with_custom_attributes', instance.withCustomAttributes);
  return val;
}
