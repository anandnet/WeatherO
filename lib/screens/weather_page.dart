import 'package:WeatherO/models/models.dart';
import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/next_days.dart';
import 'package:WeatherO/widgets/hourly_widget.dart';
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
    return Scaffold(
      body: Container(
        child: Column(children: [
          //Place, Country,Date
          Container(
            //color:Colors.black38,
            padding: EdgeInsets.only(
                left: size.width * .04, right: size.width * .04),
            height: size.height * .14,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                SideText(
                  text: widget.city.name + ",",
                  fontSize: 23,
                  color: Colors.black,
                ),
                SideText(
                  text: widget.city.adminDistrict != null
                      ? widget.city.adminDistrict + "," + widget.city.country
                      : widget.city.country,
                  fontSize: 20,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                SideText(
                  text:
                      "${utils.weekDays[utils.currentTime(widget.weather["current"].timestamp).weekday]},${utils.currentTime(widget.weather["current"].timestamp).day} ${utils.months[utils.currentTime(widget.weather["current"].timestamp).month]}",
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
          // Day

          //Weather
          Expanded(
            child: RefreshIndicator(
              onRefresh: dataProvider.refresh,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      height: size.height * .28,
                      //color: Colors.blueAccent,
                      child: Center(
                        child: Hero(
                          tag: "${widget.weather['daily'].hashCode}",
                          child: Container(
                            height: size.height * .25,
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
                                  borderRadius: BorderRadius.circular(30)),
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
                                            top: _constraint.maxHeight * .1),
                                        height: _constraint.maxHeight * .25,
                                        //color:Colors.amber,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: _constraint.maxWidth *
                                                      .07),
                                              width: _constraint.maxWidth * .75,
                                              child: Text(
                                                widget.weather['current']
                                                    .description,
                                                style: TextStyle(
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(10.0, 10.0),
                                                        blurRadius: 30.0,
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                      ),
                                                    ],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        size.aspectRatio * 35,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                                width:
                                                    _constraint.maxWidth * .25,
                                                child: Text(
                                                  "Now",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        )),
                                    Container(
                                      height: _constraint.maxHeight * .75,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: _constraint.maxWidth * .5,
                                              child: Center(
                                                child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Lemonmilk"),
                                                        children: [
                                                      TextSpan(
                                                        text:
                                                            "${utils.toCelcius(widget.weather["current"].temp)}\u2070\u1d9c",
                                                        style: TextStyle(
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    5.0, 15.0),
                                                                blurRadius:
                                                                    40.0,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                              ),
                                                            ],
                                                            fontSize:
                                                                size.aspectRatio *
                                                                    120,
                                                            //fontWeight: FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      TextSpan(
                                                          text: "\nFeels like " +
                                                              "${utils.toCelcius(widget.weather["current"].feelsLike)}\u2070\u1d9c")
                                                    ])),
                                              )),
                                          Container(
                                            width: _constraint.maxWidth * .5,
                                            alignment: Alignment.topLeft,
                                            child: Center(
                                              child: ColorIcons(
                                                  utils.iconName(
                                                      widget.weather["current"]
                                                          .description,
                                                      widget.weather["current"]
                                                          .timestamp),
                                                  size.width /
                                                      size.height *
                                                      250),
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
                      height: size.aspectRatio * 250, // .18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoWidget(
                              "wind",
                              (widget.weather["current"].windSpeed * 3.6)
                                      .toStringAsFixed(1) +
                                  "KM/H",
                              [Colors.blue, Colors.blue[100]]),
                          InfoWidget(
                              "cloud",
                              (widget.weather["current"].clouds).toString() +
                                  "%",
                              [Colors.brown, Colors.brown[100]]),
                          InfoWidget(
                              "humidity",
                              (widget.weather["current"].humidity).toString() +
                                  "%",
                              [Colors.amber, Colors.amber[100]])
                        ],
                      ),
                    ),
                    //Next Seven day
                    Container(
                        padding: EdgeInsets.only(
                            left: size.width * .04, right: size.width * .04),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(fontSize: 17),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return NextDays(widget.weather["daily"]);
                                }));
                              },
                              child: Text("Next 7 days >",
                                  style: TextStyle(
                                      fontSize: 17, color: Color(0xff0094EB))),
                            )
                          ],
                        )),
                    // Today hours by hour
                    HourlyWidget(widget.weather["hourly"]),
                    SizedBox(height: 30)
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
//const Color(0xfff1c28a),const Color(0xfff0a5ae)const Color(0xfffcdce0)
//Coloricon
/* Container(
                            padding:
                                EdgeInsets.only(top: 0, left: size.width * .09),
                            alignment: Alignment.topLeft,
                            child: ColorIcons(
                                utils.iconName(widget.weather["current"].description, widget.weather["current"].timestamp), size.width / size.height * 300),
                          ),*/
