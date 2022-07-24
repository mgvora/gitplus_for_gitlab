import 'package:json_annotation/json_annotation.dart';

part 'milestones_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class MilestonesRequest {
  final int? perPage;
  final int? page;
  final int? id;
  final List<int>? iids;
  final String? state;
  final String? title;
  final String? search;
  final bool? includeParentMilestones;

  MilestonesRequest({
    this.perPage,
    this.page,
    this.id,
    this.iids,
    this.state,
    this.title,
    this.search,
    this.includeParentMilestones,
  });

  factory MilestonesRequest.fromJson(Map<String, dynamic> json) =>
      _$MilestonesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MilestonesRequestToJson(this);
}
