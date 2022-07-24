import 'package:json_annotation/json_annotation.dart';

part 'members_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class MembersRequest {
  final int? perPage;
  final int? page;
  final String? query;

  MembersRequest({
    this.perPage,
    this.page,
    this.query,
  });

  factory MembersRequest.fromJson(Map<String, dynamic> json) =>
      _$MembersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MembersRequestToJson(this);
}
