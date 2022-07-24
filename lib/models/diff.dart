import 'package:json_annotation/json_annotation.dart';

part 'diff.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Diff {
  final String? diff;
  final String? newPath;
  final String? oldPath;
  final String? aMode;
  final String? bMode;
  final bool? newFile;
  final bool? renamedFile;
  final bool? deletedFile;

  Diff({
    this.diff,
    this.newPath,
    this.oldPath,
    this.aMode,
    this.bMode,
    this.newFile,
    this.renamedFile,
    this.deletedFile,
  });

  factory Diff.fromJson(Map<String, dynamic> json) => _$DiffFromJson(json);

  Map<String, dynamic> toJson() => _$DiffToJson(this);
}
