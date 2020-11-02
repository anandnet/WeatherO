import 'package:WeatherO/widgets/color_icons.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String iconName;
  final dynamic value;
  final List<Color> color;
  final double spaceBetween;
  final double boxSize;
  final double borderRadius;
  final Color textColor;
  final String unitText;
  InfoWidget(this.iconName, this.value, this.color,
      {this.spaceBetween = 10,
      this.boxSize = 60,
      this.borderRadius = 20,
      this.textColor = Colors.black,
      this.unitText = ''});
  @override
  Widget build(BuildContext context) {
    //final size=MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: boxSize,
          width: boxSize,
          decoration: BoxDecoration(
              color: color[1],
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Center(
              child: Container(
                  child: ColorIcons(
                      iconName,
                      boxSize -
                          18)) //Icon(icon,size:boxSize-22,color: color[0],)),
              ),
        ),
        SizedBox(
          height: spaceBetween,
        ),
        Container(
            height: 40,
            child: Text(
              value != null ? "$value" + unitText : "NA",
              style: TextStyle(color: textColor),
            ))
      ],
    );
  }
}
