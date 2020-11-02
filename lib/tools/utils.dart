import 'package:flutter/material.dart';

final List<String> weekDays = [
  "NA",
  "MON",
  "TUE",
  "WED",
  "THU",
  "FRI",
  "SAT",
  "SUN"
];
final List<String> months = [
  'NA',
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
];
final Map<String, String> iconMap = {
//Thender
  "thunderstorm with light rain": "17",
  "thunderstorm with rain": "15",
  "thunderstorm with heavy rain": "15",
  "light thunderstorm": "14",
  "thunderstorm": "14",
  "heavy thunderstorm": "14",
  "ragged thunderstorm": "14",
  "thunderstorm with light drizzle": "17",
  "thunderstorm with drizzle": "17",
  "thunderstorm with heavy drizzle": "17",

//Drizzle
  "light intensity drizzle": "3",
  "drizzle": "3",
  "heavy intensity drizzle": "3",
  "light intensity drizzle rain": "3",
  "drizzle rain": "3",
  "heavy intensity drizzle rain": "3",
  "shower rain and drizzle": "3",
  "heavy shower rain and drizzle": "3",
  "shower drizzle": "3",

//Rain
  "light rain": "10",
  "moderate rain": "10",
  "heavy intensity rain": "6",
  "very heavy rain": "6",
  "extreme rain": "6",
  "freezing rain": "10",
  "light intensity shower rain": "3",
  "shower rain": "3",
  "heavy intensity shower rain": "3",
  "ragged shower rain": "3",
//Snow
  "light snow": "11",
  "snow": "11",
  "heavy snow": "7",
  "sleet": "12",
  "light shower sleet": "12",
  "shower sleet": "12",
  "light rain and snow": "12",
  "rain and snow": "12",
  "light shower snow": "12",
  "shower snow": "12",
  "heavy shower snow": "12",

//smoke category
  "mist": "8",
  "haze_day": "5",
  "haze_night": "4",
  "smoke": "8",
  "dust": "8",
  "sand/ dust whirls": "8",
  "sand": "8",
  "fog": "8",
  "volcanic ash": "8",
  "squalls": "8",
  "tornado": "16",
  "clear sky_day": "13",
  "clear sky_night": "9",
//clouds
  "few clouds_day": "2",
  "scattered clouds_day": "2",
  "broken clouds_day": "2",
  "overcast clouds_day": "2",
  "few clouds_night": "1",
  "scattered clouds_night": "1",
  "broken clouds_night": "1",
  "overcast clouds_night": "1",
};

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color(0xff536DFE),
    Color(0xff0094EB),
  ],
).createShader(Rect.fromLTWH(0.0, 0.0, 90.0, 70.0));
DateTime currentTime(int secondEpoch) {
  final DateTime x = DateTime.fromMillisecondsSinceEpoch(secondEpoch * 1000,isUtc: true).toLocal();
  return x;
}

double toDouble(dynamic x) {
  return double.tryParse(x.toString());
}

int toCelcius(double kel, bool cel) {
  if (cel) {
    return (kel - 273.15).toInt();
  } else {
    return (((kel - 273.15) * 9 / 5) + 32).toInt();
  }
}

bool compareDateTime(int epoch) {
  final DateTime dt = currentTime(epoch);
  final DateTime now = DateTime.now();
  if (dt.month == now.month &&
      dt.year == now.year &&
      dt.day == now.day &&
      dt.hour == now.hour) {
    return true;
  } else {
    return false;
  }
}

String iconName(String description, int secondEpoch,int offset) {
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(secondEpoch * 1000,isUtc: true).add(Duration(seconds: offset));
  final String x = description.trim().toLowerCase();

  if (x == ("clear sky")) {
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      return iconMap["clear sky_day"];
    } else {
      return iconMap["clear sky_night"];
    }
  } else if (x.contains("clouds")) {
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      return iconMap["${x}_day"];
    } else {
      return iconMap["${x}_night"];
    }
  } else if (x.contains("haze")) {
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      return iconMap["${x}_day"];
    } else {
      return iconMap["${x}_night"];
    }
  } else {
    return iconMap[x];
  }
}
