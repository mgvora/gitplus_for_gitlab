import 'package:json_annotation/json_annotation.dart';

part 'add_group_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AddGroupRequest {
  final String? name;
  final String? path;
  final String? visibility; // GitLabVisibility

  AddGroupRequest({
    this.name,
    this.path,
    this.visibility,
  });

  factory AddGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$AddGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddGroupRequestToJson(this);
}
