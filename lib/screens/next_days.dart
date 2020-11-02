import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/widgets/color_icons.dart';
import 'package:WeatherO/widgets/info_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../tools/utils.dart' as utils;

class NextDays extends StatelessWidget {
  final List<DailyWeather> _dWeather;
  final int _timeZoneOffset;
  NextDays(this._dWeather, this._timeZoneOffset);
  @override
  Widget build(BuildContext context) {
    final dataprovider = Provider.of<DataProvider>(context);
    List<DailyWeather> tmp = [..._dWeather];
    tmp.removeAt(0);
    final DailyWeather tomm = tmp.removeAt(0);
    final DateTime tommTime =
        utils.currentTime(tomm.timestamp);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 40,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: size.width * .04, right: size.width * .04),
            height: 40,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //color: Colors.amberAccent,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.keyboard_arrow_left,
                          size: 40, color: Color(0xff536DFE))),
                ),
                Container(
                    child: Text(
                  "Next 7 days",
                  style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()..shader = utils.linearGradient),
                )),
                SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          Center(
            child: Hero(
              tag: '${_dWeather.hashCode}',
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 271,
                width: size.width * .93,
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
                        borderRadius: BorderRadius.circular(30)),
                    shadowColor: Color(0xff536DFE),
                    elevation: 16,
                    color: Color(0x0082B1FF),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15, right: 15, bottom: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tommorow",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                    tomm.timestamp != null
                                        ? "${utils.weekDays[tommTime.weekday]},${tommTime.day} ${utils.months[tommTime.month]}"
                                        : "NA, NA",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                ColorIcons(
                                    utils.iconName(tomm.description,
                                        tomm.timestamp ,_timeZoneOffset),
                                    100),
                                SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontFamily: "Lemonmilk",
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 3.0,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                            ),
                                          ]),
                                      children: [
                                        TextSpan(
                                            text: tomm.maxTemp != null
                                                ? "${utils.toCelcius(tomm.maxTemp, dataprovider.temperatureUnit)}"
                                                : "NA",
                                            style: TextStyle(
                                                fontSize: utils.toCelcius(
                                                            tomm.maxTemp,
                                                            dataprovider
                                                                .temperatureUnit) <
                                                        0.0
                                                    ? 42
                                                    : 50)),
                                        TextSpan(
                                            text: "/",
                                            style: TextStyle(fontSize: 45)),
                                        TextSpan(
                                            text: tomm.minTemp != null
                                                ? "${utils.toCelcius(tomm.minTemp, dataprovider.temperatureUnit)}"
                                                : "NA",
                                            style: TextStyle(
                                                fontSize: utils.toCelcius(
                                                            tomm.minTemp,
                                                            dataprovider
                                                                .temperatureUnit) <
                                                        0.0
                                                    ? 24
                                                    : 30)),
                                        TextSpan(
                                          text:
                                              " ${String.fromCharCode(0x00B0)}" +
                                                  (dataprovider.temperatureUnit
                                                      ? "C"
                                                      : "F") +
                                                  "\n",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(3.0, 3.0),
                                                  blurRadius: 3.0,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                              ]),
                                        ),
                                        TextSpan(
                                            text: "${tomm.description}",
                                            style: TextStyle(
                                                fontSize: tomm.description
                                                            .length <=
                                                        16
                                                    ? 15
                                                    : tomm.description.length <=
                                                            22
                                                        ? 12
                                                        : 9)),
                                      ]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InfoWidget(
                                    "wind",
                                    tomm.windSpeed != null
                                        ? tomm.windSpeed.toStringAsFixed(1)
                                        : null,
                                    [Colors.blue, Colors.transparent],
                                    spaceBetween: 0,
                                    boxSize: 55,
                                    textColor: Colors.white,
                                    borderRadius: 15,
                                    unitText: "KM/H",
                                  ),
                                  InfoWidget(
                                    "cloud",
                                    tomm.clouds,
                                    [Colors.brown, Colors.transparent],
                                    spaceBetween: 0,
                                    boxSize: 55,
                                    textColor: Colors.white,
                                    borderRadius: 15,
                                    unitText: "%",
                                  ),
                                  InfoWidget(
                                    "humidity",
                                    tomm.humidity,
                                    [Colors.amber, Colors.transparent],
                                    spaceBetween: 0,
                                    boxSize: 55,
                                    textColor: Colors.white,
                                    borderRadius: 15,
                                    unitText: "%",
                                  )
                                ],
                              ),
                            )
                          ]),
                    )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: tmp.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 40, right: 40),
                      leading: Text(
                          utils.weekDays[utils
                              .currentTime(
                                  tmp[index].timestamp)
                              .weekday],
                          style: TextStyle(
                              foreground: Paint()
                                ..shader = utils.linearGradient)),
                      title: Center(
                          child: Text(
                        "${tmp[index].maxTemp != null ? utils.toCelcius(tmp[index].maxTemp, dataprovider.temperatureUnit) : "NA"}${String.fromCharCode(0x00B0)}/${tmp[index].minTemp != null ? utils.toCelcius(tmp[index].minTemp, dataprovider.temperatureUnit) : "NA"}${String.fromCharCode(0x00B0)}",
                        style: TextStyle(
                            foreground: Paint()..shader = utils.linearGradient),
                      )),
                      subtitle: Center(
                          child: Text(
                              tmp[index].description != null
                                  ? tmp[index].description
                                  : "NA",
                              style: TextStyle(
                                  foreground: Paint()
                                    ..shader = utils.linearGradient))),
                      trailing: ColorIcons(
                          utils.iconName(
                              tmp[index].description, tmp[index].timestamp,_timeZoneOffset),
                          40),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
