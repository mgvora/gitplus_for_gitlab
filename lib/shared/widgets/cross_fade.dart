import 'package:flutter/material.dart';

class CrossFade<T> extends StatefulWidget {
  final T initialData;
  final T data;
  final Duration duration;
  final Widget Function(T data) builder;
  final VoidCallback? onFadeComplete;

  const CrossFade({
    Key? key,
    required this.initialData,
    required this.data,
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    this.onFadeComplete,
  }) : super(key: key);

  @override
  _CrossFadeState<T> createState() => _CrossFadeState<T>();
}

class _CrossFadeState<T> extends State<CrossFade<T>>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  T? _dataToShow;

  @override
  void initState() {
    super.initState();
    _dataToShow = widget.initialData;
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _dataToShow = widget.data;
          _controller!.reverse(from: 1.0);
        } else if (status == AnimationStatus.dismissed) {
          widget.onFadeComplete?.call();
        }
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    if (widget.initialData != widget.data) {
      _controller!.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CrossFade<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _dataToShow = oldWidget.data;
      _controller!.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: 1.0 - _animation!.value,
        child: widget.builder(_dataToShow!),
      );
}
