import 'package:json_annotation/json_annotation.dart';

part 'update_issue_note_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class UpdateIssueNoteRequest {
  final String? body;
  final bool? confidential;

  UpdateIssueNoteRequest({
    this.body,
    this.confidential,
  });

  factory UpdateIssueNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateIssueNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateIssueNoteRequestToJson(this);
}
