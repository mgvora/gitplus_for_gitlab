// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeStats _$TimeStatsFromJson(Map<String, dynamic> json) => TimeStats(
      timeEstimate: json['time_estimate'] as int?,
      totalTimeSpent: json['total_time_spent'] as int?,
    );

Map<String, dynamic> _$TimeStatsToJson(TimeStats instance) => <String, dynamic>{
      'time_estimate': instance.timeEstimate,
      'total_time_spent': instance.totalTimeSpent,
    };
