import 'package:flutter/material.dart';


class Header extends StatelessWidget {
  final List<Widget> children;
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
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const Header({ 
    required this.children,
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
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
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
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children
      )      
    );
  }
}
