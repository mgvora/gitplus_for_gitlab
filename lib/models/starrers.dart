import 'package:gitplus_for_gitlab/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'starrers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Starrer {
  final String? starredSince;
  final User? user;

  Starrer({
    this.starredSince = "",
    this.user,
  });

  factory Starrer.fromJson(Map<String, dynamic> json) =>
      _$StarrerFromJson(json);

  Map<String, dynamic> toJson() => _$StarrerToJson(this);
}
