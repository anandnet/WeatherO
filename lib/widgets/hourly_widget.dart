import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/widgets/color_icons.dart';
import 'package:flutter/material.dart';
import '../tools/utils.dart' as utils;

class HourlyWidget extends StatelessWidget {
  final List<HourlyWeather> _hourly;
  HourlyWidget(this._hourly);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.topCenter,
        //color: Colors.black26,
        height: size.height * .20,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 2),
          itemCount: _hourly.length,
          itemBuilder: (context, index) => Row(
            children: [
              Container(
                //margin: const EdgeInsets.only(left:20),
                height: size.aspectRatio * 300, // .16,
                width: size.aspectRatio * 200, // .23,
                child: Card(
                  color: index == 1 ? Colors.purple : Colors.white,
                  elevation: 10,
                  shadowColor: Color(0xff536DFE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(utils
                              .currentTime(_hourly[index].timestamp)
                              .hour
                              .toString() +
                          ":00"),
                      ColorIcons(
                          utils.iconName(_hourly[index].description,
                              _hourly[index].timestamp),
                          size.aspectRatio * 100),
                      Text(
                          "${utils.toCelcius(_hourly[index].temp)}\u2070\u1d9c")
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10)
            ],
          ),
        ));
  }
}
