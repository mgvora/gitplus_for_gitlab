// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_project_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProjectRequest _$CreateProjectRequestFromJson(
        Map<String, dynamic> json) =>
    CreateProjectRequest(
      name: json['name'] as String?,
      path: json['path'] as String?,
      namespaceId: json['namespace_id'] as String?,
      autoDevopsEnabled: json['auto_devops_enabled'] as bool?,
      description: json['description'] as String?,
      emailsDisabled: json['emails_disabled'] as bool?,
      initializeWithReadme: json['initialize_with_readme'] as bool?,
      visibility: json['visibility'] as String?,
      defaultBranch: json['default_branch'] as String?,
    );

Map<String, dynamic> _$CreateProjectRequestToJson(
    CreateProjectRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('path', instance.path);
  writeNotNull('namespace_id', instance.namespaceId);
  writeNotNull('auto_devops_enabled', instance.autoDevopsEnabled);
  writeNotNull('description', instance.description);
  writeNotNull('emails_disabled', instance.emailsDisabled);
  writeNotNull('initialize_with_readme', instance.initializeWithReadme);
  writeNotNull('visibility', instance.visibility);
  writeNotNull('default_branch', instance.defaultBranch);
  return val;
}
