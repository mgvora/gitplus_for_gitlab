import 'package:json_annotation/json_annotation.dart';

part 'notes_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class NotesRequest {
  final int? perPage;
  final int? page;
  final String? sort; // Sort
  final String? orderBy; // NotesOrderBy

  NotesRequest({
    this.perPage,
    this.page,
    this.sort,
    this.orderBy,
  });

  factory NotesRequest.fromJson(Map<String, dynamic> json) =>
      _$NotesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotesRequestToJson(this);
}
