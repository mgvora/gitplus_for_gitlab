import 'package:json_annotation/json_annotation.dart';

part 'issues_request.g.dart';

// GET /issues
// GET /issues?assignee_id=5
// GET /issues?author_id=5
// GET /issues?confidential=true
// GET /issues?iids[]=42&iids[]=43
// GET /issues?labels=foo
// GET /issues?labels=foo,bar
// GET /issues?labels=foo,bar&state=opened
// GET /issues?milestone=1.0.0
// GET /issues?milestone=1.0.0&state=opened
// GET /issues?my_reaction_emoji=star
// GET /issues?search=foo&in=title
// GET /issues?state=closed
// GET /issues?state=opened

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class IssuesRequest {
  final int? perPage;
  final int? page;
  final int? assigneeId;
  final List<String>? assigneeUsername;
  final int? authorId;
  final String? authorUsername;
  final bool? confidential;
  final DateTime? createdAfter;
  final DateTime? createdBefore;
  final DateTime? dueDate;
  final List<int>? iids;
  @JsonKey(name: 'in')
  final String? inScope; // in title,description - comma separated
  final String? issueType; // IssueType
  final int? iterationId;
  final String? iterationTitle;
  final String? labels; // comma separated
  final String? milestone;
  final String? milestoneId;
  final String? myReactionEmoji;
  final bool? nonArchived;
  final String? not; // not is invalid
  final String? orderBy; // IssuesOrderBy
  final String? scope; // IssuesScope
  final String? search; // in title or description
  final String? sort; // Sort
  final String? state; // IssuesState
  final DateTime? updatedAfter;
  final DateTime? updatedBefore;
  final int? weight;
  final bool? withLabelsDetails;

  IssuesRequest({
    this.perPage,
    this.page,
    this.assigneeId,
    this.assigneeUsername,
    this.authorId,
    this.authorUsername,
    this.confidential,
    this.createdAfter,
    this.createdBefore,
    this.dueDate,
    this.iids,
    this.inScope,
    this.issueType,
    this.iterationId,
    this.iterationTitle,
    this.labels,
    this.milestone,
    this.milestoneId,
    this.myReactionEmoji,
    this.nonArchived,
    this.not,
    this.orderBy,
    this.scope,
    this.search,
    this.sort,
    this.state,
    this.updatedAfter,
    this.updatedBefore,
    this.weight,
    this.withLabelsDetails,
  });

  factory IssuesRequest.fromJson(Map<String, dynamic> json) =>
      _$IssuesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$IssuesRequestToJson(this);
}
