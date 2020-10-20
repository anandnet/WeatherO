import 'package:WeatherO/screens/city_screen.dart';
import 'package:WeatherO/screens/home.dart';
import 'package:WeatherO/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      child: Drawer(
          child: Container(
        margin: EdgeInsets.only(top: 150),
        child: Column(children: [
          _tile("Home", Icons.home, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Home();
            }));
          }),
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
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
