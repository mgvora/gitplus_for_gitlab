import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/models/request/access_token_request_password.dart';

import 'api.dart';

class ApiProvider extends BaseProvider {
  /// :users

  Future<Response> accessToken(String path, AccessTokenReqest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> refreshToken(String path, RefreshTokenRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> accessTokenPassword(
      String path, AccessTokenReqestPassword data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> listUsers(String path, FindUsersRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getUser(String path) {
    return dio.get(path);
  }

  /// :project

  Future<Response> listProjects(String path, ProjectsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getProject(String path, ProjectRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> updateProject(String path, CreateProjectRequest data) {
    return dio.put(path, queryParameters: data.toJson());
  }

  Future<Response> deleteProject(String path) {
    return dio.delete(path);
  }

  Future<Response> createProject(String path, CreateProjectRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> starUnstarProject(String path) {
    return dio.post(path);
  }

  Future<Response> listProjectStarrers(String path, StarrersRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> listEvents(String path, EventsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> listBranches(String path, BranchesRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> listTags(String path, TagsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> listRepositoryTree(String path, TreeRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getFile(String path, FileRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getGroupMembers(String path) {
    return dio.get(path);
  }

  /// :groups

  Future<Response> listGroups(String path, GroupsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> addGroup(String path, AddGroupRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> listGroupProjects(String path, GroupProjectsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> removeGroupMember(String path) {
    return dio.delete(path);
  }

  /// :commits

  Future<Response> listCommits(String path, CommitsReqest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getCommit(String path, CommitReqest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getDiff(String path, DiffRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  /// :issues

  Future<Response> listIssues(String path, IssuesRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getIssue(String path) {
    return dio.get(path);
  }

  Future<Response> updateIssue(String path, UpdateIssueRequest data) {
    return dio.put(path, queryParameters: data.toJson());
  }

  Future<Response> addIssue(String path, UpdateIssueRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> deleteIssue(String path) {
    return dio.delete(path);
  }

  /// :merge requests

  Future<Response> listMergeRequests(String path, MergeRequestRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> listIssueRelatedMergeRequests(String path) {
    return dio.get(path);
  }

  Future<Response> getMergeRequest(String path) {
    return dio.get(path);
  }

  Future<Response> createMergeRequest(String path, CreateMRRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> updateMergeRequest(String path, UpdateMRRequest data) {
    return dio.put(path, queryParameters: data.toJson());
  }

  Future<Response> deleteMergeRequest(String path) {
    return dio.delete(path);
  }

  /// :labels

  Future<Response> listProjectLabels(String path, ProjectLabelsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> listGroupLabels(String path, GroupLabelsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> createLabel(String path, CreateLabelRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> updateProjectLabel(
      String path, UpdateProjectLabelRequest data) {
    return dio.put(path, queryParameters: data.toJson());
  }

  Future<Response> deleteLabel(String path) {
    return dio.delete(path);
  }

  /// :snippets

  Future<Response> listSnippets(String path, SnippetsRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getSnippet(String path) {
    return dio.get(path);
  }

  Future<Response> getSnippetContent(String path) {
    return dio.get(path);
  }

  Future<Response> addSnippet(String path, AddUpdateSnippetRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> updateSnippet(String path, AddUpdateSnippetRequest data) {
    return dio.put(path, queryParameters: data.toJson());
  }

  Future<Response> deleteSnippet(String path) {
    return dio.delete(path);
  }

  /// :milestones

  Future<Response> listMilestones(String path, MilestonesRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> getMilestone(String path) {
    return dio.get(path);
  }

  Future<Response> updateProjectMilestone(
      String path, AddUpdateMilestoneRequest data) {
    return dio.put(path, queryParameters: data.toJson());
  }

  Future<Response> addProjectMilestone(
      String path, AddUpdateMilestoneRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> deleteProjectMilestone(String path) {
    return dio.delete(path);
  }

  Future<Response> getMilestoneIssues(String path) {
    return dio.get(path);
  }

  Future<Response> getMilestoneMR(String path) {
    return dio.get(path);
  }

  /// :notes

  Future<Response> listNotes(String path, NotesRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> addProjectIssueNote(String path, NewIssueNoteRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> updateProjectIssueNote(
      String path, UpdateIssueNoteRequest data) {
    return dio.put(path, queryParameters: data.toJson());
  }

  Future<Response> deleteProjectIssueNote(String path) {
    return dio.delete(path);
  }

  /// :common

  Future<Response> listMembers(String path, MembersRequest data) {
    return dio.get(path, queryParameters: data.toJson());
  }

  Future<Response> addMember(String path, AddMemberRequest data) {
    return dio.post(path, queryParameters: data.toJson());
  }

  Future<Response> removeMember(String path) {
    return dio.delete(path);
  }
}
