import 'package:json_annotation/json_annotation.dart';

part 'add_member_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AddMemberRequest {
  final int? id;
  final String? userId; // separated by commas
  final int? accessLevel; // MemberAccessLevel
  final String? expiresAt; // YEAR-MONTH-DAY
  final String? inviteSource;
  final int? tasksProjectId;

  AddMemberRequest({
    this.id = -1,
    this.userId,
    this.accessLevel,
    this.expiresAt,
    this.inviteSource,
    this.tasksProjectId,
  });

  factory AddMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMemberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddMemberRequestToJson(this);
}
