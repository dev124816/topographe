import 'package:flutter/material.dart';


class SideBarChild extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String title;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Border? border;
  final BorderRadius? radius;
  final Color? iconColor;
  final double? iconSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  const SideBarChild({ 
    required this.onTap,
    required this.icon,
    required this.title,
    this.width,
    this.height,
    this.padding,
    this.border,
    this.radius,
    this.iconColor,
    this.iconSize,
    this.fontColor,
    this.fontWeight,
    this.fontSize,
    Key? key 
  }) : super(key: key);

  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            border: border,
            borderRadius: radius
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                color: iconColor,
                size: iconSize
              ),
              const SizedBox(
                width: 10.0
              ),
              Text(title,
                style: TextStyle(
                  fontSize: fontSize,
                  color: fontColor,
                  fontWeight: fontWeight
                )
              )
            ],
          )          
        ),
      ),
    );
  }
}
