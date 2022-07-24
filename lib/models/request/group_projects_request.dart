import 'package:json_annotation/json_annotation.dart';

part 'group_projects_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class GroupProjectsRequest {
  final int? perPage;
  final int? page;
  final int? id; // required
  final bool? archived;
  final String? visibility; // GitLabVisibility
  final String? orderBy; // ProjectRequestOrderBy
  final String? sort;
  final String? search;
  final bool? simple;
  final bool? owned;
  final bool? starred;
  final bool? withIssuesEnabled;
  final bool? withMergeRequestsEnabled;
  final bool? withShared;
  final bool? includeSubgroups;
  final int? minAccessLevel; // MemberAccessLevel

  GroupProjectsRequest({
    this.perPage,
    this.page,
    this.id,
    this.archived,
    this.visibility,
    this.orderBy,
    this.sort,
    this.search,
    this.simple,
    this.owned,
    this.starred,
    this.withIssuesEnabled,
    this.withMergeRequestsEnabled,
    this.withShared,
    this.includeSubgroups,
    this.minAccessLevel,
  });

  factory GroupProjectsRequest.fromJson(Map<String, dynamic> json) =>
      _$GroupProjectsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GroupProjectsRequestToJson(this);
}
