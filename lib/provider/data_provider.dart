import 'dart:convert';
import 'package:WeatherO/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class DataProvider extends ChangeNotifier {
  final Database _database;
  DataProvider(this._database);
  final String weatherApiKey="";
  final String locationSearchApi="";
  List<City> _cityList = [];
  List<City> _searchCity = [];

  void init()async{
    final List<Map<String, dynamic>> maps = await _database.query('city');
    List<City> _city= List.generate(maps.length, (i) {
    return City(
      id: maps[i]['id'],
      name: maps[i]['name'],
      adminDistrict: maps[i]['adminDistrict'],
      country:maps[i]['country'],
      coordinates:[json.decode( maps[i]["coordinates"])[0],json.decode( maps[i]["coordinates"])[1]]
    );
  });
  _cityList=[..._city.reversed];
  notifyListeners();
  }

  get cities {
    return [..._cityList];
  }

  get searchedCity {
    return [..._searchCity];
  }

  String _getCityName(
      String cityName, String countryName, String adminDistrict) {
    List<String> _str = cityName.split(",").map((e) => e.trim()).toList();
    if (_str.length >= 2) {
      if (_str.contains(countryName.trim())) {
        _str.remove(countryName.trim());
      }
      if (adminDistrict != null) {
        if (_str.contains(adminDistrict.trim())) {
          _str.remove(adminDistrict.trim());
        }
      }
      if (_str.length == 1) {
        return _str[0];
      } else {
        String temp = _str[0];
        for (int i = 1; i < _str.length; i++) {
          temp = temp + "," + _str[i];
        }
        return temp;
      }
    } else {
      return cityName;
    }
  }

  Future<void> getCity(String inputText) async {
    List<City> _tempCityList1 = [];
    var x = await http.get(
        "http://dev.virtualearth.net/REST/v1/Locations/$inputText?o=json&maxResults=4&key=$locationSearchApi");
    var json = jsonDecode(x.body);
    var _citylst = json["resourceSets"][0]["resources"];

    for (int i = 0; i < _citylst.length; i++) {
      print(_citylst[i]["adminDistrict"]);
      _tempCityList1.add(City(
          id:DateTime.now().millisecondsSinceEpoch,
          name: _getCityName(
              _citylst[i]["name"],
              _citylst[i]["address"]["countryRegion"],
              _citylst[i]["address"]["adminDistrict"]),
          adminDistrict: (_citylst[i]["address"]["adminDistrict"]).toString(),
          country: (_citylst[i]["address"]["countryRegion"]).toString(),
          coordinates: [
            _citylst[i]["point"]["coordinates"][0],
            _citylst[i]["point"]["coordinates"][1]
          ]));
    }
    _searchCity = [..._tempCityList1];
    notifyListeners();
  }

  void makeVoidSearchList() {
    _searchCity = [];
    notifyListeners();
  }

  void reorderCityList(int oldIndex,int newIndex){
    if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final City cityItem = _cityList.removeAt(oldIndex);
        _cityList.insert(newIndex, cityItem);
        notifyListeners();
  }

  void addCity(City city) async{
    _cityList.add(city);
    await _database.insert(
    'city',
    city.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  //
  await _database.execute("CREATE TABLE ${city.id}_hourly(timestamp REAL,temp REAL,feelsLike REAL,pressure REAL,humadity REAL,clouds REAL,description TEXT,dewPoint REAL,visibility REAL,windDirection REAL,windSpeed REAL)");
  await _database.execute("CREATE TABLE ${city.id}_daily( minTemp REAL,nightFeelsLike REAL,nightTemp REAL,rain REAL,clouds REAL,dayFeelsLike REAL,dayTemp REAL,description TEXT,dewPoint REAL,humadity REAL,maxTemp REAL,timestamp REAL,sunrise REAL,sunset REAL,temp REAL,pressure REAL,uvi REAL,visibility REAL,windDirection REAL,windSpeed REAL)");
    makeVoidSearchList();
    //fetchWeather(city);
    notifyListeners();
  }

  void removeCity(City city)async {
    await _database.delete(
    'city',
    where: "id = ?",
    whereArgs: [city.id],
  );
    _cityList.remove(city);
    notifyListeners();
  }

  Future<void> fetchWeather(City city) async {
    final x=await http.get("https://api.openweathermap.org/data/2.5/onecall?lat=${city.coordinates[0]}&lon=${city.coordinates[1]}&exclude=minutely&appid=$weatherApiKey");
    var json =jsonDecode(x.body);
    print("${json["current"]}\n${_currentTime(json["current"]["dt"])}");
  }

  DateTime _currentTime(int secondEpoch) {
      DateTime x = DateTime.fromMillisecondsSinceEpoch(secondEpoch * 1000,
          isUtc: true);
      DateTime currentTimeZone = x.add(Duration(hours: 5, minutes: 30));
      print("count=$currentTimeZone");
      return currentTimeZone;
    }
  
}
