import 'package:json_annotation/json_annotation.dart';

part 'group_labels_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class GroupLabelsRequest {
  final int? perPage;
  final int? page;
  final bool? withCounts;
  final bool? includeAncestorGroups;
  final bool? includeDescendantGroups;
  final bool? onlyGroupLabels;
  final String? search;

  GroupLabelsRequest({
    this.perPage,
    this.page,
    this.withCounts,
    this.includeAncestorGroups,
    this.includeDescendantGroups,
    this.onlyGroupLabels,
    this.search,
  });

  factory GroupLabelsRequest.fromJson(Map<String, dynamic> json) =>
      _$GroupLabelsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GroupLabelsRequestToJson(this);
}
