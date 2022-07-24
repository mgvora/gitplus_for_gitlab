// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitStats _$CommitStatsFromJson(Map<String, dynamic> json) => CommitStats(
      additions: json['additions'] as int?,
      deletions: json['deletions'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$CommitStatsToJson(CommitStats instance) =>
    <String, dynamic>{
      'additions': instance.additions,
      'deletions': instance.deletions,
      'total': instance.total,
    };
