import 'package:json_annotation/json_annotation.dart';

part 'starrers_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class StarrersRequest {
  final int? perPage;
  final int? page;
  final String? search;
  StarrersRequest({
    this.perPage,
    this.page,
    this.search,
  });

  factory StarrersRequest.fromJson(Map<String, dynamic> json) =>
      _$StarrersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StarrersRequestToJson(this);
}
