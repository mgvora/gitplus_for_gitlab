import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gitplus_for_gitlab/models/models.dart';

class Repository {
  var project = Project().obs;
  var projectId = 0;
  var commit = Commit().obs;
  var issue = Issue().obs;
  var issueIid = 0;
  var note = Note().obs;
  var mergeRequest = MergeRequest().obs;
  var mergeRequestIid = 0;
  var milestone = ProjectMilestone().obs;
  var milestoneId = 0;
  var snippet = ProjectSnippet().obs;
  var snippetContent = ''.obs;
  var issueLabels = <ProjectLabel>[].obs;
  var label = ProjectLabel().obs;

  var group = Group().obs;
  var ref = "".obs;
  var filePath = "".obs;
  var account = AppAccount().obs;

  var loadProjectRequired = false.obs;

  /// update triggers
  var membersUpdate = 0.obs;

  var issuesUpdate = 0.obs;

  var milestonesUpdate = 0.obs;

  var snippetsUpdate = 0.obs;

  var issueNotesUpdate = 0.obs;

  var labelsUpdate = 0.obs;
  var labelUpdate = 0.obs;

  var mergeRequestsUpdate = 0.obs;

  var projectUpdate = 0.obs;
  var projectsUpdate = 0.obs;

  var membersFor = MembersFor.project;
}

enum MembersFor { project, group }
