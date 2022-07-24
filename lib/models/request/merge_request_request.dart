import 'package:json_annotation/json_annotation.dart';

part 'merge_request_request.g.dart';

// GET /merge_requests
// GET /merge_requests?state=opened
// GET /merge_requests?state=all
// GET /merge_requests?milestone=release
// GET /merge_requests?labels=bug,reproduced
// GET /merge_requests?author_id=5
// GET /merge_requests?author_username=gitlab-bot
// GET /merge_requests?my_reaction_emoji=star
// GET /merge_requests?scope=assigned_to_me
// GET /merge_requests?search=foo&in=title

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class MergeRequestRequest {
  final int? perPage;
  final int? page;
  final String? state; // MergeRequestState
  final String? orderBy; // MergeRequestsOrderBy
  final String? sort; // Sort
  final String? milestone;
  final String? view;
  final String? labels;
  final bool? withLabelsDetails;
  final bool? withMergeStatusRecheck;
  final DateTime? createdAfter;
  final DateTime? createdBefore;
  final DateTime? updatedAfter;
  final String? scope; // MergeRequestScope
  final int? authorId;
  final String? authorUsername;
  final int? assigneeId;
  final List<int>? approverIds;
  final List<int>? approvedByIds;
  final int? reviewerId;
  final String? reviewerUsername;
  final String? myReactionEmoji;
  final String? sourceBranch;
  final String? targetBranch;
  final String? search;
  @JsonKey(name: 'in')
  final String? inScope; // in title,description - comma separated
  final String? wip;
  final String? not;
  final String? environment;
  final DateTime? deployedBefore;
  final DateTime? deployedAfter;

  MergeRequestRequest({
    this.perPage,
    this.page,
    this.state,
    this.orderBy,
    this.sort,
    this.milestone,
    this.view,
    this.labels,
    this.withLabelsDetails,
    this.withMergeStatusRecheck,
    this.createdAfter,
    this.createdBefore,
    this.updatedAfter,
    this.scope,
    this.authorId,
    this.authorUsername,
    this.assigneeId,
    this.approverIds,
    this.approvedByIds,
    this.reviewerId,
    this.reviewerUsername,
    this.myReactionEmoji,
    this.sourceBranch,
    this.targetBranch,
    this.search,
    this.inScope,
    this.wip,
    this.not,
    this.environment,
    this.deployedBefore,
    this.deployedAfter,
  });

  factory MergeRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$MergeRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MergeRequestRequestToJson(this);
}
