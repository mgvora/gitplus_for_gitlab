import 'package:json_annotation/json_annotation.dart';

part 'projects_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ProjectsRequest {
  final int? perPage;
  final int? page;
  final String? search;
  final bool? membership;
  final bool? simple;
  final bool? starred;
  final String? visibility; // GitLabVisibility
  final String? orderBy; // ProjectRequestOrderBy
  final String? sort;

  ProjectsRequest({
    this.perPage,
    this.page,
    this.search,
    this.membership,
    this.simple,
    this.starred,
    this.visibility,
    this.orderBy,
    this.sort = "desc",
  });

  factory ProjectsRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectsRequestToJson(this);
}
