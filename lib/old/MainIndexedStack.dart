//import 'package:flutter/material.dart';
//
//class MainIndexedStack extends StatefulWidget {
//  final int index;
//  final List<Widget> children;
//  final Duration duration;
//
//  const MainIndexedStack({
//    Key key,
//    this.index,
//    this.children,
//    this.duration = const Duration(
//      milliseconds: 800,
//    ),
//  }) : super(key: key);
//
//  @override
//  _FadeIndexedStackState createState() => _FadeIndexedStackState();
//}
//
//class _FadeIndexedStackState extends State<MainIndexedStack>
//    with SingleTickerProviderStateMixin {
//  AnimationController _controller;
//
//  @override
//  void didUpdateWidget(MainIndexedStack oldWidget) {
//    if (widget.index != oldWidget.index) {
//      _controller.forward(from: 0.0);
//    }
//    super.didUpdateWidget(oldWidget);
//  }
//
//  @override
//  void initState() {
//    _controller = AnimationController(vsync: this, duration: widget.duration);
//    _controller.forward();
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FadeTransition(
//      opacity: _controller,
//      child: IndexedStack(
//        index: widget.index,
//        children: widget.children,
//      ),
//    );
//  }
//}