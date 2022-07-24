import 'package:json_annotation/json_annotation.dart';

part 'branches_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class BranchesRequest {
  final int? perPage;
  final int? page;

  final String? id;
  final String? search;

  BranchesRequest({
    this.perPage,
    this.page,
    this.id,
    this.search,
  });

  factory BranchesRequest.fromJson(Map<String, dynamic> json) =>
      _$BranchesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BranchesRequestToJson(this);
}
