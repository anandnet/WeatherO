import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

/*
class ColorIcons {
  final BuildContext context;
  ColorIcons(this.context);
  void init() async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    print(manifestMap);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/icons/'))
        .where((String key) => key.contains('.png'))
        .toList();
    print(imagePaths);
  }
}*/
