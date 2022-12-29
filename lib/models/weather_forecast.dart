import 'dart:convert';

import 'package:weather_app_test/models/city.dart';
import 'package:weather_app_test/models/weather_list.dart';

WeatherForecast weatherForecastFromJson(String str) => WeatherForecast.fromJson(json.decode(str));

String weatherForecastToJson(WeatherForecast data) => json.encode(data.toJson());

class WeatherForecast {
  City? city;
  String? cod;
  double? message;
  int? cnt;
  List<WheatherList>? list;

  WeatherForecast({this.city, this.cod, this.message, this.cnt, this.list});

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <WheatherList>[];
      json['list'].forEach((v) {
        list!.add(WheatherList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
