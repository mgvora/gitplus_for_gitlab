import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'constants/common.dart';

mixin PagingController {
  List<T> initPagingList<T>(PagingResponse<T>? res) =>
      res != null && res.data != null ? res.data! : [];

  Future<void> scrollListener<T>(
      ScrollController scrollController,
      PagingResponse<T> res,
      Future<void> Function(int) action,
      int page) async {
    if (scrollController.position.extentAfter >
            CommonConstants.scrollExtendAfter ||
        res.nextPage == null ||
        page >= res.nextPage!) {
      return;
    }
    await action(res.nextPage!);
  }
}
