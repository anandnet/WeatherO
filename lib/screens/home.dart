import 'dart:async';

import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/city_screen.dart';
import 'package:WeatherO/screens/weather_page.dart';
import 'package:WeatherO/widgets/color_icons.dart';
import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool init = true;
  PageController _pageController;
  int _pageIndex = 0;
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: .999);
    _pageController.addListener(() {
      setState(() {
        if (_pageController.page - _pageController.page.truncateToDouble() >=
            0.5) {
          _pageIndex = _pageController.page.truncateToDouble().toInt() + 1;
        } else {
          _pageIndex = _pageController.page.truncateToDouble().toInt();
        }
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      final _var = Provider.of<DataProvider>(context);
      _var.init(_globalKey);
      if (_var.isInit) {
        Timer.periodic(Duration(minutes: 5), (Timer t) async {
          if (await _var.checkConnectivity()) {
            _var.refresh();
          } else {
            _var.fetchCurrentWeatherFromLocal();
          }
        });
      }
      setState(() {
        init = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        Color(0xff0094EB),
        Color(0xff536DFE),
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    final size = MediaQuery.of(context).size;
    final dataProvider = Provider.of<DataProvider>(context);
    final Map<int, Map<String, dynamic>> weather = dataProvider.weather;
    final List<City> _cityList = dataProvider.cities;
    return WillPopScope(
      onWillPop: () async {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text(
                  'Are you sure?',
                ),
                content: new Text(
                  'Do you want to exit',
                ),
                actions: <Widget>[
                  FlatButton(
                    textColor: Color(0xff536DFE),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("No"),
                  ),
                  FlatButton(
                    textColor: Color(0xff536DFE),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Yes"),
                  )
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: 40,
                ),
                child: Column(
                  children: [
                    Stack(
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
                            child: ColorIcons(
                              "menu",
                              40,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 40,
                            width: _cityList.length == 0
                                ? 150
                                : _cityList.length * 12.toDouble(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: _cityList.length == 0
                                  ? [
                                      Text(
                                        "WeatherO",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                      )
                                    ]
                                  : _cityList.map((e) {
                                      if (_cityList.indexOf(e) == _pageIndex) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff3975A7),
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(1.2, 1.2))
                                              ]),
                                          height: 7,
                                          width: 7,
                                        );
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black54
                                                        .withOpacity(0.5),
                                                    offset: Offset(1, 1))
                                              ]),
                                          height: 5,
                                          width: 5,
                                        );
                                      }
                                    }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: dataProvider.weather.length != 0
                          ? PageView(
                              controller: _pageController,
                              children: _cityList
                                  .map((city) =>
                                      WeatherPage(city, weather[city.id]))
                                  .toList(),
                            )
                          : dataProvider.isCityAdded
                              ? Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Container(
                                  height: size.height,
                                  width: size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/city1.png",
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            gradient: LinearGradient(colors: [
                                              Color(0xff0094EB),
                                              Color(0xff536DFE),
                                            ])),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          elevation: 5,
                                          shadowColor: Color(0xff536DFE),
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ManageCity();
                                              }));
                                            },
                                            child: Center(
                                                child: Text(
                                              "Add City",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
