import 'dart:convert';

import 'package:weather_app_test/models/hourly.dart';
import 'package:weather_app_test/models/daily.dart';

ListWeather listWeatherFromJson(String str) => ListWeather.fromJson(json.decode(str));

String listWeatherToJson(ListWeather? data) => json.encode(data!.toJson());

class ListWeather {
    ListWeather({
        this.lat,
        this.lon,
        this.timezone,
        this.timezoneOffset,
        this.hourly,
        this.daily,
    });

    double? lat;
    double? lon;
    String? timezone;
    int? timezoneOffset;
    List<Hourly?>? hourly;
    List<Daily?>? daily;

    factory ListWeather.fromJson(Map<String, dynamic> json) => ListWeather(
        lat: json["lat"],
        lon: json["lon"],
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        hourly: json["hourly"] == null ? [] : json["hourly"] == null ? [] : List<Hourly?>.from(json["hourly"]!.map((x) => Hourly.fromJson(x))),
        daily: json["daily"] == null ? [] : json["daily"] == null ? [] : List<Daily?>.from(json["daily"]!.map((x) => Daily.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "hourly": hourly == null ? [] : hourly == null ? [] : List<dynamic>.from(hourly!.map((x) => x!.toJson())),
        "daily": daily == null ? [] : daily == null ? [] : List<dynamic>.from(daily!.map((x) => x!.toJson())),
    };
}
