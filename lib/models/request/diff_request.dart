import 'package:json_annotation/json_annotation.dart';

part 'diff_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DiffRequest {
  final int? perPage;
  final int? page;

  DiffRequest({
    this.perPage,
    this.page,
  });

  factory DiffRequest.fromJson(Map<String, dynamic> json) =>
      _$DiffRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DiffRequestToJson(this);
}
