import 'package:json_annotation/json_annotation.dart';

part 'time_stats.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TimeStats {
  final int? timeEstimate;
  final int? totalTimeSpent;
  // final String? humanTimeEstimate;
  // final String? humanTimeSpent;

  TimeStats({
    this.timeEstimate,
    this.totalTimeSpent,
  });

  factory TimeStats.fromJson(Map<String, dynamic> json) =>
      _$TimeStatsFromJson(json);

  Map<String, dynamic> toJson() => _$TimeStatsToJson(this);
}
