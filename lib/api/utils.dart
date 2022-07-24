import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class GitlabUtils {
  static String getAccessLevelName(int level /* MemberAccessLevel */) {
    switch (level) {
      case MemberAccessLevel.noAccess:
        return "No access";
      case MemberAccessLevel.minimalAccess:
        return "Minimal access";
      case MemberAccessLevel.guest:
        return "Guest";
      case MemberAccessLevel.reporter:
        return "Reporter";
      case MemberAccessLevel.developer:
        return "Developer";
      case MemberAccessLevel.maintaner:
        return "Maintener";
      case MemberAccessLevel.owner:
        return "Owner";
    }
    return "";
  }

  static handleEvent(Repository repository, Event item, bool isFromHome) {
    EasyLoading.show();

    if (isFromHome) {
      repository.projectId = item.projectId ?? 0;
      repository.project.value = Project();
    }

    switch (item.actionName) {
      case EventActionNames.approved:
        switch (item.targetType) {
          case EventTargetTypes.mergeRequest:
            repository.mergeRequest.value = MergeRequest();
            repository.mergeRequestIid = item.targetIid ?? 0;
            Get.toNamed(Routes.mergeRequest);
            break;
        }
        break;
      case EventActionNames.closed:
        switch (item.targetType) {
          case EventTargetTypes.issue:
            repository.issue.value = Issue();
            repository.issueIid = item.targetIid ?? 0;
            Get.toNamed(Routes.issue);
            break;
          case EventTargetTypes.milestone:
            repository.milestone.value = ProjectMilestone();
            repository.milestoneId = item.targetId ?? 0;
            Get.toNamed(Routes.milestone);
            break;
          case EventTargetTypes.mergeRequest:
            repository.mergeRequest.value = MergeRequest();
            repository.mergeRequestIid = item.targetIid ?? 0;
            Get.toNamed(Routes.mergeRequest);
            break;
        }
        break;
      case EventActionNames.commented:
        switch (item.targetType) {
          case EventTargetTypes.issue:
            Get.toNamed(Routes.projectDetails);
            break;
          case EventTargetTypes.milestone:
            repository.milestone.value = ProjectMilestone();
            repository.milestoneId = item.targetId ?? 0;
            Get.toNamed(Routes.milestone);
            break;
          case EventTargetTypes.mergeRequest:
            repository.mergeRequest.value = MergeRequest();
            repository.mergeRequestIid = item.targetIid ?? 0;
            Get.toNamed(Routes.mergeRequest);
            break;
          case EventTargetTypes.note:
            if (item.note!.noteableType == NotableType.issue) {
              repository.issue.value = Issue();
              repository.issueIid = item.note!.noteableIid ?? 0;
              Get.toNamed(Routes.issue);
            } else if (item.note!.noteableType == NotableType.mergeRequest) {
              repository.mergeRequest.value = MergeRequest();
              repository.mergeRequestIid = item.note!.noteableIid ?? 0;
              Get.toNamed(Routes.mergeRequest);
            }
            break;
          case EventTargetTypes.discussionNote:
            Get.toNamed(Routes.projectDetails);
            break;
          case EventTargetTypes.diffNote:
            Get.toNamed(Routes.projectDetails);
            break;
        }
        break;
      case EventActionNames.destroyed:
        switch (item.targetType) {
          case EventTargetTypes.issue:
            Get.toNamed(Routes.projectDetails);
            break;
          case EventTargetTypes.milestone:
            Get.toNamed(Routes.projectDetails);
            break;
          case EventTargetTypes.mergeRequest:
            Get.toNamed(Routes.projectDetails);
            break;
        }
        break;
      case EventActionNames.created:
        switch (item.targetType) {
          case EventTargetTypes.project:
            break;
          case EventTargetTypes.issue:
            repository.issue.value = Issue();
            repository.issueIid = item.targetIid ?? 0;
            Get.toNamed(Routes.issue);
            break;
          case EventTargetTypes.milestone:
            repository.milestone.value = ProjectMilestone();
            repository.milestoneId = item.targetId ?? 0;
            Get.toNamed(Routes.milestone);
            break;
          case EventTargetTypes.mergeRequest:
            repository.mergeRequest.value = MergeRequest();
            repository.mergeRequestIid = item.targetIid ?? 0;
            Get.toNamed(Routes.mergeRequest);
            break;
          default:
            Get.toNamed(Routes.projectDetails);
        }
        break;
      case EventActionNames.expired:
        Get.toNamed(Routes.projectDetails);
        break;
      case EventActionNames.joined:
        Get.toNamed(Routes.projectDetails);
        break;
      case EventActionNames.left:
        Get.toNamed(Routes.projectDetails);
        break;
      case EventActionNames.merged:
        Get.toNamed(Routes.projectDetails);
        break;
      case EventActionNames.pushedNew:
        Get.toNamed(Routes.projectDetails);
        break;
      case EventActionNames.pushedTo:
        Get.toNamed(Routes.projectDetails);
        break;
      case EventActionNames.reopened:
        break;
      case EventActionNames.updated:
        break;

      case EventActionNames.opened:
        switch (item.targetType) {
          case EventTargetTypes.issue:
            repository.issue.value = Issue();
            repository.issueIid = item.targetIid ?? 0;
            Get.toNamed(Routes.issue);
            break;
          case EventTargetTypes.milestone:
            repository.milestone.value = ProjectMilestone();
            repository.milestoneId = item.targetId ?? 0;
            Get.toNamed(Routes.milestone);
            break;
          case EventTargetTypes.mergeRequest:
            repository.mergeRequest.value = MergeRequest();
            repository.mergeRequestIid = item.targetIid ?? 0;
            Get.toNamed(Routes.mergeRequest);
            break;
        }
        break;
      case EventActionNames.accepted:
        if (item.targetType == EventTargetTypes.mergeRequest) {
          repository.mergeRequest.value = MergeRequest();
          repository.mergeRequestIid = item.targetIid ?? 0;
          Get.toNamed(Routes.mergeRequest);
        }
        break;
    }
    EasyLoading.dismiss();
  }
}
