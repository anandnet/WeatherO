import 'package:WeatherO/screens/home_screen.dart';
import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int pageIndex = 0;
  List _listPlaces = ["A", "B", "C", "D"];
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: .999);
    _pageController.addListener(() {
      setState(() {
        pageIndex = (_pageController.page).ceil();
      });
      //print(_pageController.page);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(),
          Container(
              //color: Colors.black38,
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
                          child: Icon(
                            Icons.short_text,
                            size: 40,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 40,
                          width: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _listPlaces.map((e) {
                              if (_listPlaces.indexOf(e) == pageIndex) {
                                return Container(
                                    height: 5, width: 5, color: Colors.amber);
                              } else {
                                return Container(
                                    height: 5, width: 5, color: Colors.black);
                              }
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: [App(), App(), App(), App()],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
