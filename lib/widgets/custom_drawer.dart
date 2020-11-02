import 'package:WeatherO/screens/city_screen.dart';
import 'package:WeatherO/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import '../tools/utils.dart' as utils;

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      child: Drawer(
          child: Container(
        margin: EdgeInsets.only(top: 40,right: 5),
        child: Column(children: [
          Container(padding: const EdgeInsets.only(left: 10),child: Image.asset("assets/icons/name1.png",height: 70,)),
          SizedBox(height: 10,),
          _tile("Manage City", Icons.add, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ManageCity();
            }));
          }),
          _tile("Settings", Icons.settings, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return SettingScreen();
            }));
          })
        ]),
      )),
    );
  }

  Widget _tile(String title, IconData icon, Function onTap) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      shadowColor: Color(0xff536DFE),
      elevation: 6,
      child: ListTile(
        leading: Icon(icon,color: Color(0xff536DFE),size: 27,),
        title: Text(title,style: TextStyle(foreground: Paint()..shader = utils.linearGradient),),
        onTap: onTap,
      ),
    );
  }
}
