import 'package:json_annotation/json_annotation.dart';

part 'snippets_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class SnippetsRequest {
  final int? perPage;
  final int? page;

  SnippetsRequest({
    this.perPage,
    this.page,
  });

  factory SnippetsRequest.fromJson(Map<String, dynamic> json) =>
      _$SnippetsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetsRequestToJson(this);
}
