import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/widgets/color_icons.dart';
import 'package:WeatherO/widgets/info_widgets.dart';
import 'package:flutter/material.dart';
import '../tools/utils.dart' as utils;

class NextDays extends StatelessWidget {
  final List<DailyWeather> _dWeather;
  NextDays(this._dWeather);
  @override
  Widget build(BuildContext context) {
    print(_dWeather.length);
    List<DailyWeather> tmp = [..._dWeather];
    tmp.removeAt(0);
    DailyWeather tomm = tmp.removeAt(0);
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                      child: Icon(Icons.keyboard_arrow_left, size: 40)),
                ),
                Container(
                    child: Text(
                  "Next 7 days",
                  style: TextStyle(fontSize: 20),
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
                height: size.height * .348,
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
                                    "${utils.weekDays[utils.currentTime(tomm.timestamp).weekday]},${utils.currentTime(tomm.timestamp).day} ${utils.months[utils.currentTime(tomm.timestamp).month]}",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                ColorIcons(
                                    utils.iconName(
                                        tomm.description, tomm.timestamp),
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
                                            text:
                                                "${utils.toCelcius(tomm.maxTemp)}",
                                            style: TextStyle(
                                                fontSize: utils.toCelcius(
                                                            tomm.maxTemp) <
                                                        0.0
                                                    ? 45
                                                    : 50)),
                                        TextSpan(
                                            text: "/",
                                            style: TextStyle(fontSize: 45)),
                                        TextSpan(
                                            text:
                                                "${utils.toCelcius(tomm.minTemp)}",
                                            style: TextStyle(
                                                fontSize: utils.toCelcius(
                                                            tomm.maxTemp) <
                                                        0.0
                                                    ? 25
                                                    : 30)),
                                        TextSpan(
                                          text: " \u2070\u1d9c\n",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.aspectRatio * 80,
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
                                                fontSize:
                                                    tomm.description.length <=
                                                            18
                                                        ? 18
                                                        : 15)),
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
                                    tomm.windSpeed.toStringAsFixed(1) + "KM/H",
                                    [Colors.blue, Colors.transparent],
                                    spaceBetween: 0,
                                    boxSize: 55,
                                    textColor: Colors.white,
                                    borderRadius: 15,
                                  ),
                                  InfoWidget(
                                      "cloud",
                                      tomm.clouds.toString() + "%",
                                      [Colors.brown, Colors.transparent],
                                      spaceBetween: 0,
                                      boxSize: 55,
                                      textColor: Colors.white,
                                      borderRadius: 15),
                                  InfoWidget(
                                      "humidity",
                                      tomm.humidity.toString() + "%",
                                      [Colors.amber, Colors.transparent],
                                      spaceBetween: 0,
                                      boxSize: 55,
                                      textColor: Colors.white,
                                      borderRadius: 15)
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
                      leading: Text(utils.weekDays[
                          utils.currentTime(tmp[index].timestamp).weekday]),
                      title: Center(
                          child: Text(
                              "${utils.toCelcius(tmp[index].maxTemp)}/${utils.toCelcius(tmp[index].minTemp)}")),
                      subtitle: Center(child: Text(tmp[index].description)),
                      trailing: ColorIcons(
                          utils.iconName(
                              tmp[index].description, tmp[index].timestamp),
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
