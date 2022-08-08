import 'package:flutter/material.dart';


class Footer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Border? border;
  final BorderRadius? radius;
  final Color? color;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;

  const Footer({
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.border,
    this.radius,
    this.color,
    this.gradient,
    this.shadow,
    Key? key 
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        border: border,
        borderRadius: radius,
        color: color,
        gradient: gradient,
        boxShadow: shadow
      ),
      child: child     
    );
  }
}
