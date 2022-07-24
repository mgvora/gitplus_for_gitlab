import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class HttpFutureBuilder extends StatelessWidget {
  final HttpState state;
  final Widget child;

  const HttpFutureBuilder({Key? key, required this.state, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == HttpState.loading) {
      return const LoadingWidget();
    } else if (state == HttpState.empty) {
      return const EmptyWidget();
    } else if (state == HttpState.ok) {
      return child;
    } else if (state == HttpState.tokenExpired) {
      return const HttpTokenExpiredWidget();
    } else {
      return const HttpErrorWidget();
    }
  }
}
