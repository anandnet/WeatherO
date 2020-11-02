import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/next_days.dart';
import 'package:WeatherO/widgets/hourly_widget.dart';
import 'package:WeatherO/widgets/info2.dart';
import 'package:provider/provider.dart';
import '../tools/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:WeatherO/widgets/color_icons.dart';
import 'package:WeatherO/widgets/info_widgets.dart';
import 'package:WeatherO/widgets/side_text.dart';

class WeatherPage extends StatefulWidget {
  final City city;
  final Map<String, dynamic> weather;
  WeatherPage(this.city, this.weather);
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataProvider = Provider.of<DataProvider>(context);
    final CurrentWeather _currentWeather =
        widget.weather == null ? null : widget.weather["current"];
    final DateTime _currentDateTime = _currentWeather != null
        ? _currentWeather.timestamp != null
            ? utils.currentTime(
                _currentWeather.timestamp)
            : null
        : null;
    final timeString =_currentDateTime!=null? _currentWeather.timestamp != null
        ? "${utils.weekDays[_currentDateTime.weekday]},${_currentDateTime.day} ${utils.months[_currentDateTime.month]}"
        : "NA, NA":"NA, NA";
    return Scaffold(
      body: Container(
        child: Column(children: [
          //Place, Country,Date
          Container(
            //color:Colors.black38,
            padding: EdgeInsets.only(
                left: size.width * .04, right: size.width * .04),
            height: 115,
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                Column(
                  children: [
                    SideText(
                      text: widget.city.name + ",",
                      fontSize: 21,
                      gradient: true,
                      color: Colors.black,
                    ),
                    SideText(
                      text: widget.city.adminDistrict != null &&
                              widget.city.adminDistrict != "null"
                          ? widget.city.adminDistrict +
                              "," +
                              widget.city.country
                          : widget.city.country,
                      fontSize: 18,
                      gradient: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SideText(
                      text: timeString,
                      fontSize: 15,
                      gradient: false,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                widget.city.temporary
                    ? Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(right: 20, top: 0),
                        child: ColorIcons("home", 60),
                      )
                    : SizedBox()
              ],
            ),
          ),

          //Weather
          Expanded(
            child: widget.weather == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: dataProvider.refresh,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            height: 200,
                            //color: Colors.blueAccent,
                            child: Center(
                              child: Hero(
                                tag: "${widget.weather['daily'].hashCode}",
                                child: Container(
                                  height: 200,
                                  width: size.width * .92,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xff0094EB),
                                            Color(0xff536DFE),
                                          ])),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    shadowColor: Color(0xff536DFE),
                                    elevation: 16,
                                    color: Color(0x000081CC),
                                    child: LayoutBuilder(
                                        builder: (context, _constraint) {
                                      return Container(
                                          child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: _constraint.maxHeight *
                                                      .1),
                                              height:
                                                  _constraint.maxHeight * .25,
                                              //color:Colors.amber,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: _constraint
                                                                .maxWidth *
                                                            .07),
                                                    width:
                                                        _constraint.maxWidth *
                                                            .75,
                                                    child: Text(
                                                      _currentWeather
                                                          .description,
                                                      style: TextStyle(
                                                          shadows: <Shadow>[
                                                            Shadow(
                                                              offset: Offset(
                                                                  10.0, 10.0),
                                                              blurRadius: 30.0,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                          ],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: (_currentWeather
                                                                      .description
                                                                      .length <=
                                                                  16)
                                                              ? 16
                                                              : _currentWeather
                                                                          .description
                                                                          .length <=
                                                                      20
                                                                  ? 12
                                                                  : 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                      width:
                                                          _constraint.maxWidth *
                                                              .25,
                                                      child: Text(
                                                        "Now",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              )),
                                          Container(
                                            height: _constraint.maxHeight * .75,
                                            child: Row(
                                              children: [
                                                Container(
                                                    width:
                                                        _constraint.maxWidth *
                                                            .5,
                                                    child: Center(
                                                      child: RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Lemonmilk"),
                                                              children: [
                                                            TextSpan(
                                                              text:
                                                                  "${_currentWeather.temp != null ? utils.toCelcius(_currentWeather.temp, dataProvider.temperatureUnit) : "__"}${String.fromCharCode(0x00B0)}", //\u2070\u1d9c",
                                                              style: TextStyle(
                                                                  shadows: <
                                                                      Shadow>[
                                                                    Shadow(
                                                                      offset: Offset(
                                                                          5.0,
                                                                          15.0),
                                                                      blurRadius:
                                                                          40.0,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7),
                                                                    ),
                                                                  ],
                                                                  fontSize: 55,
                                                                  //fontWeight: FontWeight.bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            TextSpan(
                                                                text: dataProvider
                                                                        .temperatureUnit
                                                                    ? "C"
                                                                    : "F",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        40)),
                                                            TextSpan(
                                                                text: "\nFeels like " +
                                                                    "${_currentWeather.feelsLike != null ? utils.toCelcius(_currentWeather.feelsLike, dataProvider.temperatureUnit) : "__"}${String.fromCharCode(0x00B0)}" +
                                                                    (dataProvider
                                                                            .temperatureUnit
                                                                        ? "C"
                                                                        : "F"))
                                                          ])),
                                                    )),
                                                Container(
                                                  width:
                                                      _constraint.maxWidth * .5,
                                                  alignment: Alignment.topLeft,
                                                  child: Center(
                                                    child: ColorIcons(
                                                        utils.iconName(
                                                            _currentWeather
                                                                .description,
                                                            _currentWeather
                                                                    .timestamp ,
                                                                widget.city
                                                                    .timeZoneOffset),
                                                        115),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ));
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            //color:Colors.redAccent,
                            height: 115, // .18,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InfoWidget(
                                  "wind",
                                  _currentWeather.windSpeed != null
                                      ? (_currentWeather.windSpeed * 3.6)
                                          .toStringAsFixed(1)
                                      : null,
                                  [Colors.blue, Colors.blue[100]],
                                  unitText: "KM/H",
                                ),
                                InfoWidget(
                                  "cloud",
                                  _currentWeather.clouds,
                                  [Colors.brown, Colors.brown[100]],
                                  unitText: "%",
                                ),
                                InfoWidget(
                                  "humidity",
                                  _currentWeather.humidity,
                                  [Colors.amber, Colors.amber[100]],
                                  unitText: "%",
                                )
                              ],
                            ),
                          ),
                          //Next Seven day
                          Container(
                              padding: EdgeInsets.only(
                                  left: size.width * .04,
                                  right: size.width * .04),
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Today",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return NextDays(widget.weather["daily"],
                                            widget.city.timeZoneOffset);
                                      }));
                                    },
                                    child: Text("Next 7 days >",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff0094EB))),
                                  )
                                ],
                              )),
                          // Today hours by hour
                          HourlyWidget(widget.weather["hourly"],
                              widget.city.timeZoneOffset),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Info2(
                                      _currentWeather.sunrise != null
                                          ? "0${_time(_currentWeather.sunrise,widget.city.timeZoneOffset).hour}:${_time(_currentWeather.sunrise,widget.city.timeZoneOffset).minute}"
                                          : "NA",
                                      "sunrise",
                                    ),
                                    Info2(
                                      _currentWeather.sunset != null
                                          ? "${_time(_currentWeather.sunset,widget.city.timeZoneOffset).hour}:${_time(_currentWeather.sunset,widget.city.timeZoneOffset).minute}"
                                          : "NA",
                                      "sunset",
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Info2(
                                      _currentWeather.windDirection,
                                      "wind Direction",
                                      unitText: String.fromCharCode(0x00B0),
                                    ),
                                    Info2(
                                      _currentWeather.pressure,
                                      "pressure",
                                      unitText: "hPa",
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Info2(
                                      _currentWeather.rain,
                                      "Rain",
                                      unitText: 'mm',
                                    ),
                                    Info2(
                                      _currentWeather.uvi,
                                      "uvi",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ]),
      ),
    );
  }

  DateTime _time(int secondEpoch,int offset) {
  final DateTime x = DateTime.fromMillisecondsSinceEpoch(secondEpoch * 1000,isUtc: true).add(Duration(seconds: offset));
  return x;
}
}
