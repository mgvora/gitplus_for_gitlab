// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitReqest _$CommitReqestFromJson(Map<String, dynamic> json) => CommitReqest(
      stats: json['stats'] as bool?,
    );

Map<String, dynamic> _$CommitReqestToJson(CommitReqest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stats', instance.stats);
  return val;
}
