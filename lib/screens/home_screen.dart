import 'dart:convert';
import '../data.dart';
import 'package:flutter/material.dart';
import 'package:WeatherO/widgets/color_icons.dart';
import 'package:WeatherO/widgets/info_widgets.dart';
import 'package:WeatherO/widgets/side_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white
                /*gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight, //Alignment(1.2, 0.1),
              colors: [const Color(0xffffffff), Color(0xfff0a5ae)],
            )*/
                ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(
                    left: size.width * .04, right: size.width * .04),
                height: 40,
                alignment: Alignment.centerLeft,
                //color: Colors.yellow,
                child: Icon(
                  Icons.short_text,
                  size: 40,
                ),
              ),
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
                      text: "London" + ",",
                      fontSize: 23,
                      color: Colors.black,
                    ),
                    SideText(
                      text: "United Kingdom",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SideText(
                      text: "Sat,6 Aug",
                      fontSize: 15,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              // Day

              //Weather
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: size.height * .28,
                        //color: Colors.blueAccent,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: size.height * .25,
                                width: size.width * .9,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  shadowColor: Color(0xff536DFE),
                                  elevation: 16,
                                  color: Color(0xff82B1FF),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          //color: Colors.black26,
                                          padding: EdgeInsets.only(
                                              bottom: size.height * .03,
                                              left: size.width * .03),
                                          alignment: Alignment.bottomLeft,
                                          width: size.width * .45,
                                          child: Text(
                                            "Cloudy",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
                                          )), //Icon(Icons.cloud,size: 90,),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              child: Text(
                                            "20\u2070\u1d9c",
                                            style: TextStyle(
                                                fontSize:
                                                    size.aspectRatio * 140,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          Container(
                                              child: Row(
                                            children: [
                                              Text("20\u2070\u1d9c"),
                                              Icon(Icons.arrow_downward),
                                              SizedBox(
                                                width: size.width * .02,
                                              ),
                                              Text("20\u2070\u1d9c"),
                                              Icon(Icons.arrow_upward),
                                            ],
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 0, left: size.width * .09),
                              alignment: Alignment.topLeft,
                              child: ColorIcons("tsunami",
                                  size.width / size.height * 300),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color:Colors.redAccent,
                        height: size.aspectRatio *350,// .18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoWidget(
                                icon: Icons.ac_unit,
                                value: "9" + "KM/H",
                                color: [Colors.blue, Colors.blue[100]]),
                            InfoWidget(
                                icon: Icons.access_alarms,
                                value: "67" + "%",
                                color: [Colors.brown, Colors.brown[100]]),
                            InfoWidget(
                                icon: Icons.access_alarms,
                                value: "67" + "%",
                                color: [Colors.amber, Colors.amber[100]])
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
                                onTap: _decode,
                                child: Text("Next 7 days >",
                                    style: TextStyle(fontSize: 17)),
                              )
                            ],
                          )),
                      // Today hours by hour
                      Container(
                          alignment: Alignment.topCenter,
                          //color: Colors.black26,
                          height: size.height * .20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 2),
                            itemCount: hourdata.length,
                            itemBuilder: (context, item) => Row(
                              children: [
                                Container(
                                  //margin: const EdgeInsets.only(left:20),
                                  height: size.aspectRatio *300,// .16,
                                  width: size.aspectRatio *200,// .23,
                                  child: Card(
                                    color: item == 1
                                        ? Colors.purple
                                        : Colors.white,
                                    elevation: 10,
                                    shadowColor: Color(0xff536DFE),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("12:00"),
                                        ColorIcons("rain", size.aspectRatio*100),
                                        Text("20\u2070\u1d9c")
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10)
                              ],
                            ),
                          )),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
              //wind
            ]),
          )
        ],
      ),
    );
  }

  void _decode(){
    print("object");
    var x =json.decode(data);
    print(x["hourly"][0]);
    print(x["hourly"][1]);
    List hourly=x["hourly"];
    hourly.forEach((element) {
      DateTime x=DateTime.fromMillisecondsSinceEpoch(element["dt"]*1000,isUtc: true);
      DateTime currentTimeZone=x.add(Duration(hours: 5,minutes: 30));
      print("count=$currentTimeZone");
      });
    //today data
    
  var xy=DateTime.fromMillisecondsSinceEpoch(1602300468*1000,isUtc: true);
  print(xy);
  
  }

  final List<String> hourdata = [
    "4",
    "42",
    "3r",
    "33",
    "4",
    "42",
    "3r",
    "33",
    "4",
    "42",
    "3r",
    "33",
  ];
}
//const Color(0xfff1c28a),const Color(0xfff0a5ae)const Color(0xfffcdce0)
