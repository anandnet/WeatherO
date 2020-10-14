import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/weather_page.dart';
import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int pageIndex = 0;
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
  void didChangeDependencies() {
    Provider.of<DataProvider>(context).init();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataProvider = Provider.of<DataProvider>(context);
    final List<City> _cityList=dataProvider.cities;
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
                            children: _cityList.map((e) {
                              if (_cityList.indexOf(e) == pageIndex) {
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
                      children: _cityList.map((city) => WeatherPage(city)).toList(),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
