import 'package:json_annotation/json_annotation.dart';

part 'project_labels_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ProjectLabelsRequest {
  final int? perPage;
  final int? page;
  final bool? withCounts;
  final bool? includeAncestorGroups;
  final String? search;

  ProjectLabelsRequest({
    this.perPage,
    this.page,
    this.withCounts,
    this.includeAncestorGroups,
    this.search,
  });

  factory ProjectLabelsRequest.fromJson(Map<String, dynamic> json) =>
      _$ProjectLabelsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectLabelsRequestToJson(this);
}
