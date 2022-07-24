class EventTargetTypes {
  static const issue = "Issue";
  static const milestone = "Milestone";
  static const mergeRequest = "MergeRequest";
  static const discussionNote = "DiscussionNote";
  static const note = "Note";
  static const diffNote = "DiffNote";
  static const project = "Project";
  static const snippet = "Snippet";
  static const user = "User";
}

class EventActionNames {
  static const approved = "approved";
  static const closed = "closed";
  static const commented = "commented on";
  static const created = "created";
  static const destroyed = "destroyed";
  static const expired = "expired";
  static const joined = "joined";
  static const left = "left";
  static const merged = "merged";
  static const pushedNew = "pushed new";
  static const pushedTo = "pushed to";
  static const reopened = "reopened";
  static const updated = "updated";
  static const opened = "opened";
  static const accepted = "accepted";
}

class AuthorState {
  static const active = "active";
}

class GitLabVisibility {
  static const private = "private";
  static const internal = "internal";
  static const public = "public";
}

class MemberStates {
  static const awaiting = "awaiting";
  static const active = "active";
  static const created = "created";
}

class MemberAccessLevel {
  static const noAccess = 0;
  static const minimalAccess = 5;
  static const guest = 10;
  static const reporter = 20;
  static const developer = 30;
  static const maintaner = 40;
  static const owner = 50;
}

class Sort {
  static const asc = "asc";
  static const desc = "desc";
}

class ProjectRequestOrderBy {
  static const id = "id";
  static const name = "name";
  static const path = "path";
  static const createdAt = "created_at";
  static const updatedAt = "updated_at";
  static const lastActivityAt = "last_activity_at";
  static const similarity = "similarity";
  // only for admins
  static const repositorySize = "repository_size";
  static const storageSize = "storage_size";
  static const packageSize = "packages_size";
  static const wikiSize = "wiki_size";
}

class GroupsRequestOrderBy {
  static const id = "id";
  static const name = "name";
  static const path = "path";
  static const similarity = "similarity";
}

class TreeTypes {
  static const tree = "tree";
  static const blob = "blob";
}

class TagsOrderBy {
  static const name = "name";
  static const updated = "updated";
}

class MilestoneState {
  static const active = "active";
  static const closed = "closed";
}

class IssueType {
  static const issue = "issue";
  static const incident = "incident";
  static const testCase = "test_case";
}

class IssuesOrderBy {
  static const createdAt = "created_at";
  static const dueDate = "due_date";
  static const labelPriority = "label_priority";
  static const milestoneDue = "milestone_due";
  static const popularity = "popularity";
  static const priority = "priority";
  static const relativePosition = "relative_position";
  static const title = "title";
  static const updatedAt = "updated_at";
  static const weight = "weight";
}

class IssuesScope {
  static const createdByMe = "created_by_me";
  static const assignedToMe = "assigned_to_me";
  static const all = "all";
}

class IssueState {
  static const all = "all";
  static const opened = "opened";
  static const closed = "closed";
}

class MergeRequestState {
  static const opened = "opened";
  static const closed = "closed";
  static const locked = "locked";
  static const merged = "merged";
}

class MergeRequestsOrderBy {
  static const createdAt = "created_at";
  static const updatedAt = "updated_at";
}

class MergeRequestScope {
  static const createdByMe = "created_by_me";
  static const assignedToMe = "assigned_to_me";
  static const all = "all";
}

class NotableType {
  static const snippet = "Snippet";
  static const issue = "Issue";
  static const mergeRequest = "MergeRequest";
  static const epic = "Epic";
}

class NotesOrderBy {
  static const createdAt = "created_at";
  static const updatedAt = "updated_at";
}

class IssueStateEvent {
  static const close = "close";
  static const reopen = "reopen";
}

class MergeRequestStateEvent {
  static const close = "close";
  static const reopen = "reopen";
}

class MilestoneStateEvent {
  static const active = "activate";
  static const close = "close";
}
