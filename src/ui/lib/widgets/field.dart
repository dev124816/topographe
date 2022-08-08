import 'package:flutter/material.dart';


class Field extends StatelessWidget {
  final String label;
  final void Function(String) onChanged;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final Color? labelFontColor;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final Color? focusColor;
  final Color? fillColor;
  final String? hintText;
  final Color? hintTextColor;
  final FontWeight? hintTextWeight;
  final double? hintTextSize;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final BoxConstraints? suffixIconConstraints;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Alignment alignment;
  final double cursorWidth;
  final bool obscureText;
  final InputBorder inputBorder;
  final bool enabled;
  final void Function(String)? onSubmitted;

  const Field({ 
    required this.label,
    required this.onChanged,
    this.labelFontSize,
    this.labelFontWeight,
    this.labelFontColor,
    this.cursorColor,
    this.keyboardAppearance,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.focusColor,
    this.fillColor,
    this.hintText,
    this.hintTextColor,
    this.hintTextWeight,
    this.hintTextSize,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixText,
    this.suffixStyle,
    this.suffixIconConstraints,
    this.fontColor,
    this.fontWeight,
    this.fontSize,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.alignment = Alignment.centerLeft,
    this.cursorWidth = 1.0,
    this.obscureText = false,
    this.inputBorder = InputBorder.none,
    this.enabled = true,
    this.onSubmitted,
    Key? key 
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Align(
          alignment: alignment,
          child: Text(label, 
            style: TextStyle(
              fontSize: labelFontSize, 
              fontWeight: labelFontWeight,
              color: labelFontColor
            )
          )
        ),
        TextField(
          cursorWidth: cursorWidth,
          cursorColor: cursorColor,
          keyboardAppearance: keyboardAppearance,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: inputBorder, 
            focusColor: focusColor,
            fillColor: fillColor, 
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintTextColor,
              fontWeight: hintTextWeight,
              fontSize: hintTextSize
            ),
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            prefixStyle: prefixStyle,
            prefixIconConstraints: prefixIconConstraints,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: suffixStyle,
            suffixIconConstraints: suffixIconConstraints,
            enabled: enabled  
          ),
          style: TextStyle(
            color: fontColor,
            fontWeight: fontWeight,
            fontSize: fontSize
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted
        ),
      ]
    );
  }
}
