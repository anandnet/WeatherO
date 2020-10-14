import 'package:flutter/material.dart';
class InfoWidget extends StatelessWidget {
  final IconData icon;
  final String value;
  final List<Color> color;
  final double spaceBetween;
  final double boxSize;
  final double borderRadius;
  InfoWidget(this.icon,this.value,this.color,{this.spaceBetween=10,this.boxSize=60,this.borderRadius=20});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: boxSize,
          width: boxSize,
          decoration: BoxDecoration(color: color[1],borderRadius: BorderRadius.circular(borderRadius)),
          child: Center(
            child: Container( child: Icon(icon,size:boxSize-22,color: color[0],)),
          ),
        ),
        SizedBox(height: spaceBetween,),
        Container(height:40,child: Text(value))
      ],
    );
  }
}