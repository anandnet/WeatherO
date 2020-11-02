import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/home.dart';
import 'package:provider/provider.dart';
import "../models/models.dart";
import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import '../tools/utils.dart' as utils;
class ManageCity extends StatefulWidget {
  @override
  _ManageCityState createState() => _ManageCityState();
}

class _ManageCityState extends State<ManageCity> {
  bool _isSearching = false;
  final _globalKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    List<City> _cityList = dataProvider.cities;
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }));
        return true;
      },
      child: Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Container(),
            Container(
              margin: EdgeInsets.only(
                top: 40,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: size.width * .04, right: size.width * .08),
                    height: 40,
                    alignment: Alignment.centerLeft,
                    //color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                            color: Color(0xff536DFE),
                          ),
                        ),
                        Text(
                          "Manage City",
                          style: TextStyle(fontSize: 20,foreground: Paint()..shader=utils.linearGradient),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSearching = true;
                              });
                            },
                            child: Icon(Icons.add, size: 30,color: Color(0xff0094EB),))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: _cityList.length == 0
                        ? Center(
                            child: Text("No City",style: TextStyle(foreground: Paint()..shader=utils.linearGradient),),
                          )
                        : ReorderableListView(
                            onReorder: (int oldIndex, int newIndex) {
                              dataProvider.reorderCityList(oldIndex, newIndex);
                            },
                            children: _cityList.map((x) {
                              return Container(
                                key: ValueKey(x.name),
                                child: Card(
                                  shadowColor: Color(0xff536DFE),
                                  elevation: 6,
                                  child: ListTile(
                                    leading: Icon(Icons.location_on,color:Color(0xff536DFE)),
                                    title: Text(x.name,style: TextStyle(foreground: Paint()..shader=utils.linearGradient),),
                                    subtitle: Text(x.adminDistrict != "null" &&
                                            x.adminDistrict != null
                                        ? x.adminDistrict.toString() +
                                            "," +
                                            x.country.toString()
                                        : x.country.toString(),style: TextStyle(foreground: Paint()..shader=utils.linearGradient),),
                                    trailing: IconButton(
                                        icon: Icon(Icons.delete,color: Color(0xff0094EB),),
                                        onPressed: () {
                                          if (!x.temporary) {
                                            dataProvider.removeCity(x);
                                          } else {
                                            _globalKey.currentState
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Cannot delete current city!"),
                                              duration: Duration(seconds: 1),
                                            ));
                                          }
                                        }),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ))
                ],
              ),
            ),
            _isSearching
                ? Builder(builder: (context) {
                    return _search(dataProvider, context);
                  })
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _search(DataProvider dataProvider, BuildContext context) {
    final _searchedList = dataProvider.searchedCity;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 10),
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      style: TextStyle(foreground: Paint()..shader=utils.linearGradient),
                      decoration: InputDecoration(
                        labelText: "Search",
                        labelStyle: TextStyle(foreground: Paint()..shader=utils.linearGradient),                  
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 2.0,
                          ),
                        ),
                      ),
                      onChanged: (value) async {
                        if (value.isNotEmpty && value.length > 1) {
                          value = value.trim();
                          value.replaceAll(RegExp(r' '), '%');
                          setState(() {
                            isLoading = true;
                          });
                          int ret = await dataProvider.getCity(value);
                          setState(() {
                            isLoading = false;
                          });
                          if (ret==0) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "No Connection",
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 1),
                            ));
                          }
                        }
                      }),
                ),
                IconButton(
                    icon: Icon(Icons.close, size: 35,color:  Color(0xff0094EB),),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                      });
                      dataProvider.makeVoidSearchList();
                    })
              ],
            ),
          ),
          Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _searchedList.length==0?Center(child:Text("No data",style: TextStyle(foreground: Paint()..shader=utils.linearGradient),)):ListView.builder(
                      itemCount: _searchedList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.location_on,color:Color(0xff536DFE)),
                          title: Text(_searchedList[index].name,style: TextStyle(foreground: Paint()..shader=utils.linearGradient),),
                          subtitle: Text(
                              _searchedList[index].adminDistrict.toString() +
                                  "," +
                                  _searchedList[index].country.toString(),style: TextStyle(foreground: Paint()..shader=utils.linearGradient),),
                          trailing: IconButton(
                              icon: Icon(Icons.add,color: Color(0xff0094EB),),
                              onPressed: () {
                                dataProvider.addCity(_searchedList[index]);
                                setState(() {
                                  _isSearching = false;
                                });
                              }),
                        );
                      }))
        ],
      ),
    );
  }
}
