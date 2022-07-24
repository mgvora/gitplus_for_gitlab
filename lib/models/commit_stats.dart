import 'package:json_annotation/json_annotation.dart';

part 'commit_stats.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommitStats {
  final int? additions;
  final int? deletions;
  final int? total;

  CommitStats({
    this.additions,
    this.deletions,
    this.total,
  });

  factory CommitStats.fromJson(Map<String, dynamic> json) =>
      _$CommitStatsFromJson(json);

  Map<String, dynamic> toJson() => _$CommitStatsToJson(this);
}
