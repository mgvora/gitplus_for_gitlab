// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileRequest _$FileRequestFromJson(Map<String, dynamic> json) => FileRequest(
      ref: json['ref'] as String?,
    );

Map<String, dynamic> _$FileRequestToJson(FileRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ref', instance.ref);
  return val;
}
