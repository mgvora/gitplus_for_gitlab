import 'package:json_annotation/json_annotation.dart';

part 'commits_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CommitsReqest {
  final int? perPage;
  final int? page;
  final String? refName;
  final DateTime? since;
  final DateTime? until;
  final String? path;
  final bool? all;
  final bool? withStatus;
  final bool? firstParent;
  final String? order;
  final bool? trailers;

  CommitsReqest({
    this.perPage,
    this.page,
    this.refName,
    this.since,
    this.until,
    this.path,
    this.all,
    this.withStatus,
    this.firstParent,
    this.order,
    this.trailers,
  });

  factory CommitsReqest.fromJson(Map<String, dynamic> json) =>
      _$CommitsReqestFromJson(json);

  Map<String, dynamic> toJson() => _$CommitsReqestToJson(this);
}
