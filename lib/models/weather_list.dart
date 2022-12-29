import 'package:weather_app_test/models/temperature.dart';
import 'package:weather_app_test/models/time.dart';
import 'package:weather_app_test/models/weather.dart';
import 'package:weather_app_test/utils/constant.dart';

class WheatherList {
  int? dt;
  int? sunrise;
  int? sunset;
  Temperature? temp;
  Times? times;
  int? pressure;
  int? humidity;
  List<Weather>? weather;
  double? speed;
  int? deg;
  num? gust;
  int? clouds;
  double? pop;
  num? rain;

  WheatherList(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.times,
      this.pressure,
      this.humidity,
      this.weather,
      this.speed,
      this.deg,
      this.gust,
      this.clouds,
      this.pop,
      this.rain});

  WheatherList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'] != null ? Temperature.fromJson(json['temp']) : null;
    times = json['feels_like'] != null
        ? Times.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
    clouds = json['clouds'];
    pop = json['pop'].toDouble();
    rain = json['rain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    if (temp != null) {
      data['temp'] = temp!.toJson();
    }
    if (times != null) {
      data['feels_like'] = times!.toJson();
    }
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    data['clouds'] = clouds;
    data['pop'] = pop;
    data['rain'] = rain;
    return data;
  }

  String getIconUrl() {
    return Constant.WEATHER_IMAGES_URL + weather![0].icon! + '.png';
  }
}