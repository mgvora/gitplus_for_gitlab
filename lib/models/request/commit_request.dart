import 'package:json_annotation/json_annotation.dart';

part 'commit_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CommitReqest {
  final bool? stats;

  CommitReqest({
    this.stats,
  });

  factory CommitReqest.fromJson(Map<String, dynamic> json) =>
      _$CommitReqestFromJson(json);

  Map<String, dynamic> toJson() => _$CommitReqestToJson(this);
}
