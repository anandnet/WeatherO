import 'dart:convert';
import 'package:WeatherO/provider/data_provider.dart';
import 'package:provider/provider.dart';

import "../models/models.dart";
import 'package:WeatherO/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ManageCity extends StatefulWidget {
  @override
  _ManageCityState createState() => _ManageCityState();
}

class _ManageCityState extends State<ManageCity> {
  //List<City> _cityList= [];
  bool _isSearching = false;
  final _globalKey = GlobalKey<ScaffoldState>();
  bool isLoading =false;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    List<City> _cityList = dataProvider.cities;
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                          _globalKey.currentState.openDrawer();
                        },
                        child: Icon(
                          Icons.short_text,
                          size: 40,
                        ),
                      ),
                      Text(
                        "Manage City",
                        style: TextStyle(fontSize: 20),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                          child: Icon(Icons.add, size: 30))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                top: 20,
              ),
                  child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      dataProvider.reorderCityList(oldIndex, newIndex);
                    },
                    children: _cityList.map((x) {
                      return Container(
                        key: ValueKey(x.name),
                        //height: size.aspectRatio*200,
                        //color: Colors.black45,
                        child: Card(
                          shadowColor: Color(0xff536DFE),
                          elevation: 6,
                          child: ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(x.name),
                            subtitle: Text(x.adminDistrict.toString()+","+x.country.toString()),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: () {
                                  dataProvider.removeCity(x);
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
          _isSearching ? _search(dataProvider) : Container(),
        ],
      ),
    );
  }
List<City> _tempCityList=[];
  Widget _search(DataProvider dataProvider) {
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
                      decoration: InputDecoration(
                        labelText: "Search",
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
                      onChanged: (value) async{
                        if (value.isNotEmpty && value.length>1) {
                          print(value);
                          dataProvider.getCity(value);
                        }
                      }),
                ),
                IconButton(
                    icon: Icon(Icons.close, size: 35),
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
              child: isLoading?Center(child: CircularProgressIndicator(),): ListView.builder(
                  itemCount: _searchedList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(_searchedList[index].name),
                      subtitle: Text(_searchedList[index].adminDistrict.toString() +","+_searchedList[index].country.toString()),
                      trailing:
                          IconButton(icon: Icon(Icons.add), onPressed: () {
                            print("hello");
                            dataProvider.addCity(_searchedList[index]);
                            setState(() {
                              _isSearching=false;
                            });
                          }),
                    );
                  }))
        ],
      ),
    );
  }
}
