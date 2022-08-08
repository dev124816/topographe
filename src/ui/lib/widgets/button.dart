import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Border? border;
  final BorderRadius? radius;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final bool? vertical;
  final BoxShape shape;

  const Button({
    required this.title,
    required this.onTap,
    this.width,
    this.height,
    this.color,
    this.border,
    this.radius,
    this.gradient,
    this.shadow,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.fontColor,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.padding,
    this.margin,
    this.vertical,
    this.shape = BoxShape.rectangle,
    Key? key 
  }) : super(key: key);

  Widget generateButtonContent() {
    Icon iconWidget = Icon(icon, 
      size: iconSize, 
      color: iconColor
    );
    Text textWidget = Text(title,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: fontColor
      )
    );

    if (icon != null && title != '') {
      return vertical != null ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          iconWidget, 
          textWidget
        ]
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          iconWidget,
          textWidget
        ]
      );

    } else if (icon != null) {
      return iconWidget;

    } else {
      return textWidget;

    }
  }

  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            border: border, 
            borderRadius: radius, 
            color: color, 
            gradient: gradient, 
            shape: shape,
            boxShadow: shadow
          ),
          child: generateButtonContent()                      
        )  
      )
    );
  }
}
