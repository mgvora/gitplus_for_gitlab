// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      name: json['name'] as String?,
      merged: json['merged'] as bool?,
      protected: json['protected'] as bool?,
      webUrl: json['web_url'] as String?,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'name': instance.name,
      'merged': instance.merged,
      'protected': instance.protected,
      'web_url': instance.webUrl,
    };
