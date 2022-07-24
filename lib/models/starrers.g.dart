// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starrers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Starrer _$StarrerFromJson(Map<String, dynamic> json) => Starrer(
      starredSince: json['starred_since'] as String? ?? "",
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StarrerToJson(Starrer instance) => <String, dynamic>{
      'starred_since': instance.starredSince,
      'user': instance.user,
    };
