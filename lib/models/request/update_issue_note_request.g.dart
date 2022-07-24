// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_issue_note_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateIssueNoteRequest _$UpdateIssueNoteRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateIssueNoteRequest(
      body: json['body'] as String?,
      confidential: json['confidential'] as bool?,
    );

Map<String, dynamic> _$UpdateIssueNoteRequestToJson(
    UpdateIssueNoteRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('body', instance.body);
  writeNotNull('confidential', instance.confidential);
  return val;
}
