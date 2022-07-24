// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      fileName: json['file_name'] as String? ?? "",
      filePath: json['file_path'] as String? ?? "",
      size: json['size'] as int? ?? 0,
      ref: json['ref'] as String? ?? "",
      blobId: json['blob_id'] as String? ?? "",
      commitId: json['commit_id'] as String? ?? "",
      lastCommitId: json['last_commit_id'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'file_name': instance.fileName,
      'file_path': instance.filePath,
      'size': instance.size,
      'ref': instance.ref,
      'blob_id': instance.blobId,
      'commit_id': instance.commitId,
      'last_commit_id': instance.lastCommitId,
      'content': instance.content,
    };
