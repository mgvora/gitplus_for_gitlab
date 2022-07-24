import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/branches/branches.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:file_icon/file_icon.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'tree_view.dart';

class TreeViewArgs {
  final String name;
  final String path;

  TreeViewArgs({
    required this.name,
    required this.path,
  });
}

class TreeViewScreen extends StatefulWidget {
  const TreeViewScreen({Key? key}) : super(key: key);

  @override
  _TreeViewScreenState createState() => _TreeViewScreenState();
}

class _TreeViewScreenState extends State<TreeViewScreen> {
  final _controller = Get.find<TreeViewController>();
  final TreeViewArgs _args = Get.arguments;
  List<Tree> _tree = [];
  late final StreamSubscription _refSubscription;
  late PagingResponse<Tree> _treesRes;
  var _page = 0;
  var _state = HttpState.loading;

  late final ScrollController _scrollController = ScrollController()
    ..addListener(_scrollListener);

  void _scrollListener() {
    if (_scrollController.position.extentAfter >
            CommonConstants.scrollExtendAfter ||
        _treesRes.nextPage == null ||
        _page >= _treesRes.nextPage!) {
      return;
    }
    _listTreeMore(_treesRes.nextPage!);
  }

  List<T> initPagingList<T>(PagingResponse<T>? res) =>
      res != null && res.data != null ? res.data! : [];

  @override
  void initState() {
    super.initState();
    _listTree();
    _refSubscription = _controller.repository.ref.listen((p0) {
      _listTree();
    });
  }

  @override
  void dispose() {
    _refSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _runWithErrorHandling(HttpFunction function) async {
    try {
      setState(() {
        _state = HttpState.loading;
      });
      await function();
      setState(() {
        _state = HttpState.ok;
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        setState(() {
          _state = HttpState.error;
        });
      } else if (e.response?.statusCode == 403) {
        CommonWidget.toast('Forbidden');
        setState(() {
          _state = HttpState.error;
        });
      } else if (e.response?.statusCode == 404) {
        setState(() {
          _state = HttpState.empty;
        });
      } else {
        setState(() {
          _state = HttpState.error;
        });
      }
    }
  }

  Future<void> _listTree() async {
    await _runWithErrorHandling(() async {
      _treesRes = await _controller.apiRepository.listRepositoryTree(
              _controller.repository.project.value.id ?? -1,
              TreeRequest(
                  ref: _controller.repository.ref.string, path: _args.path)) ??
          PagingResponse<Tree>();
      if (mounted) {
        setState(() => _tree = initPagingList(_treesRes));
      }
    });
  }

  Future<void> _listTreeMore(int page) async {
    _page = page;
    try {
      var t = await _controller.apiRepository.listRepositoryTree(
              _controller.repository.project.value.id ?? -1,
              TreeRequest(
                  ref: _controller.repository.ref.string,
                  path: _args.path,
                  page: page)) ??
          PagingResponse<Tree>();
      if (mounted) {
        setState(() => _tree.addAll(initPagingList(t)));
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_args.name),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                Routes.branches,
                arguments: BranchesScreenArgs(
                  onRefSelected: (value) {
                    _controller.repository.ref.value = value;
                  },
                  selectedRef: _controller.repository.ref.value,
                  returnRoute: Get.currentRoute,
                ),
              );
            },
            icon: const Icon(Octicons.git_branch),
            tooltip: 'Switch branch/tag'.tr,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _listTree(),
        child: HttpFutureBuilder(
          state: _state,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _tree.length,
                itemBuilder: (context, index) {
                  var item = _tree[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: item.type == TreeTypes.blob
                            ? FileIcon(item.name!, size: 30)
                            : Icon(Octicons.file_directory,
                                color: Get.theme.colorScheme.secondary),
                        title: Text(item.name ?? ''),
                        onTap: () => _controller.onItemSelected(item),
                      ),
                      const Divider(),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
