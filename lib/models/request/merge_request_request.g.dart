// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merge_request_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MergeRequestRequest _$MergeRequestRequestFromJson(Map<String, dynamic> json) =>
    MergeRequestRequest(
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      state: json['state'] as String?,
      orderBy: json['order_by'] as String?,
      sort: json['sort'] as String?,
      milestone: json['milestone'] as String?,
      view: json['view'] as String?,
      labels: json['labels'] as String?,
      withLabelsDetails: json['with_labels_details'] as bool?,
      withMergeStatusRecheck: json['with_merge_status_recheck'] as bool?,
      createdAfter: json['created_after'] == null
          ? null
          : DateTime.parse(json['created_after'] as String),
      createdBefore: json['created_before'] == null
          ? null
          : DateTime.parse(json['created_before'] as String),
      updatedAfter: json['updated_after'] == null
          ? null
          : DateTime.parse(json['updated_after'] as String),
      scope: json['scope'] as String?,
      authorId: json['author_id'] as int?,
      authorUsername: json['author_username'] as String?,
      assigneeId: json['assignee_id'] as int?,
      approverIds: (json['approver_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      approvedByIds: (json['approved_by_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      reviewerId: json['reviewer_id'] as int?,
      reviewerUsername: json['reviewer_username'] as String?,
      myReactionEmoji: json['my_reaction_emoji'] as String?,
      sourceBranch: json['source_branch'] as String?,
      targetBranch: json['target_branch'] as String?,
      search: json['search'] as String?,
      inScope: json['in'] as String?,
      wip: json['wip'] as String?,
      not: json['not'] as String?,
      environment: json['environment'] as String?,
      deployedBefore: json['deployed_before'] == null
          ? null
          : DateTime.parse(json['deployed_before'] as String),
      deployedAfter: json['deployed_after'] == null
          ? null
          : DateTime.parse(json['deployed_after'] as String),
    );

Map<String, dynamic> _$MergeRequestRequestToJson(MergeRequestRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('per_page', instance.perPage);
  writeNotNull('page', instance.page);
  writeNotNull('state', instance.state);
  writeNotNull('order_by', instance.orderBy);
  writeNotNull('sort', instance.sort);
  writeNotNull('milestone', instance.milestone);
  writeNotNull('view', instance.view);
  writeNotNull('labels', instance.labels);
  writeNotNull('with_labels_details', instance.withLabelsDetails);
  writeNotNull('with_merge_status_recheck', instance.withMergeStatusRecheck);
  writeNotNull('created_after', instance.createdAfter?.toIso8601String());
  writeNotNull('created_before', instance.createdBefore?.toIso8601String());
  writeNotNull('updated_after', instance.updatedAfter?.toIso8601String());
  writeNotNull('scope', instance.scope);
  writeNotNull('author_id', instance.authorId);
  writeNotNull('author_username', instance.authorUsername);
  writeNotNull('assignee_id', instance.assigneeId);
  writeNotNull('approver_ids', instance.approverIds);
  writeNotNull('approved_by_ids', instance.approvedByIds);
  writeNotNull('reviewer_id', instance.reviewerId);
  writeNotNull('reviewer_username', instance.reviewerUsername);
  writeNotNull('my_reaction_emoji', instance.myReactionEmoji);
  writeNotNull('source_branch', instance.sourceBranch);
  writeNotNull('target_branch', instance.targetBranch);
  writeNotNull('search', instance.search);
  writeNotNull('in', instance.inScope);
  writeNotNull('wip', instance.wip);
  writeNotNull('not', instance.not);
  writeNotNull('environment', instance.environment);
  writeNotNull('deployed_before', instance.deployedBefore?.toIso8601String());
  writeNotNull('deployed_after', instance.deployedAfter?.toIso8601String());
  return val;
}
