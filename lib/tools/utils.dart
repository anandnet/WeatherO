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
DateTime currentTime(int secondEpoch) {
  DateTime x =
      DateTime.fromMillisecondsSinceEpoch(secondEpoch * 1000, isUtc: true)
          .toLocal();
  //DateTime currentTimeZone = x.add(Duration(hours: 5, minutes: 30));
  //print("count=$currentTimeZone");
  return x;
}

double toDouble(dynamic x) {
  return double.tryParse(x.toString());
}

int toCelcius(double kel) {
  return (kel - 273.15).toInt();
}

String iconName(String description, int secondEpoch) {
  final DateTime dateTime = currentTime(secondEpoch);
  final List x = description.trim().split(" ");
  if (x.contains("clouds")) {
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      return "cloudy_sun";
    } else {
      return "cloudy_moon";
    }
  } else if (x.contains("rain")) {
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      return "rain";
    } else {
      return "rain";
    }
  } else if (x.contains("sky")) {
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      return "sun";
    } else {
      return "moon";
    }
  } else if (x.contains("haze")) {
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      return "haze_sun";
    } else {
      return "haze_moon";
    }
  } else {
    return "mist";
  }
}
