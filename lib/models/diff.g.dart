// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diff _$DiffFromJson(Map<String, dynamic> json) => Diff(
      diff: json['diff'] as String?,
      newPath: json['new_path'] as String?,
      oldPath: json['old_path'] as String?,
      aMode: json['a_mode'] as String?,
      bMode: json['b_mode'] as String?,
      newFile: json['new_file'] as bool?,
      renamedFile: json['renamed_file'] as bool?,
      deletedFile: json['deleted_file'] as bool?,
    );

Map<String, dynamic> _$DiffToJson(Diff instance) => <String, dynamic>{
      'diff': instance.diff,
      'new_path': instance.newPath,
      'old_path': instance.oldPath,
      'a_mode': instance.aMode,
      'b_mode': instance.bMode,
      'new_file': instance.newFile,
      'renamed_file': instance.renamedFile,
      'deleted_file': instance.deletedFile,
    };
