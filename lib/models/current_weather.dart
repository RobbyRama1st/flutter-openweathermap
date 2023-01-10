import 'dart:convert';

import 'package:weather_app_test/models/clouds.dart';
import 'package:weather_app_test/models/coord.dart';
import 'package:weather_app_test/models/sys.dart';
import 'package:weather_app_test/models/weather.dart';
import 'package:weather_app_test/models/wind.dart';

CurrentWeather currentWeatherFromJson(String str) => CurrentWeather.fromJson(json.decode(str));

String currentWeatherToJson(CurrentWeather data) => json.encode(data.toJson());

class CurrentWeather {
    Coord? coord;
    List<Weather>? weather;
    String? base;
    Main? main;
    int? visibility;
    Wind? wind;
    Clouds? clouds;
    int? dt;
    Sys? sys;
    int? timezone;
    int? id;
    String? name;
    int? cod;

  CurrentWeather(
      {this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod,});

    factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        base: json["base"] == null ? null : json["base"],
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        visibility: json["visibility"] == null ? null : json["visibility"],
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        dt: json["dt"] == null ? null : json["dt"],
        sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
        timezone: json["timezone"] == null ? null : json["timezone"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        cod: json["cod"] == null ? null : json["cod"],
    );

  Map<String, dynamic> toJson() => {
        "coord": coord == null ? null : coord?.toJson(),
        "weather": weather == null ? null : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "base": base == null ? null : base,
        "main": main == null ? null : main?.toJson(),
        "visibility": visibility == null ? null : visibility,
        "wind": wind == null ? null : wind?.toJson(),
        "clouds": clouds == null ? null : clouds?.toJson(),
        "dt": dt == null ? null : dt,
        "sys": sys == null ? null : sys?.toJson(),
        "timezone": timezone == null ? null : timezone,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "cod": cod == null ? null : cod,
  };

  // String getIconUrl() {
  //   return Constants.WEATHER_IMAGES_URL + weather![0].icon! + '.png';
  // }
}

class Main {
    Main({
        this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity,
        this.seaLevel,
        this.grndLevel,
    });

    double? temp;
    double? feelsLike;
    double? tempMin;
    double? tempMax;
    int? pressure;
    int? humidity;
    int? seaLevel;
    int? grndLevel;

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"] == null ? null : json["temp"].toDouble(),
        feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
        tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
        tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
        pressure: json["pressure"] == null ? null : json["pressure"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        seaLevel: json["sea_level"] == null ? null : json["sea_level"],
        grndLevel: json["grnd_level"] == null ? null : json["grnd_level"],
    );

    Map<String, dynamic> toJson() => {
        "temp": temp == null ? null : temp,
        "feels_like": feelsLike == null ? null : feelsLike,
        "temp_min": tempMin == null ? null : tempMin,
        "temp_max": tempMax == null ? null : tempMax,
        "pressure": pressure == null ? null : pressure,
        "humidity": humidity == null ? null : humidity,
        "sea_level": seaLevel == null ? null : seaLevel,
        "grnd_level": grndLevel == null ? null : grndLevel,
    };
}