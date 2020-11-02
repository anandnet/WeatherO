import 'dart:convert';
import 'dart:io';
import 'package:WeatherO/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../tools/utils.dart' as utils;
import 'package:sqflite/sqflite.dart';
import 'package:location/location.dart';

class DataProvider extends ChangeNotifier {
  final Database _database;
  DataProvider(this._database);
  final Location location = Location();
  final String weatherApiKey = "";
  final String locationSearchApi = "";
  List<City> _cityList = [];
  List<City> _searchCity = [];
  bool _celcius = true;
  bool isInit = true;
  bool isCityAdded = false;
  Map<int, Map<String, dynamic>> _weather = {};
  GlobalKey<ScaffoldState> key;

  void init(GlobalKey<ScaffoldState> _key) async {
    //SharedPreferences.
    key = _key;
    if (isInit) {
      //print("[called] Init running...");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("cel")) {
        _celcius = prefs.getBool('cel');
      }
      if (prefs.containsKey("isCityAdded")) {
        isCityAdded = prefs.getBool("isCityAdded");
        notifyListeners();
      }
      _fetchCurrentLocation();
      final List<Map<String, dynamic>> maps0 = await _database.query('city');
      List<City> _city = List.generate(maps0.length, (i) {
        return City(
            timeZoneOffset: maps0[i]['timeZoneOffset'],
            temporary: false,
            id: maps0[i]['id'],
            name: maps0[i]['name'],
            adminDistrict: maps0[i]['adminDistrict'],
            country: maps0[i]['country'],
            coordinates: [
              json.decode(maps0[i]["coordinates"])[0],
              json.decode(maps0[i]["coordinates"])[1]
            ]);
      });
      _cityList = [..._city.reversed];
      //get currentweather
      final List<Map<String, dynamic>> maps =
          await _database.query('currentWeather');
      List<CurrentWeather> _curr = List.generate(maps.length, (i) {
        return CurrentWeather(
          id: maps[i]['id'],
          rain: maps[i]['rain'],
          timestamp: maps[i]['timestamp'].toInt(),
          clouds: maps[i]['clouds'],
          description: maps[i]['description'],
          dewPoint: maps[i]['dewPoint'],
          feelsLike: maps[i]['feelsLike'],
          humidity: maps[i]['humidity'],
          pressure: maps[i]['pressure'],
          sunrise: maps[i]['sunrise'],
          sunset: maps[i]['sunset'],
          temp: maps[i]['temp'],
          uvi: maps[i]['uvi'],
          visibility: maps[i]['visibility'],
          windDirection: maps[i]['windDirection'],
          windSpeed: maps[i]['windSpeed'],
        );
      });

      //get dailyWeather and hourlyWeather
      for (int j = 0; j < _cityList.length; j++) {
        final List<Map<String, dynamic>> maps1 =
            await _database.query('daily${_cityList[j].id}');
        final List<Map<String, dynamic>> maps2 =
            await _database.query('hourly${_cityList[j].id}');
        List<DailyWeather> _d = List.generate(
            maps1.length,
            (i) => DailyWeather(
                  rain: maps1[i]['rain'],
                  timestamp: maps1[i]['timestamp'],
                  clouds: maps1[i]['clouds'],
                  description: maps1[i]['description'],
                  dewPoint: maps1[i]['dewPoint'],
                  humidity: maps1[i]['humidity'],
                  pressure: maps1[i]['pressure'],
                  sunrise: maps1[i]['sunrise'],
                  sunset: maps1[i]['sunset'],
                  uvi: maps1[i]['uvi'],
                  visibility: maps1[i]['visibility'],
                  windDirection: maps1[i]['windDirection'],
                  windSpeed: maps1[i]['windSpeed'],
                  dayFeelsLike: maps1[i]['dayFeelsLike'],
                  dayTemp: maps1[i]['dayTemp'],
                  maxTemp: maps1[i]['maxTemp'],
                  minTemp: maps1[i]['minTemp'],
                  nightFeelsLike: maps1[i]['nightFeelsLike'],
                  nightTemp: maps1[i]['nightTemp'],
                ));
        List<HourlyWeather> _h = List.generate(
            maps1.length,
            (i) => HourlyWeather(
                  timestamp: maps2[i]['timestamp'],
                  clouds: maps2[i]['clouds'],
                  description: maps2[i]['description'],
                  dewPoint: maps2[i]['dewPoint'],
                  feelsLike: maps2[i]['feelsLike'],
                  humidity: maps2[i]['humidity'],
                  pressure: maps2[i]['pressure'],
                  temp: maps2[i]['temp'],
                  visibility: maps2[i]['visibility'],
                  windDirection: maps2[i]['windDirection'],
                  windSpeed: maps2[i]['windSpeed'],
                ));

        final CurrentWeather _a = (_curr != [])
            ? _curr[
                _curr.indexWhere((element) => element.id == _cityList[j].id)]
            : null;
        _weather[_cityList[j].id] = {
          "daily": _d,
          "current": _a,
          "hourly": _h,
        };
      }
      notifyListeners();
      // refresh instantly after loading data from database
      if (await checkConnectivity()) {
        refresh();
      } else {
        fetchCurrentWeatherFromLocal();
      }
    }
    isInit = false;
  }

  // ignore: missing_return
  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  get cities {
    return [..._cityList];
  }

  get temperatureUnit {
    return _celcius;
  }

  get searchedCity {
    return [..._searchCity];
  }

  get weather {
    return _weather;
  }

  Future<void> refresh() async {
    if (await checkConnectivity()) {
      _cityList.forEach((element) {
        (element.temporary)
            ? _fetchWeather(element, false, true)
            : _fetchWeather(element, false, false);
      });
    } else {
      key.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "No Connection !",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> _fetchCurrentLocation() async {
    if (!await location.serviceEnabled()) {
      await location.requestService();
    }
    if (await location.serviceEnabled()) {
      LocationData _loc = await location.getLocation();
      if (await checkConnectivity()) {
        try {
          final x = await http.get(
              "http://dev.virtualearth.net/REST/v1/Locations/${_loc.latitude},${_loc.longitude}?includeEntityTypes=Postcode1&include={includeValue}&key=$locationSearchApi");
          if (x.statusCode == 200) {
            final body = json.decode(x.body)["resourceSets"][0]['resources'][0];
            final currentCity = City(
                temporary: true,
                id: DateTime.now().millisecondsSinceEpoch,
                name: (body['name']).trim().split(',')[0],
                coordinates: [_loc.latitude, _loc.longitude],
                adminDistrict: body['address']['adminDistrict'],
                country: body['address']['countryRegion']);
            await _fetchWeather(currentCity, false, true);
            _cityList.insert(0, currentCity);
            notifyListeners();
          }
        } catch (e) {}
      }
    }
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
          if (_str[i] != _str[0]) temp = temp + "," + _str[i];
        }
        return temp;
      }
    } else {
      return cityName;
    }
  }

  // ignore: missing_return
  Future<int> getCity(String inputText) async {
    List<City> _tempCityList1 = [];
    if (await checkConnectivity()) {
      try {
        var x = await http.get(
            "http://dev.virtualearth.net/REST/v1/Locations/$inputText?o=json&maxResults=4&key=$locationSearchApi");

        if (x.statusCode == 200) {
          var json = jsonDecode(x.body);
          var _citylst = json["resourceSets"][0]["resources"];

          for (int i = 0; i < _citylst.length; i++) {
            _tempCityList1.add(City(
                temporary: false,
                id: DateTime.now().millisecondsSinceEpoch,
                name: _getCityName(
                    _citylst[i]["name"],
                    _citylst[i]["address"]["countryRegion"],
                    _citylst[i]["address"]["adminDistrict"]),
                adminDistrict:
                    (_citylst[i]["address"]["adminDistrict"]).toString(),
                country: (_citylst[i]["address"]["countryRegion"]).toString(),
                coordinates: [
                  utils.toDouble(_citylst[i]["point"]["coordinates"][0]),
                  utils.toDouble(_citylst[i]["point"]["coordinates"][1])
                ]));
          }
          _searchCity = [..._tempCityList1];
          notifyListeners();
          return 1;
        }
      } catch (e) {
        print(e);
        return 2;
      }
    } else {
      return 0;
    }
  }

  void makeVoidSearchList() {
    _searchCity = [];
    notifyListeners();
  }

  void reorderCityList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final City cityItem = _cityList.removeAt(oldIndex);
    _cityList.insert(newIndex, cityItem);
    notifyListeners();
  }

  Future<void> changeTempUnit(int x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (x == 0) {
      prefs.setBool("cel", true);
      _celcius = true;
    } else {
      prefs.setBool("cel", false);
      _celcius = false;
    }
    notifyListeners();
  }

  void addCity(City city) async {
    //print("[called] addCity running...");

    await _database.execute(
        "CREATE TABLE hourly${city.id}(timestamp INTEGER,temp REAL,feelsLike REAL,pressure INTEGER,humidity INTEGER,clouds INTEGER,description TEXT,dewPoint REAL,visibility INTEGER,windDirection INTEGER,windSpeed REAL)");
    await _database.execute(
        "CREATE TABLE daily${city.id}( minTemp REAL,nightFeelsLike REAL,nightTemp REAL,rain REAL,clouds INTEGER,dayFeelsLike REAL,dayTemp REAL,description TEXT,dewPoint REAL,humidity INTEGER,maxTemp REAL,timestamp INTEGER,sunrise INTEGER,sunset INTEGER,pressure INTEGER,uvi REAL,visibility INTEGER,windDirection INTEGER,windSpeed REAL)");
    makeVoidSearchList();
    _cityList.add(city);
    await _fetchWeather(city, true, false);
    await _database.insert(
      'city',
      city.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isCityAdded", true);
    isCityAdded = true;
    notifyListeners();
  }

  void removeCity(City city) async {
    //print("[called] removeCity running...");
    await _database.delete(
      'city',
      where: "id = ?",
      whereArgs: [city.id],
    );
    await _database
        .delete('currentWeather', where: 'id=?', whereArgs: [city.id]);
    await _database.execute("DROP TABLE IF EXISTS hourly${city.id}");
    await _database.execute("DROP TABLE IF EXISTS daily${city.id}");
    _cityList.remove(city);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_cityList.any((element) => element.temporary == false)) {
      prefs.setBool("isCityAdded", true);
      isCityAdded = true;
    } else {
      prefs.setBool("isCityAdded", false);
      isCityAdded = false;
    }
    notifyListeners();
  }

  Future<int> _fetchWeather(City city, bool firstTime, bool temporary) async {
    //print("[called] fetchWeather running...");
    try {
      final x = await http.get(
          "https://api.openweathermap.org/data/2.5/onecall?lat=${city.coordinates[0]}&lon=${city.coordinates[1]}&exclude=minutely&appid=$weatherApiKey");
      if (x.statusCode == 200) {
        var json = jsonDecode(x.body);

        if (!firstTime && !temporary) {
          await _database.execute("DELETE FROM daily${city.id}");
          await _database.execute("DELETE FROM hourly${city.id}");
          await _database.execute("VACUUM");
        }
        if (city.temporary) {
          city.timeZoneOffset = DateTime.now().timeZoneOffset.inSeconds;
        } else {
          city.timeZoneOffset = json["timezone_offset"] != null
              ? (json["timezone_offset"])
              : DateTime.now().timeZoneOffset.inSeconds;
        }

        final CurrentWeather current = await _getCurrentWeather(
            json["current"], city.id, firstTime, temporary, false);
        final List<DailyWeather> daily =
            await _getDailyWeather(json['daily'], city.id, temporary);
        final List<HourlyWeather> hourly =
            await _getHourlyWeather(json['hourly'], city.id, temporary);
        _weather[city.id] = {
          "daily": daily,
          "current": current,
          "hourly": hourly,
        };
        notifyListeners();
      }
      return x.statusCode;
    } catch (e) {}
    return 1;
  }

  Future<CurrentWeather> _getCurrentWeather(dynamic current, int id,
      bool firstTime, bool temporary, bool local) async {
    CurrentWeather _cw = CurrentWeather(
      id: id,
      sunrise: current["sunrise"],
      sunset: current["sunset"],
      temp: utils.toDouble(current['temp']),
      feelsLike:
          local ? current["feelsLike"] : utils.toDouble(current['feels_like']),
      timestamp: local ? current['timestamp'] : current['dt'],
      clouds: current['clouds'],
      description:
          local ? current['description'] : current['weather'][0]['description'],
      dewPoint:
          local ? current['dewPoint'] : utils.toDouble(current['dew_point']),
      humidity: current['humidity'],
      pressure: current['pressure'],
      rain: utils.toDouble(current['rain']),
      uvi: utils.toDouble(current['uvi']),
      visibility: current['visibility'],
      windDirection: local ? current['windDirection'] : current["wind_deg"],
      windSpeed:
          local ? current['windSpeed'] : utils.toDouble(current['wind_speed']),
    );
    if (!temporary) {
      if (firstTime) {
        await _database.insert(
          'currentWeather',
          _cw.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        await _database.update(
          'currentWeather',
          _cw.toMap(),
          where: 'id=?',
          whereArgs: [id],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    if (local) {
      _weather[id]['current'] = _cw;
      notifyListeners();
    }
    //print("updated");
    return _cw;
  }

  Future<List<DailyWeather>> _getDailyWeather(
      dynamic dWeather, int id, bool temporary) async {
    List<DailyWeather> _dw = [];
    for (int i = 0; i < dWeather.length; i++) {
      DailyWeather _dwtemp = DailyWeather(
        timestamp: dWeather[i]['dt'],
        clouds: dWeather[i]['clouds'],
        dayFeelsLike: utils.toDouble(dWeather[i]['feels_like']['day']),
        dayTemp: utils.toDouble(dWeather[i]['temp']['day']),
        description: dWeather[i]['weather'][0]['description'],
        dewPoint: utils.toDouble(dWeather[i]['dew_point']),
        humidity: dWeather[i]['humidity'],
        maxTemp: utils.toDouble(dWeather[i]['temp']['max']),
        minTemp: utils.toDouble(dWeather[i]['temp']['min']),
        nightFeelsLike: utils.toDouble(dWeather[i]['feels_like']['night']),
        nightTemp: utils.toDouble(dWeather[i]['temp']['night']),
        pressure: dWeather[i]['pressure'],
        rain: utils.toDouble(dWeather[i]['rain']),
        sunrise: dWeather[i]['sunrise'],
        sunset: dWeather[i]['sunset'],
        uvi: utils.toDouble(dWeather[i]['uvi']),
        visibility: dWeather[i]['visibility'],
        windDirection: dWeather[i]['wind_deg'],
        windSpeed: utils.toDouble(dWeather[i]['wind_speed']),
      );
      if (!temporary) {
        await _database.insert(
          'daily$id',
          _dwtemp.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      _dw.add(_dwtemp);
    }
    return [..._dw];
  }

  Future<List<HourlyWeather>> _getHourlyWeather(
      dynamic hWeather, int id, bool temporary) async {
    List<HourlyWeather> _hw = [];
    for (int i = 0; i < hWeather.length; i++) {
      HourlyWeather _hwtemp = HourlyWeather(
        timestamp: hWeather[i]['dt'],
        temp: utils.toDouble(hWeather[i]['temp']),
        clouds: hWeather[i]['clouds'],
        description: hWeather[i]['weather'][0]['description'],
        dewPoint: utils.toDouble(hWeather[i]['dew_point']),
        humidity: hWeather[i]['humidity'],
        pressure: hWeather[i]['pressure'],
        visibility: hWeather[i]['visibility'],
        windDirection: hWeather[i]['wind_deg'],
        windSpeed: utils.toDouble(hWeather[i]['wind_speed']),
        feelsLike: utils.toDouble(hWeather[i]['feels_like']),
      );
      if (!temporary) {
        await _database.insert(
          'hourly$id',
          _hwtemp.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      _hw.add(_hwtemp);
    }
    return [..._hw];
  }

  //No internet case
  void fetchCurrentWeatherFromLocal() {
    //print("Local Running");
    for (int i = 0; i < _cityList.length; i++) {
      final List<HourlyWeather> _wh = _weather[_cityList[i].id]["hourly"];
      try {
        final HourlyWeather _hr = _wh.firstWhere((element) {
          return utils.compareDateTime(element.timestamp);
        });
        _getCurrentWeather(
            _hr.toMap(), _cityList[i].id, false, _cityList[i].temporary, true);
      } catch (e) {}
    }
  }
}
