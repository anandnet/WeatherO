import 'package:flutter/material.dart';
class InfoWidget extends StatelessWidget {
  final IconData icon;
  final String value;
  final List<Color> color;
  InfoWidget({this.icon,this.value,this.color});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      height: size.height/6,
      //color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: size.width/5,
            width:size.width/5,
            decoration: BoxDecoration(color: color[1],borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Icon(icon,size:size.width/7,color: color[0],),
            ),
          ),
          Container(height:40,child: Text(value))
        ],
      ),
    );
  }
}