import 'package:json_annotation/json_annotation.dart';

part 'group_label.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GroupLabel {
  final int? id;
  final String? name;
  final String? color;
  final String? textColor;
  final String? description;
  final String? descriptionHtml;
  final int? openIssuesCount;
  final int? closedIssuesCount;
  final int? openMergeRequestsCount;
  final bool? subscribed;

  GroupLabel({
    this.id,
    this.name,
    this.color,
    this.textColor,
    this.description,
    this.descriptionHtml,
    this.openIssuesCount,
    this.closedIssuesCount,
    this.openMergeRequestsCount,
    this.subscribed,
  });

  factory GroupLabel.fromJson(Map<String, dynamic> json) =>
      _$GroupLabelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupLabelToJson(this);
}
