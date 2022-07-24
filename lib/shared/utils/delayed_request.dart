import 'dart:async';

import 'package:gitplus_for_gitlab/shared/shared.dart';

class DelayedRequest {
  Timer? _timer;
  String _lastSearchText = "";
  String _search = "";

  DelayedRequest();

  Future<void> request(String s, Future<void> Function(String) action) async {
    _search = s;

    if (s.isEmpty) {
      _timer?.cancel();
      await action(_search);
    }

    if (_timer != null && _timer!.isActive) {
      return;
    }
    _timer = Timer.periodic(CommonConstants.searchRequestDelay, (timer) async {
      if (_lastSearchText == _search) {
        return;
      }
      _lastSearchText = _search;
      await action(_search);
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
