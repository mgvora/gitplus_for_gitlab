import 'package:json_annotation/json_annotation.dart';

part 'events_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class EventsRequest {
  final int? perPage;
  final int? page;

  final String? action;
  final String? targetType; // EventTargetTypes
  final DateTime? before; // YYYY-MM-DD
  final DateTime? after; // YYYY-MM-DD
  final String? scope;
  final String? sort; // asc, desc

  EventsRequest({
    this.perPage,
    this.page,
    this.action,
    this.targetType,
    this.before,
    this.after,
    this.scope,
    this.sort,
  });

  factory EventsRequest.fromJson(Map<String, dynamic> json) =>
      _$EventsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventsRequestToJson(this);
}
