import 'package:json_annotation/json_annotation.dart';

part 'find_users_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class FindUsersRequest {
  final int? perPage;
  final int? page;
  final String? search;
  final bool? active;
  final bool? blocked;
  final bool? external;

  FindUsersRequest({
    this.perPage,
    this.page,
    this.search,
    this.active,
    this.blocked,
    this.external,
  });

  factory FindUsersRequest.fromJson(Map<String, dynamic> json) =>
      _$FindUsersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FindUsersRequestToJson(this);
}
