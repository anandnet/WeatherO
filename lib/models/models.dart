class City{
  final int id;
  final String name;
  final String adminDistrict;
  final String country;
  final List<double> coordinates;
  City({this.name,this.adminDistrict,this.country,this.coordinates,this.id});
  Map<String, dynamic> toMap() {
    return {
      "id":id,
      'name': name,
      'adminDistrict': adminDistrict,
      'country': country,
      'coordinates':coordinates.toString(),
    };
  }
}

class CurrentWeather{
  final int cityId;
  final int timestamp;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final double pressure;
  final double humadity;
  final double dewPoint;
  final double uvi;
  final double clouds;
  final double visibility;
  final double windSpeed;
  final double windDirection;
  final double rain;
  final String description;
  CurrentWeather({this.cityId,this.rain,this.timestamp,this.sunrise,this.sunset,this.temp,this.feelsLike,this.pressure,this.humadity,this.uvi,this.clouds,this.description,this.dewPoint,this.visibility,this.windDirection,this.windSpeed});
  Map<String, dynamic> toMap() {
    return {
      "timestamp":timestamp,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': temp,
      'feelsLike':feelsLike,
      'pressure':pressure,
      'humadity':humadity,
      'dewPoint':dewPoint,
      'uvi':uvi,
      'clouds':clouds,
      'visibility':visibility,
      'windSpeed':windSpeed,
      'windDirection':windDirection,
      'description':description,
    };
  }
}


//CREATE TABLE ${id}_daily( minTemp REAL,nightFeelsLike REAL,nightTemp REAL,rain REAL,clouds REAL,dayFeelsLike REAL,dayTemp REAL,description TEXT,dewPoint REAL,humadity REAL,maxTemp REAL,timestamp REAL,sunrise REAL,sunset REAL,temp REAL,pressure REAL,uvi REAL,visibility REAL,windDirection REAL,windSpeed REAL)
class DailyWeather{
  final int timestamp;
  final int sunrise;
  final int sunset;
  final double temp;
  final double dayTemp;
  final double nightTemp;
  final double minTemp;
  final double maxTemp;
  final double dayFeelsLike;
  final double nightFeelsLike;
  final double pressure;
  final double humadity;
  final double dewPoint;
  final double uvi;
  final double clouds;
  final double visibility;
  final double windSpeed;
  final double rain;
  final double windDirection;
  final String description;
  DailyWeather({this. minTemp,this.nightFeelsLike,this.nightTemp,this.rain,this.clouds,this.dayFeelsLike,this.dayTemp,this.description,this.dewPoint,this.humadity,this.maxTemp,this.timestamp,this.sunrise,this.sunset,this.temp,this.pressure,this.uvi,this.visibility,this.windDirection,this.windSpeed});
  Map<String, dynamic> toMap() {
    return {
      "timestamp":timestamp,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': temp,
      'dayTemp':dayTemp,
      'nightTemp':nightTemp,
      'minTemp':minTemp,
      'maxTemp':maxTemp,
      'dayFeelsLike':dayFeelsLike,
      'nightFeelsLike':nightFeelsLike,
      'pressure':pressure,
      'humadity':humadity,
      'dewPoint':dewPoint,
      'uvi':uvi,
      'clouds':clouds,
      'visibility':visibility,
      'windSpeed':windSpeed,
      'rain':rain,
      'windDirection':windDirection,
      'description':description,
    };
  }
}

//CREATE TABLE ${id}_hourly(timestamp REAL,temp REAL,feelsLike REAL,pressure REAL,humadity REAL,clouds REAL,description TEXT,dewPoint REAL,visibility REAL,windDirection REAL,windSpeed REAL)
class HourlyWeather{
  final int timestamp;
  final double temp;
  final double feelsLike;
  final double pressure;
  final double humadity;
  final double dewPoint;
  final double clouds;
  final double visibility;
  final double windSpeed;
  final double windDirection;
  final String description;
  HourlyWeather({this.timestamp,this.temp,this.feelsLike,this.pressure,this.humadity,this.clouds,this.description,this.dewPoint,this.visibility,this.windDirection,this.windSpeed});
  Map<String, dynamic> toMap() {
    return {
      "timestamp":timestamp,
      'temp': temp,
      'feelsLike':feelsLike,
      'pressure':pressure,
      'humadity':humadity,
      'dewPoint':dewPoint,
      'clouds':clouds,
      'visibility':visibility,
      'windSpeed':windSpeed,
      'windDirection':windDirection,
      'description':description,
    };
  }
}