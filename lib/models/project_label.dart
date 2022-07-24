import 'package:json_annotation/json_annotation.dart';

part 'project_label.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProjectLabel {
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
  final int? priority;
  final bool? isProjectLabel;

  ProjectLabel({
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
    this.priority,
    this.isProjectLabel,
  });

  factory ProjectLabel.fromJson(Map<String, dynamic> json) =>
      _$ProjectLabelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectLabelToJson(this);
}
