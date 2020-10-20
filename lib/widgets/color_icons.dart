import 'package:flutter/material.dart';

class ColorIcons extends StatelessWidget {
  final String name;
  final double size;
  ColorIcons(this.name, this.size);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: Image.asset("assets/icons/" + name + ".png"));
  }
}
