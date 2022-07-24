// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesRequest _$NotesRequestFromJson(Map<String, dynamic> json) => NotesRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      sort: json['sort'] as String?,
      orderBy: json['order_by'] as String?,
    );

Map<String, dynamic> _$NotesRequestToJson(NotesRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('sort', instance.sort);
  writeNotNull('order_by', instance.orderBy);
  return val;
}
