import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/widgets/color_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../tools/utils.dart' as utils;

class HourlyWidget extends StatelessWidget {
  final List<HourlyWeather> _hourly;
  final int _timeZoneOffset;
  HourlyWidget(this._hourly,this._timeZoneOffset);
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Container(
        alignment: Alignment.topCenter,
        height: 180,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 2),
            itemCount: _hourly.length,
            itemBuilder: (context, index) {
              final _s = utils.compareDateTime(_hourly[index].timestamp);
              return Row(
                children: [
                  Container(
                    height: 138,
                    width: 92,
                    child: Card(
                      color: _s ? Color(0xff536DFE) : Colors.white,
                      elevation: 10,
                      shadowColor: Color(0xff536DFE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              _hourly[index].timestamp != null
                                  ? utils
                                          .currentTime(_hourly[index].timestamp)
                                          .hour
                                          .toString() +
                                      ":00"
                                  : "NA",
                              style: TextStyle(
                                  color: _s ? Colors.white : Colors.black)),
                          ColorIcons(
                              utils.iconName(_hourly[index].description,
                                  _hourly[index].timestamp,_timeZoneOffset),
                              46),
                          Text(
                            _hourly[index].temp != null
                                ? "${utils.toCelcius(_hourly[index].temp, dataProvider.temperatureUnit)}${String.fromCharCode(0x00B0)}" +
                                    (dataProvider.temperatureUnit ? "C" : "F")
                                : "NA",
                            style: TextStyle(
                                color: _s ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10)
                ],
              );
            }));
  }
}
