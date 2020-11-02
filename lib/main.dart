import 'package:WeatherO/provider/data_provider.dart';
import 'package:WeatherO/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Database database = await openDatabase(
      join(await getDatabasesPath(), 'weathero.db'), onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      """CREATE TABLE city(id INTEGER PRIMARY KEY, name TEXT, adminDistrict TEXT,country TEXT,coordinates TEXT,timeZoneOffset INTEGER)""",
    );
  }, version: 1);
  await database.execute(
      "CREATE TABLE IF NOT EXISTS currentWeather(id INTEGER PRIMARY KEY,rain REAL,timestamp INTEGER,sunrise INTEGER,sunset INTEGER,temp REAL,feelsLike REAL,pressure INTEGER,humidity INTEGER,uvi REAL,clouds INTEGER,description TEXT,dewPoint REAL,visibility INTEGER,windDirection INTEGER,windSpeed REAL)");
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  final Database _db;
  MyApp(this._db);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => DataProvider(_db),
      child: MaterialApp(
        title: 'WeatherO',
        theme: ThemeData(
          canvasColor: Colors.white,
          fontFamily: "Lemonmilk",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}

///!UIFirst,!chatty,!ColorViewRootUtil,!SurfaceView
///Drawar
