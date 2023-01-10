
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/models/current_weather.dart';
import 'package:weather_app_test/models/list_weather.dart';
import 'package:weather_app_test/services/dio_interceptor.dart';
import 'package:weather_app_test/services/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app_test/services/interface/i_weather.dart';
import 'package:weather_app_test/utils/constant.dart';
import 'package:weather_app_test/utils/location.dart';

class WeatherService implements IWeather {
   var logger = Logger();
   final Dio _dio = Dio(
    BaseOptions (
      baseUrl: Constant.WEATHER_BASE_URL_DOMAIN,
      connectTimeout: 500 * 1000,
      receiveTimeout: 500 * 1000,
    ),
  );

  WeatherService() {
     _dio.interceptors.add(DioLogingInterceptors());
  }


  @override
  Future<Either<Failure, CurrentWeather>> fetchCurrentWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> qParams;

    qParams = {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'units': 'metric',
        'appid': Constant.WEATHER_APP_ID,
    };
    
    try{
      final response = await _dio.get(Constant.WEATHER_CURRENT_PATH, queryParameters: qParams);
      final data = currentWeatherFromJson(json.encode(response.data));

      return right(data);
    } on DioError catch(err) {
      logger.e(err);
      return left(ServerError());
    } on SocketException catch(err) {
      logger.e(err);
      return left(ServerError());
    }
  }

  @override
  Future<Either<Failure, ListWeather>> fetchHourlyWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> qParams;

    qParams = {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'units': 'metric',
        'appid': Constant.WEATHER_APP_ID,
    };

    try{
      final response = await _dio.get(Constant.WEATHER_DAILY_PATH, queryParameters: qParams);
      final data = listWeatherFromJson(json.encode(response.data));

      return right(data);
    } on DioError catch(err) {
      logger.e(err);
      return left(ServerError());
    } on SocketException catch(err) {
      logger.e(err);
      return left(ServerError());
    }
  }
  
  @override
  Future<Either<Failure, ListWeather>> fetchDailyWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> qParams;

    qParams = {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'units': 'metric',
        'appid': Constant.WEATHER_APP_ID,
    };

    try{
      final response = await _dio.get(Constant.WEATHER_DAILY_PATH, queryParameters: qParams);
      final data = listWeatherFromJson(json.encode(response.data));
      
      return right(data);
    } on DioError catch(err) {
      logger.e(err);
      return left(ServerError());
    } on SocketException catch(err) {
      logger.e(err);
      return left(ServerError());
    }
  }
  
}