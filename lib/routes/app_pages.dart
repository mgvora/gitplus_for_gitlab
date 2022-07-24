import 'dart:io';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/modules/about/about_binding.dart';
import 'package:gitplus_for_gitlab/modules/accounts_intern/account_details_screen.dart';
import 'package:gitplus_for_gitlab/modules/accounts_intern/accounts.dart';
import 'package:gitplus_for_gitlab/modules/add_members/add_members.dart';
import 'package:gitplus_for_gitlab/modules/auth/auth.dart';
import 'package:gitplus_for_gitlab/modules/branches/branches.dart';
import 'package:gitplus_for_gitlab/modules/code_view/code_view.dart';
import 'package:gitplus_for_gitlab/modules/commit/commit.dart';
import 'package:gitplus_for_gitlab/modules/commits/commits.dart';
import 'package:gitplus_for_gitlab/modules/create_merge_request/create_merge_request.dart';
import 'package:gitplus_for_gitlab/modules/edit_issue/edit_issue.dart';
import 'package:gitplus_for_gitlab/modules/edit_issue_note/edit_issue_note_binding.dart';
import 'package:gitplus_for_gitlab/modules/edit_issue_note/edit_issue_note_screen.dart';
import 'package:gitplus_for_gitlab/modules/edit_merge_request/edit_merge_request.dart';
import 'package:gitplus_for_gitlab/modules/edit_milestone/edit_milestone.dart';
import 'package:gitplus_for_gitlab/modules/edit_project/edit_project.dart';
import 'package:gitplus_for_gitlab/modules/edit_project_label/edit_project_label.dart';
import 'package:gitplus_for_gitlab/modules/edit_project_snippet/edit_project_snippet.dart';
import 'package:gitplus_for_gitlab/modules/groups/groups.dart';
import 'package:gitplus_for_gitlab/modules/home/home.dart';
import 'package:gitplus_for_gitlab/modules/image_viewer/image_viewer.dart';
import 'package:gitplus_for_gitlab/modules/issue/issue.dart';
import 'package:gitplus_for_gitlab/modules/issue_notes/issue_notes_binding.dart';
import 'package:gitplus_for_gitlab/modules/issue_notes/issue_notes_screen.dart';
import 'package:gitplus_for_gitlab/modules/issue_related_requests/issue_related_merge_requests.dart';
import 'package:gitplus_for_gitlab/modules/issues/issues.dart';
import 'package:gitplus_for_gitlab/modules/md_view/md_view.dart';
import 'package:gitplus_for_gitlab/modules/member_details/member_details.dart';
import 'package:gitplus_for_gitlab/modules/merge_request/merge_request.dart';
import 'package:gitplus_for_gitlab/modules/merge_requests/merge_requests.dart';
import 'package:gitplus_for_gitlab/modules/milestone/milestone.dart';
import 'package:gitplus_for_gitlab/modules/milestones/milestones.dart';
import 'package:gitplus_for_gitlab/modules/create_issue/create_issue.dart';
import 'package:gitplus_for_gitlab/modules/create_milestone/create_milestone.dart';
import 'package:gitplus_for_gitlab/modules/create_project/create_project.dart';
import 'package:gitplus_for_gitlab/modules/create_project_label/create_project_label.dart';
import 'package:gitplus_for_gitlab/modules/create_project_snippet/create_project_snippet.dart';
import 'package:gitplus_for_gitlab/modules/project_activity/project_activity_binding.dart';
import 'package:gitplus_for_gitlab/modules/project_activity/project_activity_screen.dart';
import 'package:gitplus_for_gitlab/modules/project_details/project_details.dart';
import 'package:gitplus_for_gitlab/modules/project_labels/project_labels.dart';
import 'package:gitplus_for_gitlab/modules/project_members/project_members.dart';
import 'package:gitplus_for_gitlab/modules/project_snippet/project_snippet.dart';
import 'package:gitplus_for_gitlab/modules/project_snippets/project_snippets.dart';
import 'package:gitplus_for_gitlab/modules/projects/projects.dart';
import 'package:gitplus_for_gitlab/modules/settings/settings.dart';
import 'package:gitplus_for_gitlab/modules/about/about.dart';
import 'package:gitplus_for_gitlab/modules/starrers/starrers.dart';
import 'package:gitplus_for_gitlab/modules/tree_view/tree_view.dart';

part 'app_routes.dart';

class AppPages {
  static GetPage getAuthRoute() {
    return GetPage(
        name: Routes.auth,
        page: () => const AuthScreenStandard(),
        binding: AuthBinding());
  }

  static final routes = [
    getAuthRoute(),
    GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.projects,
        page: () => const ProjectsScreen(),
        binding: ProjectsBinding()),
    GetPage(
        name: Routes.groups,
        page: () => const GroupsScreen(),
        binding: GroupsBinding(),
        children: [
          GetPage(
              name: Routes.groupDetails,
              page: () => const GroupsDetailsScreen()),
          GetPage(name: Routes.addGroup, page: () => const NewGroupScreen()),
        ]),
    GetPage(
        name: Routes.projectMembers,
        page: () => const ProjectMembersScreen(),
        binding: ProjectMembersBinding()),
    GetPage(
        name: Routes.projectActivity,
        page: () => const ProjectActivityScreen(),
        binding: ProjectActivityBinding()),
    GetPage(name: Routes.memberDetails, page: () => MemberDetailsScreen()),
    GetPage(
        name: Routes.addMembers,
        page: () => const AddMembersScreen(),
        binding: AddMembersBinding()),
    GetPage(
        name: Routes.treeViewRoot,
        page: () => const TreeViewScreen(),
        binding: TreeViewBinding()),
    GetPage(
        name: Routes.commits,
        page: () => const CommitsScreen(),
        binding: CommitsBinding()),
    GetPage(
        name: Routes.commit,
        page: () => const CommitScreen(),
        binding: CommitBinding()),
    GetPage(
        name: Routes.issues,
        page: () => const IssuesScreen(),
        binding: IssuesBinding()),
    GetPage(
        name: Routes.issue,
        page: () => const IssueScreen(),
        binding: IssueBinding()),
    GetPage(
        name: Routes.editIssue,
        page: () => const EditIssueScreen(),
        binding: EditIssueBinding()),
    GetPage(
        name: Routes.createIssue,
        page: () => const CreateIssueScreen(),
        binding: CreateIssueBinding()),
    GetPage(
        name: Routes.issueNotes,
        page: () => const IssueNotesScreen(),
        binding: IssueNotesBinding()),
    GetPage(
        name: Routes.editIssueNote,
        page: () => const EditIssueNoteScreen(),
        binding: EditIssueNoteBinding()),
    GetPage(
        name: Routes.issueRelatedRequests,
        page: () => const IssueRelatedMergeRequestsScreen(),
        binding: IssueRelatedMergeRequestsBinding()),
    GetPage(
        name: Routes.milestones,
        page: () => MilestonesScreen(),
        binding: MilestonesBinding()),
    GetPage(
        name: Routes.milestone,
        page: () => const MilestoneScreen(),
        binding: MilestoneBinding()),
    GetPage(
        name: Routes.createMilestone,
        page: () => const CreateMilestoneScreen(),
        binding: CreateMilestoneBinding()),
    GetPage(
        name: Routes.editMilestone,
        page: () => const EditMilestoneScreen(),
        binding: EditMilestoneBinding()),
    GetPage(
        name: Routes.mergeRequests,
        page: () => const MergeRequestsScreen(),
        binding: MergeRequestsBinding()),
    GetPage(
        name: Routes.mergeRequest,
        page: () => const MergeRequestScreen(),
        binding: MergeRequestBinding()),
    GetPage(
        name: Routes.createMergeRequest,
        page: () => const CreateMergeRequestScreen(),
        binding: CreateMergeRequestBinding()),
    GetPage(
        name: Routes.editMergeRequest,
        page: () => const EditMergeRequestScreen(),
        binding: EditMergeRequestBinding()),
    GetPage(
        name: Routes.labels,
        page: () => ProjectLabelsScreen(),
        binding: ProjectLabelsBinding()),
    GetPage(
        name: Routes.createLabel,
        page: () => const CreateProjectLabelScreen(),
        binding: CreateProjectLabelBinding()),
    GetPage(
        name: Routes.editLabel,
        page: () => const EditProjectLabelScreen(),
        binding: EditProjectLabelBinding()),
    GetPage(
        name: Routes.projectSnippets,
        page: () => const ProjectSnippetsScreen(),
        binding: ProjectSnippetsBinding()),
    GetPage(
        name: Routes.projectSnippet,
        page: () => const ProjectSnippetScreen(),
        binding: ProjectSnippetBinding()),
    GetPage(
        name: Routes.createSnippet,
        page: () => const CreateProjectSnippetScreen(),
        binding: CreateProjectSnippetBinding()),
    GetPage(
        name: Routes.editSnippet,
        page: () => const EditProjectSnippetScreen(),
        binding: EditProjectSnippetBinding()),
    GetPage(
        name: Routes.branches,
        page: () => const BranchesScreen(),
        binding: BranchesBinding()),
    GetPage(
        name: Routes.mdView,
        page: () => MdViewScreen(),
        binding: MdViewBinding()),
    GetPage(
        name: Routes.projectDetails,
        page: () => const ProjectDetailsScreen(),
        binding: ProjectDetailsBinding()),
    GetPage(
        name: Routes.editProject,
        page: () => const EditProjectScreen(),
        binding: EditProjectBinding()),
    GetPage(
        name: Routes.createProject,
        page: () => const CreateProjectScreen(),
        binding: CreateProjectBinding()),
    GetPage(
        name: Routes.codeView,
        page: () => CodeViewScreen(),
        binding: CodeViewBinding()),
    GetPage(
        name: Routes.imageViewer,
        page: () => const ImageViewerScreen(),
        binding: ImageViewerBinding()),
    GetPage(
        name: Routes.starrers,
        page: () => const StarrersScreen(),
        binding: StarrersBinding()),
    GetPage(
        name: Routes.settings,
        page: () => const SettingsScreen(),
        binding: SettingsBinding()),
    GetPage(
      name: Routes.about,
      page: () => const AboutScreen(),
      binding: AboutBinding(),
    ),
    GetPage(
        name: Routes.accounts,
        page: () => const AccountsScreen(),
        binding: AccountsBinding(),
        children: [
          GetPage(
              name: Routes.accountDetails, page: () => AccountDetailsScreen()),
        ]),
  ];
}
