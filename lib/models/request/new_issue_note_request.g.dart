// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_issue_note_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewIssueNoteRequest _$NewIssueNoteRequestFromJson(Map<String, dynamic> json) =>
    NewIssueNoteRequest(
      body: json['body'] as String?,
      confidential: json['confidential'] as bool?,
    );

Map<String, dynamic> _$NewIssueNoteRequestToJson(NewIssueNoteRequest instance) {
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
