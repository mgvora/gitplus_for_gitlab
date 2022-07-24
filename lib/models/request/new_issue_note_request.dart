import 'package:json_annotation/json_annotation.dart';

part 'new_issue_note_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class NewIssueNoteRequest {
  final String? body;
  final bool? confidential;

  NewIssueNoteRequest({
    this.body,
    this.confidential,
  });

  factory NewIssueNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$NewIssueNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewIssueNoteRequestToJson(this);
}
