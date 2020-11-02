import 'package:flutter/material.dart';
import '../tools/utils.dart' as utils;
class Info2 extends StatelessWidget {
  final String _infoTitleText;
  final dynamic _value;
  final double size;
  final String unitText;
  Info2(this._value,this._infoTitleText, 
      {this.size = 40, this.unitText = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width:MediaQuery.of(context).size.width*.45,
      child: Column(
        children: [
          Container(width: MediaQuery.of(context).size.width*.45,child: Text(_infoTitleText,textAlign: TextAlign.left,)),
          Container(alignment: Alignment.centerLeft,child: Text(_value != null ? "$_value" + unitText : "NA",textAlign: TextAlign.left,style: TextStyle(fontSize: 22,foreground: Paint()..shader=utils.linearGradient))),
        ],
      ),
    );
  }
}
