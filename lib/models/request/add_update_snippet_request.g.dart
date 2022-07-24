// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_update_snippet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUpdateSnippetRequest _$AddUpdateSnippetRequestFromJson(
        Map<String, dynamic> json) =>
    AddUpdateSnippetRequest(
      title: json['title'] as String?,
      fileName: json['file_name'] as String?,
      content: json['content'] as String?,
      description: json['description'] as String?,
      visibility: json['visibility'] as String?,
    );

Map<String, dynamic> _$AddUpdateSnippetRequestToJson(
    AddUpdateSnippetRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('file_name', instance.fileName);
  writeNotNull('content', instance.content);
  writeNotNull('description', instance.description);
  writeNotNull('visibility', instance.visibility);
  return val;
}
