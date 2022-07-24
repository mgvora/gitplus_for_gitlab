// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssuesRequest _$IssuesRequestFromJson(Map<String, dynamic> json) =>
    IssuesRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      assigneeId: json['assignee_id'] as int?,
      assigneeUsername: (json['assignee_username'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      authorId: json['author_id'] as int?,
      authorUsername: json['author_username'] as String?,
      confidential: json['confidential'] as bool?,
      createdAfter: json['created_after'] == null
          ? null
          : DateTime.parse(json['created_after'] as String),
      createdBefore: json['created_before'] == null
          ? null
          : DateTime.parse(json['created_before'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      iids: (json['iids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      inScope: json['in'] as String?,
      issueType: json['issue_type'] as String?,
      iterationId: json['iteration_id'] as int?,
      iterationTitle: json['iteration_title'] as String?,
      labels: json['labels'] as String?,
      milestone: json['milestone'] as String?,
      milestoneId: json['milestone_id'] as String?,
      myReactionEmoji: json['my_reaction_emoji'] as String?,
      nonArchived: json['non_archived'] as bool?,
      not: json['not'] as String?,
      orderBy: json['order_by'] as String?,
      scope: json['scope'] as String?,
      search: json['search'] as String?,
      sort: json['sort'] as String?,
      state: json['state'] as String?,
      updatedAfter: json['updated_after'] == null
          ? null
          : DateTime.parse(json['updated_after'] as String),
      updatedBefore: json['updated_before'] == null
          ? null
          : DateTime.parse(json['updated_before'] as String),
      weight: json['weight'] as int?,
      withLabelsDetails: json['with_labels_details'] as bool?,
    );

Map<String, dynamic> _$IssuesRequestToJson(IssuesRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('assignee_id', instance.assigneeId);
  writeNotNull('assignee_username', instance.assigneeUsername);
  writeNotNull('author_id', instance.authorId);
  writeNotNull('author_username', instance.authorUsername);
  writeNotNull('confidential', instance.confidential);
  writeNotNull('created_after', instance.createdAfter?.toIso8601String());
  writeNotNull('created_before', instance.createdBefore?.toIso8601String());
  writeNotNull('due_date', instance.dueDate?.toIso8601String());
  writeNotNull('iids', instance.iids);
  writeNotNull('in', instance.inScope);
  writeNotNull('issue_type', instance.issueType);
  writeNotNull('iteration_id', instance.iterationId);
  writeNotNull('iteration_title', instance.iterationTitle);
  writeNotNull('labels', instance.labels);
  writeNotNull('milestone', instance.milestone);
  writeNotNull('milestone_id', instance.milestoneId);
  writeNotNull('my_reaction_emoji', instance.myReactionEmoji);
  writeNotNull('non_archived', instance.nonArchived);
  writeNotNull('not', instance.not);
  writeNotNull('order_by', instance.orderBy);
  writeNotNull('scope', instance.scope);
  writeNotNull('search', instance.search);
  writeNotNull('sort', instance.sort);
  writeNotNull('state', instance.state);
  writeNotNull('updated_after', instance.updatedAfter?.toIso8601String());
  writeNotNull('updated_before', instance.updatedBefore?.toIso8601String());
  writeNotNull('weight', instance.weight);
  writeNotNull('with_labels_details', instance.withLabelsDetails);
  return val;
}
