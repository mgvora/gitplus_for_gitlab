import 'package:json_annotation/json_annotation.dart';

part 'file_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class FileRequest {
  final String? ref;

  FileRequest({
    this.ref,
  });

  factory FileRequest.fromJson(Map<String, dynamic> json) =>
      _$FileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FileRequestToJson(this);
}
