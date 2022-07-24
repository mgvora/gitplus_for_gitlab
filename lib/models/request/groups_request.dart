import 'package:json_annotation/json_annotation.dart';

part 'groups_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class GroupsRequest {
  final int? perPage;
  final int? page;
  final bool? allAvailable;
  final String? search;
  final String? orderBy; // GroupsRequestOrderBy
  final String? sort; // Sort
  final bool? statistics;
  final bool? withCustomAttributes;
  final bool? owned;
  final int? minAccessLevel;
  final bool? topLevelOnly;

  GroupsRequest({
    this.perPage,
    this.page,
    this.allAvailable,
    this.search,
    this.orderBy,
    this.sort,
    this.statistics,
    this.withCustomAttributes,
    this.owned,
    this.minAccessLevel,
    this.topLevelOnly,
  });

  factory GroupsRequest.fromJson(Map<String, dynamic> json) =>
      _$GroupsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsRequestToJson(this);
}
