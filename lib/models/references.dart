import 'package:json_annotation/json_annotation.dart';

part 'references.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class References {
  final String? short;
  final String? relative;
  final String? full;

  References({
    this.short,
    this.relative,
    this.full,
  });

  factory References.fromJson(Map<String, dynamic> json) =>
      _$ReferencesFromJson(json);

  Map<String, dynamic> toJson() => _$ReferencesToJson(this);
}
