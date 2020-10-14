import 'package:WeatherO/widgets/color_icons.dart';
import 'package:WeatherO/widgets/info_widgets.dart';
import 'package:flutter/material.dart';

class NextDays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Container(
              height: size.height * .348,
              width: size.width * .93,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                shadowColor: Color(0xff536DFE),
                elevation: 16,
                color: Color(0xff82B1FF),
                child: Padding(
                  padding: const EdgeInsets.only(top:15.0,left:15,right: 15,bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text("Tommorow"),
                        Text("Sun,8 Aug")
                      ],),
                      SizedBox(height: 14,),
                      Row(
                        children: [
                          ColorIcons("wind_cloud", 100),
                          SizedBox(width: 20,),
                          Text("20/17\nSunny",style: TextStyle(fontSize:30),),
                          SizedBox(width: 10,),
                          Text("0C")
                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,right:8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          InfoWidget(Icons.wb_sunny,"10KM/H",[Colors.black45,Colors.amber],spaceBetween: 10,boxSize: 50,borderRadius: 15,),
                          InfoWidget(Icons.wb_sunny,"10%",[Colors.black45,Colors.amber],spaceBetween: 10,boxSize: 50,borderRadius: 15),
                          InfoWidget(Icons.wb_sunny,"10%",[Colors.black45,Colors.amber],spaceBetween: 10,boxSize: 50,borderRadius: 15)
                        ],),
                      )
                    ]
                  ),
                )
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 40, right: 40),
                      leading: Text("Mon"),
                      title: Center(child: Text("11/7")),
                      subtitle: Center(child: Text("Claudy")),
                      trailing: Icon(Icons.cloud),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
