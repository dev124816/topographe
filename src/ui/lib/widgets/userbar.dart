import 'package:flutter/material.dart';


class UserBar extends StatelessWidget {
  final String username;
  final IconData icon;
  final void Function() onTap;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? color;
  final Border? border;
  final BorderRadius? radius;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? space;
  final Color? iconColor;
  final double? iconSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const UserBar({
    required this.username,
    required this.icon,
    required this.onTap,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.color,
    this.border,
    this.radius,
    this.gradient,
    this.shadow,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    this.space,
    this.iconColor,
    this.iconSize,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
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
        children: [
          Text(username,
            style: TextStyle(
              color: fontColor,
              fontWeight: fontWeight,
              fontSize: fontSize
            )
          ),
          SizedBox(
            width: space
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: Icon(icon,
                color: iconColor,
                size: iconSize
              )
            ),
          )
        ]
      )
    );
  }
}
