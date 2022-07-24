import 'dart:async';
import 'package:dio/dio.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/models/request/access_token_request_password.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  /// :user

  Future<AccessTokenResponse?> signInPassword(
      AccessTokenReqestPassword data) async {
    final res = await apiProvider.accessTokenPassword('/oauth/token', data);
    if (res.statusCode == 200) {
      return AccessTokenResponse.fromJson(res.data);
    }
    return null;
  }

  Future<AccessTokenResponse?> accessToken(AccessTokenReqest data) async {
    final res = await apiProvider.accessToken('/oauth/token', data);
    if (res.statusCode == 200) {
      return AccessTokenResponse.fromJson(res.data);
    }
    return null;
  }

  Future<AccessTokenResponse?> refreshToken(RefreshTokenRequest data) async {
    final res = await apiProvider.refreshToken('/oauth/token', data);
    if (res.statusCode == 200) {
      return AccessTokenResponse.fromJson(res.data);
    }
    return null;
  }

  Future<PagingResponse<User>?> listUsers(FindUsersRequest data) async {
    final res = await apiProvider.listUsers('/api/v4/users', data);
    if (res.statusCode == 200) {
      var data = <User>[];
      for (var item in res.data) {
        data.add(User.fromJson(item));
      }
      return constructResponse<User>(res, data);
    }
    return null;
  }

  Future<User?> getUser() async {
    final res = await apiProvider.getUser('/api/v4/user');
    if (res.statusCode == 200) {
      return User.fromJson(res.data);
    }
    return null;
  }

  /// :project

  Future<PagingResponse<Project>?> listProjects(ProjectsRequest data) async {
    final res = await apiProvider.listProjects('/api/v4/projects', data);
    if (res.statusCode == 200) {
      var data = <Project>[];
      for (var item in res.data) {
        data.add(Project.fromJson(item));
      }
      return constructResponse<Project>(res, data);
    }
    return null;
  }

  Future<Project?> getProject(int id, ProjectRequest data) async {
    final res = await apiProvider.getProject('/api/v4/projects/$id', data);
    if (res.statusCode == 200) {
      return Project.fromJson(res.data);
    }
    return null;
  }

  Future<bool> updateProject(int projectId, CreateProjectRequest data) async {
    final res =
        await apiProvider.updateProject('/api/v4/projects/$projectId', data);
    return res.statusCode == 200;
  }

  Future<bool> createProject(CreateProjectRequest data) async {
    final res = await apiProvider.createProject('/api/v4/projects', data);
    return res.statusCode == 200;
  }

  Future<Project?> deleteProject(int id) async {
    final res = await apiProvider.deleteProject('/api/v4/projects/$id');
    if (res.statusCode == 200) {
      return Project.fromJson(res.data);
    }
    return null;
  }

  Future<void> starProject(int id) async {
    await apiProvider.starUnstarProject('/api/v4/projects/$id/star');
  }

  Future<void> unstarProject(int id) async {
    await apiProvider.starUnstarProject('/api/v4/projects/$id/unstar');
  }

  Future<PagingResponse<Starrer>?> listProjectStarrers(
      int id, StarrersRequest data) async {
    final res = await apiProvider.listProjectStarrers(
        '/api/v4/projects/$id/starrers', data);
    if (res.statusCode == 200) {
      var data = <Starrer>[];
      for (var item in res.data) {
        data.add(Starrer.fromJson(item));
      }
      return constructResponse<Starrer>(res, data);
    }
    return null;
  }

  Future<PagingResponse<Branch>?> listBranches(
      int projectId, BranchesRequest data) async {
    final res = await apiProvider.listBranches(
        '/api/v4/projects/$projectId/repository/branches', data);
    if (res.statusCode == 200) {
      var data = <Branch>[];
      for (var item in res.data) {
        data.add(Branch.fromJson(item));
      }
      return constructResponse<Branch>(res, data);
    }
    return null;
  }

  Future<PagingResponse<Tag>?> listTags(int id, TagsRequest data) async {
    final res = await apiProvider.listTags(
        '/api/v4/projects/$id/repository/tags', data);
    if (res.statusCode == 200) {
      var data = <Tag>[];
      for (var item in res.data) {
        data.add(Tag.fromJson(item));
      }
      return constructResponse<Tag>(res, data);
    }
    return null;
  }

  Future<PagingResponse<Tree>?> listRepositoryTree(
      int id, TreeRequest data) async {
    final res = await apiProvider.listRepositoryTree(
        '/api/v4/projects/$id/repository/tree', data);
    if (res.statusCode == 200) {
      var data = <Tree>[];
      for (var item in res.data) {
        data.add(Tree.fromJson(item));
      }
      return constructResponse<Tree>(res, data);
    }
    return null;
  }

  Future<File?> getFile(
      int projectId, String filePath, FileRequest data) async {
    var encoded = Uri.encodeComponent(filePath);
    final res = await apiProvider.getFile(
        '/api/v4/projects/$projectId/repository/files/$encoded', data);
    if (res.statusCode == 200) {
      return File.fromJson(res.data);
    }
    return null;
  }

  Future<PagingResponse<Member>?> listProjectMembers(
      int id, MembersRequest data) async {
    final res =
        await apiProvider.listMembers('/api/v4/projects/$id/members', data);
    if (res.statusCode == 200) {
      var data = <Member>[];
      for (var item in res.data) {
        data.add(Member.fromJson(item));
      }
      return constructResponse<Member>(res, data);
    }
    return null;
  }

  Future<bool> addProjectMember(int id, AddMemberRequest data) async {
    final res =
        await apiProvider.addMember('/api/v4/projects/$id/members', data);
    return res.statusCode == 200;
  }

  Future<bool> removeProjectMember(int projectId, int memberId) async {
    final res = await apiProvider
        .removeMember('/api/v4/projects/$projectId/members/$memberId');
    return res.statusCode == 200;
  }

  /// :groups

  Future<PagingResponse<Group>?> listGroups(GroupsRequest data) async {
    final res = await apiProvider.listGroups('/api/v4/groups', data);
    if (res.statusCode == 200) {
      var data = <Group>[];
      for (var item in res.data) {
        data.add(Group.fromJson(item));
      }
      return constructResponse<Group>(res, data);
    }
    return null;
  }

  Future<bool> addGroup(AddGroupRequest data) async {
    final res = await apiProvider.addGroup('/api/v4/groups', data);
    return res.statusCode == 200;
  }

  Future<PagingResponse<Project>?> listGroupProjects(
      int groupId, GroupProjectsRequest data) async {
    final res = await apiProvider.listGroupProjects(
        '/api/v4/groups/$groupId/projects', data);
    if (res.statusCode == 200) {
      var data = <Project>[];
      for (var item in res.data) {
        data.add(Project.fromJson(item));
      }
      return constructResponse<Project>(res, data);
    }
    return null;
  }

  Future<PagingResponse<Member>?> listGroupMembers(
      int id, MembersRequest data) async {
    final res =
        await apiProvider.listMembers('/api/v4/groups/$id/members', data);
    if (res.statusCode == 200) {
      var data = <Member>[];
      for (var item in res.data) {
        data.add(Member.fromJson(item));
      }
      return constructResponse<Member>(res, data);
    }
    return null;
  }

  Future<bool> addGroupMember(int id, AddMemberRequest data) async {
    final res = await apiProvider.addMember('/api/v4/groups/$id/members', data);
    return res.statusCode == 200;
  }

  Future<bool> removeGroupMember(int groupId, int memberId) async {
    final res = await apiProvider
        .removeGroupMember('/api/v4/groups/$groupId/members/$memberId');
    return res.statusCode == 200;
  }

  /// :commits

  Future<PagingResponse<Commit>?> listCommits(
      int projectId, CommitsReqest data) async {
    final res = await apiProvider.listCommits(
        '/api/v4/projects/$projectId/repository/commits', data);
    if (res.statusCode == 200) {
      var data = <Commit>[];
      for (var item in res.data) {
        data.add(Commit.fromJson(item));
      }
      return constructResponse<Commit>(res, data);
    }
    return null;
  }

  Future<Commit?> getCommit(
      int projectId, String sha, CommitReqest data) async {
    final res = await apiProvider.getCommit(
        '/api/v4/projects/$projectId/repository/commits/$sha', data);
    if (res.statusCode == 200) {
      return Commit.fromJson(res.data);
    }
    return null;
  }

  Future<PagingResponse<Diff>?> getDiff(
      int projectId, String sha, DiffRequest data) async {
    final res = await apiProvider.getDiff(
        '/api/v4/projects/$projectId/repository/commits/$sha/diff', data);
    if (res.statusCode == 200) {
      var data = <Diff>[];
      for (var item in res.data) {
        data.add(Diff.fromJson(item));
      }
      return constructResponse<Diff>(res, data);
    }
    return null;
  }

  /// :issues

  Future<PagingResponse<Issue>?> listIssues(IssuesRequest data) async {
    final res = await apiProvider.listIssues('/api/v4/issues', data);
    if (res.statusCode == 200) {
      var data = <Issue>[];
      for (var item in res.data) {
        data.add(Issue.fromJson(item));
      }
      return constructResponse<Issue>(res, data);
    }
    return null;
  }

  Future<PagingResponse<Issue>?> listProjectIssues(
      int projectId, IssuesRequest data) async {
    final res = await apiProvider.listIssues(
        '/api/v4/projects/$projectId/issues', data);
    if (res.statusCode == 200) {
      var data = <Issue>[];
      for (var item in res.data) {
        data.add(Issue.fromJson(item));
      }
      return constructResponse<Issue>(res, data);
    }
    return null;
  }

  Future<Issue?> getProjectIssue(int projectId, int iid) async {
    final res =
        await apiProvider.getIssue('/api/v4/projects/$projectId/issues/$iid');
    return Issue.fromJson(res.data);
  }

  Future<bool> updateProjectIssue(
      int projectId, int issueIid, UpdateIssueRequest data) async {
    final res = await apiProvider.updateIssue(
        '/api/v4/projects/$projectId/issues/$issueIid', data);
    return res.statusCode == 200;
  }

  Future<bool?> addProjectIssue(int projectId, UpdateIssueRequest data) async {
    final res =
        await apiProvider.addIssue('/api/v4/projects/$projectId/issues', data);
    return res.statusCode == 200;
  }

  Future<bool> deleteProjectIssue(int projectId, int issueId) async {
    final res = await apiProvider
        .deleteIssue('/api/v4/projects/$projectId/issues/$issueId');
    return res.statusCode == 200;
  }

  /// :merge requests

  Future<PagingResponse<MergeRequest>?> listMergeRequests(
      MergeRequestRequest data) async {
    final res =
        await apiProvider.listMergeRequests('/api/v4/merge_requests', data);
    if (res.statusCode == 200) {
      var data = <MergeRequest>[];
      for (var item in res.data) {
        data.add(MergeRequest.fromJson(item));
      }
      return constructResponse<MergeRequest>(res, data);
    }
    return null;
  }

  Future<PagingResponse<MergeRequest>?> listProjectMergeRequests(
      int projectId, MergeRequestRequest data) async {
    final res = await apiProvider.listMergeRequests(
        '/api/v4/projects/$projectId/merge_requests', data);
    if (res.statusCode == 200) {
      var data = <MergeRequest>[];
      for (var item in res.data) {
        data.add(MergeRequest.fromJson(item));
      }
      return constructResponse<MergeRequest>(res, data);
    }
    return null;
  }

  Future<PagingResponse<MergeRequest>?> listIssueRelatedMergeRequests(
      int projectId, int issueIid) async {
    final res = await apiProvider.listIssueRelatedMergeRequests(
        '/api/v4/projects/$projectId/issues/$issueIid/related_merge_requests');
    if (res.statusCode == 200) {
      var data = <MergeRequest>[];
      for (var item in res.data) {
        data.add(MergeRequest.fromJson(item));
      }
      return constructResponse<MergeRequest>(res, data);
    }
    return null;
  }

  Future<MergeRequest?> getMergeRequest(int projectId, int mrIid) async {
    final res = await apiProvider
        .getMergeRequest('/api/v4/projects/$projectId/merge_requests/$mrIid');
    if (res.statusCode == 200) {
      return MergeRequest.fromJson(res.data);
    }
    return null;
  }

  Future<bool> createMergeRequest(int projectId, CreateMRRequest data) async {
    final res = await apiProvider.createMergeRequest(
        '/api/v4/projects/$projectId/merge_requests', data);
    return res.statusCode == 200;
  }

  Future<bool> updateMergeRequest(
      int projectId, int mrIid, UpdateMRRequest data) async {
    final res = await apiProvider.updateMergeRequest(
        '/api/v4/projects/$projectId/merge_requests/$mrIid', data);
    return res.statusCode == 200;
  }

  Future<bool> deleteMergeRequest(int projectId, int id) async {
    final res = await apiProvider
        .deleteMergeRequest('/api/v4/projects/$projectId/merge_requests/$id');
    return res.statusCode == 200;
  }

  /// :labels

  Future<PagingResponse<ProjectLabel>?> listProjectLabels(
      int projectId, ProjectLabelsRequest data) async {
    final res = await apiProvider.listProjectLabels(
        '/api/v4/projects/$projectId/labels', data);
    if (res.statusCode == 200) {
      var data = <ProjectLabel>[];
      for (var item in res.data) {
        data.add(ProjectLabel.fromJson(item));
      }
      return constructResponse<ProjectLabel>(res, data);
    }
    return null;
  }

  Future<PagingResponse<GroupLabel>?> listGroupLabels(
      int projectId, GroupLabelsRequest data) async {
    final res = await apiProvider.listGroupLabels(
        '/api/v4/projects/$projectId/labels', data);
    if (res.statusCode == 200) {
      var data = <GroupLabel>[];
      for (var item in res.data) {
        data.add(GroupLabel.fromJson(item));
      }
      return constructResponse<GroupLabel>(res, data);
    }
    return null;
  }

  Future<bool> createProjectLabel(
      int projectId, CreateLabelRequest data) async {
    final res = await apiProvider.createLabel(
        '/api/v4/projects/$projectId/labels', data);
    return res.statusCode == 200;
  }

  Future<bool> createGroupLabel(int groupId, CreateLabelRequest data) async {
    final res =
        await apiProvider.createLabel('/api/v4/groups/$groupId/labels', data);
    return res.statusCode == 200;
  }

  Future<bool> updateProjectLabel(
      int projectId, int labelId, UpdateProjectLabelRequest data) async {
    final res = await apiProvider.updateProjectLabel(
        '/api/v4/projects/$projectId/labels/$labelId', data);
    return res.statusCode == 200;
  }

  Future<bool> deleteProjectLabel(int projectId, int labelId) async {
    final res = await apiProvider
        .deleteLabel('/api/v4/projects/$projectId/labels/$labelId');
    return res.statusCode == 200;
  }

  /// :snippets

  Future<PagingResponse<Snippet>?> listSnippets(SnippetsRequest data) async {
    final res = await apiProvider.listSnippets('/api/v4/snippets', data);
    if (res.statusCode == 200) {
      var data = <Snippet>[];
      for (var item in res.data) {
        data.add(Snippet.fromJson(item));
      }
      return constructResponse<Snippet>(res, data);
    }
    return null;
  }

  Future<PagingResponse<ProjectSnippet>?> listProjectSnippets(
      int projectId, SnippetsRequest data) async {
    final res = await apiProvider.listSnippets(
        '/api/v4/projects/$projectId/snippets', data);
    if (res.statusCode == 200) {
      var data = <ProjectSnippet>[];
      for (var item in res.data) {
        data.add(ProjectSnippet.fromJson(item));
      }
      return constructResponse<ProjectSnippet>(res, data);
    }
    return null;
  }

  Future<ProjectSnippet?> getProjectSnippet(
      int projectId, int snippetId) async {
    final res = await apiProvider
        .getSnippet('/api/v4/projects/$projectId/snippets/$snippetId');
    if (res.statusCode == 200) {
      return ProjectSnippet.fromJson(res.data);
    }
    return null;
  }

  Future<String?> getProjectSnippetContent(int projectId, int snippetId) async {
    final res = await apiProvider.getSnippetContent(
        '/api/v4/projects/$projectId/snippets/$snippetId/raw');
    if (res.statusCode == 200) {
      return res.data;
    }
    return null;
  }

  Future<bool> addProjectSnippet(
      int projectId, AddUpdateSnippetRequest data) async {
    final res = await apiProvider.addSnippet(
        '/api/v4/projects/$projectId/snippets', data);
    return res.statusCode == 200;
  }

  Future<bool> updateProjectSnippet(
      int projectId, int snippetId, AddUpdateSnippetRequest data) async {
    final res = await apiProvider.updateSnippet(
        '/api/v4/projects/$projectId/snippets/$snippetId', data);
    return res.statusCode == 200;
  }

  Future<bool> deleteProjectSnippet(int projectId, int snippetId) async {
    final res = await apiProvider
        .deleteSnippet('/api/v4/projects/$projectId/snippets/$snippetId');
    return res.statusCode == 200;
  }

  /// :milestones

  Future<PagingResponse<ProjectMilestone>?> listProjectMilestones(
      int projectId, MilestonesRequest data) async {
    final res = await apiProvider.listMilestones(
        '/api/v4/projects/$projectId/milestones', data);
    if (res.statusCode == 200) {
      var data = <ProjectMilestone>[];
      for (var item in res.data) {
        data.add(ProjectMilestone.fromJson(item));
      }
      return constructResponse<ProjectMilestone>(res, data);
    }
    return null;
  }

  Future<ProjectMilestone?> getProjectMilestone(
      int projectId, int milestoneId) async {
    final res = await apiProvider
        .getMilestone('/api/v4/projects/$projectId/milestones/$milestoneId');
    if (res.statusCode == 200) {
      return ProjectMilestone.fromJson(res.data);
    }
    return null;
  }

  Future<bool> updateProjectMilestone(
      int projectId, int milestoneId, AddUpdateMilestoneRequest data) async {
    final res = await apiProvider.updateProjectMilestone(
        '/api/v4/projects/$projectId/milestones/$milestoneId', data);
    return res.statusCode == 200;
  }

  Future<bool> addProjectMilestone(
      int projectId, AddUpdateMilestoneRequest data) async {
    final res = await apiProvider.addProjectMilestone(
        '/api/v4/projects/$projectId/milestones', data);
    return res.statusCode == 200;
  }

  Future<bool> deleteProjectMilestone(int projectId, int milestoneId) async {
    final res = await apiProvider.deleteProjectMilestone(
        '/api/v4/projects/$projectId/milestones/$milestoneId');
    return res.statusCode == 200;
  }

  Future<PagingResponse<Issue>?> getMilestoneIssues(
      int projectId, int milestoneId) async {
    final res = await apiProvider.getMilestoneIssues(
        '/api/v4/projects/$projectId/milestones/$milestoneId/issues');
    if (res.statusCode == 200) {
      var data = <Issue>[];
      for (var item in res.data) {
        data.add(Issue.fromJson(item));
      }
      return constructResponse<Issue>(res, data);
    }
    return null;
  }

  Future<PagingResponse<MergeRequest>?> getMilestoneMR(
      int projectId, int milestoneId) async {
    final res = await apiProvider.getMilestoneMR(
        '/api/v4/projects/$projectId/milestones/$milestoneId/merge_requests');
    if (res.statusCode == 200) {
      var data = <MergeRequest>[];
      for (var item in res.data) {
        data.add(MergeRequest.fromJson(item));
      }
      return constructResponse<MergeRequest>(res, data);
    }
    return null;
  }

  /// :notes

  Future<PagingResponse<Note>?> listProjectIssueNotes(
      int projectId, int issueIid, NotesRequest data) async {
    final res = await apiProvider.listNotes(
        '/api/v4/projects/$projectId/issues/$issueIid/notes', data);
    if (res.statusCode == 200) {
      var data = <Note>[];
      for (var item in res.data) {
        data.add(Note.fromJson(item));
      }
      return constructResponse<Note>(res, data);
    }
    return null;
  }

  Future<bool> addProjectIssueNote(
      int projectId, int issueIid, NewIssueNoteRequest data) async {
    final res = await apiProvider.addProjectIssueNote(
        '/api/v4/projects/$projectId/issues/$issueIid/notes', data);
    return res.statusCode == 200;
  }

  Future<bool> updateProjectIssueNote(int projectId, int issueIid, int noteId,
      UpdateIssueNoteRequest data) async {
    final res = await apiProvider.updateProjectIssueNote(
        '/api/v4/projects/$projectId/issues/$issueIid/notes/$noteId', data);
    return res.statusCode == 200;
  }

  Future<bool> deleteProjectIssueNote(
      int projectId, int issueIid, int noteId) async {
    final res = await apiProvider.deleteProjectIssueNote(
        '/api/v4/projects/$projectId/issues/$issueIid/notes/$noteId');
    return res.statusCode == 200;
  }

  Future<PagingResponse<GroupMilestone>?> listGroupMilestones(
      int groupId, MilestonesRequest data) async {
    final res = await apiProvider.listMilestones(
        '/api/v4/groups/$groupId/milestones', data);
    if (res.statusCode == 200) {
      var data = <GroupMilestone>[];
      for (var item in res.data) {
        data.add(GroupMilestone.fromJson(item));
      }
      return constructResponse<GroupMilestone>(res, data);
    }
    return null;
  }

  /// :events

  Future<PagingResponse<Event>?> listEvents(EventsRequest data) async {
    final res = await apiProvider.listEvents('/api/v4/events', data);
    if (res.statusCode == 200) {
      var data = <Event>[];
      for (var item in res.data) {
        data.add(Event.fromJson(item));
      }
      return constructResponse<Event>(res, data);
    }
    return null;
  }

  Future<PagingResponse<Event>?> listProjectEvents(
      int projectId, EventsRequest data) async {
    final res = await apiProvider.listEvents(
        '/api/v4/projects/$projectId/events', data);

    if (res.statusCode == 200) {
      var data = <Event>[];
      for (var item in res.data) {
        data.add(Event.fromJson(item));
      }
      return constructResponse<Event>(res, data);
    }
    return null;
  }

  PagingResponse<T> constructResponse<T>(Response<dynamic> res, List<T> data) {
    return PagingResponse(
        nextPage: int.tryParse(res.headers.value('x-next-page') ?? ""),
        page: int.tryParse(res.headers.value('x-page') ?? ""),
        perPage: int.tryParse(res.headers.value('x-per-page') ?? ""),
        prevPage: int.tryParse(res.headers.value('x-prev-page') ?? ""),
        total: int.tryParse(res.headers.value('x-total') ?? ""),
        totalPages: int.tryParse(res.headers.value('x-total-pages') ?? ""),
        data: data);
  }
}
