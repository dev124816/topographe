import 'package:flutter/material.dart';


class Layout extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool right;
  final bool bottom;
  final bool left;

  const Layout({
    required this.child,
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
    Key? key
  }) : super(key: key);

  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Scaffold(
        body: SingleChildScrollView(
          child: child
        )
      )      
    );
  }
}
