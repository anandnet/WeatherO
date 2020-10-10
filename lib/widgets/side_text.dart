import 'package:flutter/material.dart';
class SideText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  SideText({this.text, this.fontSize, this.color,});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize,color: color),
      ),
    );
  }
}
