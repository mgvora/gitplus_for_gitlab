import 'package:json_annotation/json_annotation.dart';

part 'tags_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TagsRequest {
  final int? perPage;
  final int? page;

  final String? orderBy; // TagsOrderBy
  final String? sort; // Sort
  final String? search;

  TagsRequest({
    this.perPage,
    this.page,
    this.orderBy,
    this.sort,
    this.search,
  });

  factory TagsRequest.fromJson(Map<String, dynamic> json) =>
      _$TagsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TagsRequestToJson(this);
}
