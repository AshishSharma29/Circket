import 'package:flutter/material.dart';

import 'font_style.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final EdgeInsets padding;
  final Color color;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String fontFamily;
  final TextDecoration textDecoration;

  TextWidget(
      {@required this.text,
        this.textSize = 12,
        this.padding = const EdgeInsets.all(0.0),
        this.color = Colors.black,
        this.fontWeight = FontWeight.normal,
        this.backgroundColor = Colors.transparent,
        this.textAlign = TextAlign.start,
        this.fontFamily = FontStyles.fontNamePoppins,
        this.textDecoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          decoration: textDecoration,
          fontSize: textSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
