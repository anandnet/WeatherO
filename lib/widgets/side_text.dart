import 'package:flutter/material.dart';
import '../tools/utils.dart' as utils;

class SideText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final bool gradient;
  SideText({
    this.text,
    this.fontSize,
    this.gradient,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            foreground: gradient?(Paint()..shader = utils.linearGradient):(Paint()..color = color), fontSize: fontSize),
      ),
    );
  }
}
