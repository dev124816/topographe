import 'package:flutter/material.dart';


class Logo extends StatelessWidget {
  final String image;
  final EdgeInsets padding;
  final double? width;
  final double? height;

  const Logo({ 
    required this.image,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(0.0),
    Key? key     
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Image.asset(image,
        width: width,
        height: height
      ) 
    );
  }
}
