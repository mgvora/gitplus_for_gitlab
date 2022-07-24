import 'package:json_annotation/json_annotation.dart';

part 'tree_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TreeRequest {
  final int? perPage;
  final int? page;
  final bool? recursive;
  final String? ref;
  final String? path;

  TreeRequest({
    this.perPage = 500,
    this.page,
    this.recursive,
    this.ref,
    this.path,
  });

  factory TreeRequest.fromJson(Map<String, dynamic> json) =>
      _$TreeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TreeRequestToJson(this);
}
