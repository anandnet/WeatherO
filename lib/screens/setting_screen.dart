import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      drawer: CustomDrawer(),
      key: _globalKey,
      body: Stack(
        children: [
          Container(),
          Container(
            margin: EdgeInsets.only(
                top: 40,
              ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: size.width * .04, right: size.width * .04),
                  height: 40,
                  alignment: Alignment.centerLeft,
                  //color: Colors.yellow,
                  child: GestureDetector(
                    onTap: () {
                      _globalKey.currentState.openDrawer();
                    },
                    child: Icon(
                      Icons.short_text,
                      size: 40,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                top: 10,
              ),
                  child: Card(
                  child:Column(children: [
                    Container(
                      padding: EdgeInsets.only(
                      left: size.width * .04, right: size.width * .04),
                      alignment: Alignment.centerLeft, child: Text("Temperature Unit",style: TextStyle(fontSize: 17),)),
                    Container(
                      padding: EdgeInsets.only(
                      left: size.width * .04, right: size.width * .04),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Text("Celcius"),
                        Radio(value: "B", groupValue: "A", onChanged: null),
                        Text("Fahrenhight"),
                        Radio(value: null, groupValue: "B", onChanged: null)
                      ],),
                    )
                  ],)
                ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}