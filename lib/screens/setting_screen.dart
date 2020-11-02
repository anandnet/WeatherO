import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/home.dart';
import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../tools/utils.dart' as utils;
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _globalKey = GlobalKey<ScaffoldState>();
  //0 for celcius and 1 for fahren.
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }));
        return true;
      },
      child: Scaffold(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25,color: Color(0xff536DFE),
                          ),
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(fontSize: 20,foreground: Paint()..shader = utils.linearGradient),
                        ),
                        SizedBox(width: 40)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Card(
                        child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: size.width * .04,
                                right: size.width * .04),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Temperature Unit",
                              style: TextStyle(fontSize: 17,foreground: Paint()..shader = utils.linearGradient),
                            )),
                        Container(
                          padding: EdgeInsets.only(
                              left: size.width * .04, right: size.width * .04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Celcius",style: TextStyle(foreground: Paint()..shader = utils.linearGradient)),
                              Radio(
                                  value: 0,
                                  groupValue:
                                      dataProvider.temperatureUnit ? 0 : 1,
                                  onChanged: (x) {
                                    dataProvider.changeTempUnit(x);
                                  }),
                              Text("Fahrenhight",style: TextStyle(foreground: Paint()..shader = utils.linearGradient)),
                              Radio(
                                  value: 1,
                                  groupValue:
                                      dataProvider.temperatureUnit ? 0 : 1,
                                  onChanged: (x) {
                                    dataProvider.changeTempUnit(x);
                                  })
                            ],
                          ),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
