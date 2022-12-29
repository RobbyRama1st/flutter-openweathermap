
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/services/dio_interceptor.dart';
import 'package:weather_app_test/services/failure.dart';
import 'package:weather_app_test/models/weather_forecast.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app_test/services/interface/i_weather.dart';
import 'package:weather_app_test/utils/constant.dart';
import 'package:weather_app_test/utils/location.dart';

class WeatherService implements IWeather {
   final Dio _dio = Dio(
    BaseOptions (
      baseUrl: Constant.WEATHER_BASE_SCHEME + Constant.WEATHER_BASE_URL_DOMAIN,
      connectTimeout: 500 * 1000,
      receiveTimeout: 500 * 1000,
    ),
  );

  WeatherService() {
     _dio.interceptors.add(DioLogingInterceptors());
  }
  
  @override
  Future<Either<Failure, WeatherForecast>> fetchWeatherForecast({String? cityName, bool? isCity}) async {
    var logger = Logger();
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> qParams;

    if(cityName == true) {
      qParams = {
        'APPID': Constant.WEATHER_APP_ID,
        'units': 'metric',
        'q' : cityName
      };
    } else {
      qParams = {
        'APPID': Constant.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };
    }
    

    try {
      final response = await _dio.get(Constant.WEATHER_FORECAST_PATH, queryParameters: qParams);
      final data = weatherForecastFromJson(json.encode(response.data));

      return right(data);
    }  on DioError catch(err) {
      logger.e(err);
      return left(ServerError());
    } on SocketException catch(err) {
      logger.e(err);
      return left(ServerError());
    }
  }
  
}