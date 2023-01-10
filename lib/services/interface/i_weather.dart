import 'package:dartz/dartz.dart';
import 'package:weather_app_test/models/current_weather.dart';
import 'package:weather_app_test/models/list_weather.dart';
import 'package:weather_app_test/services/failure.dart';

abstract class IWeather {
  Future<Either<Failure, CurrentWeather>> fetchCurrentWeather();
  Future<Either<Failure, ListWeather>> fetchHourlyWeather();
  Future<Either<Failure, ListWeather>> fetchDailyWeather();
}