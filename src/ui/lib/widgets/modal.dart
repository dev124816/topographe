import 'package:flutter/material.dart';
import 'package:topographe/widgets/button.dart';


class Modal extends StatelessWidget {
  final Alignment alignment;
  final int headerFlex;
  final String title;
  final void Function() onClose;
  final Alignment titleAlignment;
  final int flex;
  final Widget child;
  final int footerFlex;
  final Alignment confirmAlignment;
  final String confirmTitle;
  final void Function() onTap;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Border? border;
  final BorderRadius? radius;
  final Color? color;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;
  final double? closeTopPosition;
  final double? closeRightPosition;
  final IconData? closeIcon;
  final Color? closeIconColor;
  final double? closeIconSize;
  final double? titleSize;
  final FontWeight? titleWeight;
  final Color? titleColor;
  final double? confirmWidth;
  final double? confirmHeight;
  final Color? confirmColor;
  final Border? confirmBorder;
  final BorderRadius? confirmRadius;
  final Gradient? confirmGradient;
  final List<BoxShadow>? confirmShadow;
  final double? confirmTitleSize; 
  final FontWeight? confirmTitleWeight;
  final Color? confirmTitleColor;
  final EdgeInsets? confirmPadding;
  final IconData? confirmIcon;
  final double? confirmIconSize;
  final Color? confirmIconColor;
  final double? space;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const Modal({ 
    required this.alignment,
    required this.headerFlex,
    required this.title,
    required this.onClose,
    required this.titleAlignment,
    required this.flex,
    required this.child,
    required this.footerFlex,
    required this.confirmAlignment,
    required this.confirmTitle,
    required this.onTap,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.border,
    this.radius,
    this.color,
    this.gradient,
    this.shadow,
    this.closeTopPosition,
    this.closeRightPosition,
    this.closeIcon,
    this.closeIconColor,
    this.closeIconSize,
    this.titleSize,
    this.titleWeight,
    this.titleColor,
    this.confirmWidth,
    this.confirmHeight,
    this.confirmColor,
    this.confirmBorder,
    this.confirmRadius,
    this.confirmGradient,
    this.confirmShadow,
    this.confirmTitleSize, 
    this.confirmTitleWeight,
    this.confirmTitleColor,
    this.confirmPadding,
    this.confirmIcon,
    this.confirmIconSize,
    this.confirmIconColor,
    this.space,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,    
    Key? key 
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            border: border,
            borderRadius: radius,
            color: color,
            gradient: gradient,
            boxShadow: shadow
          ),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Expanded(
                flex: headerFlex,
                child: Stack(
                  children: [
                    Positioned(
                      top: closeTopPosition,
                      right: closeRightPosition,
                      child: Button(
                        title: '',
                        onTap: onClose,
                        icon: closeIcon,
                        iconColor: closeIconColor,
                        iconSize: closeIconSize 
                      )
                    ),
                    Align(
                      alignment: titleAlignment,
                      child: Text(title,
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: titleWeight,
                          color: titleColor
                        )
                      )
                    )              
                  ],
                )
              ),
              SizedBox(
                height: space
              ),
              Expanded(
                flex: flex,
                child: child
              ),
              SizedBox(
                height: space
              ),
              Expanded(
                flex: footerFlex,
                child: Align(
                  alignment: confirmAlignment,
                  child: Button(
                    title: confirmTitle,
                    onTap: onTap,
                    width: confirmWidth,
                    height: confirmHeight,
                    color: confirmColor,
                    border: confirmBorder,
                    radius: confirmRadius,
                    gradient: confirmGradient,
                    shadow: confirmShadow,
                    fontSize: confirmTitleSize,
                    fontWeight: confirmTitleWeight,
                    fontColor: confirmTitleColor,
                    padding: confirmPadding,
                    icon: confirmIcon,
                    iconSize: confirmIconSize,
                    iconColor: confirmIconColor
                  ),
                )
              )
            ]
          )
        ),
      ),
    );
  }
}
