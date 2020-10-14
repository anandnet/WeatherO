import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Database database = await openDatabase(
      join(await getDatabasesPath(), 'weathero.db'), onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      """CREATE TABLE city(id INTEGER PRIMARY KEY, name TEXT, adminDistrict TEXT,country TEXT,coordinates TEXT)""",
    );
  }, version: 1);
  await database.execute("CREATE TABLE currentWeather(cityId INTEGER PRIMARY KEY, cityId REAL,rain REAL,timestamp REAL,sunrise REAL,sunset REAL,temp REAL,feelsLike REAL,pressure REAL,humadity REAL,uvi REAL,clouds REAL,description TEXT,dewPoint REAL,visibility REAL,windDirection REAL,windSpeed REAL)");
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  final Database _db;
  MyApp(this._db);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(_db),
      child: MaterialApp(
        title: 'WeatherO',
        theme: ThemeData(
          fontFamily: "Lemonmilk",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}

///!E/UIFirst,!I/chatty,!D/ColorViewRootUtil(29813)
/////
