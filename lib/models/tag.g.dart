// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      commit: json['commit'] == null
          ? null
          : TagCommit.fromJson(json['commit'] as Map<String, dynamic>),
      release: json['release'] == null
          ? null
          : TagRelase.fromJson(json['release'] as Map<String, dynamic>),
      name: json['name'] as String?,
      target: json['target'] as String?,
      message: json['message'] as String?,
      protected: json['protected'] as bool?,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'commit': instance.commit,
      'release': instance.release,
      'name': instance.name,
      'target': instance.target,
      'message': instance.message,
      'protected': instance.protected,
    };
