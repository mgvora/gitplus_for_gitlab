import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class File {
  final String? fileName;
  final String? filePath;
  final int? size;
  final String? ref;
  final String? blobId;
  final String? commitId;
  final String? lastCommitId;
  final String? content;

  File({
    this.fileName = "",
    this.filePath = "",
    this.size = 0,
    this.ref = "",
    this.blobId = "",
    this.commitId = "",
    this.lastCommitId = "",
    this.content = "",
  });

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);
}
