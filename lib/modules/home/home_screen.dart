import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).canPop(),
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      appBar: AppBar(
        title: CrossFade<String>(
          initialData: '',
          data: _controller.title.string,
          builder: (value) => Text(value),
        ),
        actions: [
          if (_controller.currentTab.value != MainTabs.events &&
              _controller.currentTab.value != MainTabs.projects)
            IconButton(
              onPressed: () {
                switch (_controller.currentTab.value) {
                  case MainTabs.projects:
                    break;
                  case MainTabs.events:
                    break;
                  case MainTabs.issues:
                    showDialog(
                        context: context,
                        builder: (c) {
                          String selectedScopeRadio =
                              _controller.issuesFilterScope.value;
                          String selectedStateRadio =
                              _controller.issuesFilterState.value;
                          return AlertDialog(
                            title: Text('Filter'.tr),
                            content: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Wrap(
                                      spacing: 5,
                                      runSpacing: -5,
                                      children: [
                                        FilterChip(
                                          label: Text('All'.tr),
                                          selected: selectedStateRadio.isEmpty,
                                          onSelected: (value) {
                                            setState(
                                                () => selectedStateRadio = '');
                                            _controller
                                                .onIssuesStateChanged('');
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Open'.tr),
                                          selected: selectedStateRadio ==
                                              IssueState.opened,
                                          onSelected: (value) {
                                            setState(() => selectedStateRadio =
                                                IssueState.opened);
                                            _controller.onIssuesStateChanged(
                                                IssueState.opened);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Closed'.tr),
                                          selected: selectedStateRadio ==
                                              IssueState.closed,
                                          onSelected: (value) {
                                            setState(() => selectedStateRadio =
                                                IssueState.closed);
                                            _controller.onIssuesStateChanged(
                                                IssueState.closed);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text('Scope'.tr),
                                    const SizedBox(height: 5),
                                    Wrap(
                                      spacing: 5,
                                      children: [
                                        FilterChip(
                                          label: Text('All'.tr),
                                          selected: selectedScopeRadio ==
                                              MergeRequestScope.all,
                                          onSelected: (value) {
                                            setState(() => selectedScopeRadio =
                                                MergeRequestScope.all);
                                            _controller.onIssuesScopeChanged(
                                                MergeRequestScope.all);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Created'.tr),
                                          selected: selectedScopeRadio ==
                                              MergeRequestScope.createdByMe,
                                          onSelected: (value) {
                                            setState(() => selectedScopeRadio =
                                                MergeRequestScope.createdByMe);
                                            _controller.onIssuesScopeChanged(
                                                MergeRequestScope.createdByMe);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Assigned'.tr),
                                          selected: selectedScopeRadio ==
                                              MergeRequestScope.assignedToMe,
                                          onSelected: (value) {
                                            setState(() => selectedScopeRadio =
                                                MergeRequestScope.assignedToMe);
                                            _controller.onIssuesScopeChanged(
                                                MergeRequestScope.assignedToMe);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Close'.tr)),
                            ],
                          );
                        });
                    break;
                  case MainTabs.mergeRequests:
                    showDialog(
                        context: context,
                        builder: (c) {
                          String selectedScopeRadio =
                              _controller.mergeRequestsFilterScope.value;
                          String selectedStateRadio =
                              _controller.mergeRequestsFilterState.value;
                          return AlertDialog(
                            title: Text('Filter'.tr),
                            content: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Wrap(
                                      spacing: 5,
                                      runSpacing: -5,
                                      children: [
                                        FilterChip(
                                          label: Text('All'.tr),
                                          selected: selectedStateRadio.isEmpty,
                                          onSelected: (value) {
                                            setState(
                                                () => selectedStateRadio = '');
                                            _controller
                                                .onMergeRequestStateChanged('');
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Open'.tr),
                                          selected: selectedStateRadio ==
                                              MergeRequestState.opened,
                                          onSelected: (value) {
                                            setState(() => selectedStateRadio =
                                                MergeRequestState.opened);
                                            _controller
                                                .onMergeRequestStateChanged(
                                                    MergeRequestState.opened);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Closed'.tr),
                                          selected: selectedStateRadio ==
                                              MergeRequestState.closed,
                                          onSelected: (value) {
                                            setState(() => selectedStateRadio =
                                                MergeRequestState.closed);
                                            _controller
                                                .onMergeRequestStateChanged(
                                                    MergeRequestState.closed);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Locked'.tr),
                                          selected: selectedStateRadio ==
                                              MergeRequestState.locked,
                                          onSelected: (value) {
                                            setState(() => selectedStateRadio =
                                                MergeRequestState.locked);
                                            _controller
                                                .onMergeRequestStateChanged(
                                                    MergeRequestState.locked);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Merged'.tr),
                                          selected: selectedStateRadio ==
                                              MergeRequestState.merged,
                                          onSelected: (value) {
                                            setState(() => selectedStateRadio =
                                                MergeRequestState.merged);
                                            _controller
                                                .onMergeRequestStateChanged(
                                                    MergeRequestState.merged);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text('Scope'.tr),
                                    const SizedBox(height: 5),
                                    Wrap(
                                      spacing: 5,
                                      children: [
                                        FilterChip(
                                          label: Text('All'.tr),
                                          selected: selectedScopeRadio ==
                                              MergeRequestScope.all,
                                          onSelected: (value) {
                                            setState(() => selectedScopeRadio =
                                                MergeRequestScope.all);
                                            _controller
                                                .onMergeRequestScopeChanged(
                                                    MergeRequestScope.all);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Created'.tr),
                                          selected: selectedScopeRadio ==
                                              MergeRequestScope.createdByMe,
                                          onSelected: (value) {
                                            setState(() => selectedScopeRadio =
                                                MergeRequestScope.createdByMe);
                                            _controller
                                                .onMergeRequestScopeChanged(
                                                    MergeRequestScope
                                                        .createdByMe);
                                          },
                                        ),
                                        FilterChip(
                                          label: Text('Assigned'.tr),
                                          selected: selectedScopeRadio ==
                                              MergeRequestScope.assignedToMe,
                                          onSelected: (value) {
                                            setState(() => selectedScopeRadio =
                                                MergeRequestScope.assignedToMe);
                                            _controller
                                                .onMergeRequestScopeChanged(
                                                    MergeRequestScope
                                                        .assignedToMe);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('Close'.tr)),
                            ],
                          );
                        });
                    break;
                }
              },
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filter'.tr,
            ),
        ],
      ),
      drawer: AppDrawer(
        selected: _controller.selectedItem,
        account: _controller.repository.account.value,
        repository: _controller.repository,
      ),
      body: _buildContent(_controller.currentTab.value),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _controller.getCurrentIndex(_controller.currentTab.value),
        elevation: 10,
        items: [
          _buildNavigationBarItem("Projects", MaterialCommunityIcons.git),
          _buildNavigationBarItem("Events", Icons.event),
          _buildNavigationBarItem("Issues", Octicons.issue_opened),
          _buildNavigationBarItem("MR", Octicons.git_merge),
        ],
        onTap: (index) => _controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.projects:
        return _controller.projectsTab;
      case MainTabs.events:
        return _controller.activityTab;
      case MainTabs.issues:
        return _controller.issuesTab;
      case MainTabs.mergeRequests:
        return _controller.mergeRequestsTab;
      default:
        return _controller.projectsTab;
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
