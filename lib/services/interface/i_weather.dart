import 'package:dartz/dartz.dart';
import 'package:weather_app_test/models/weather_forecast.dart';
import 'package:weather_app_test/services/failure.dart';

abstract class IWeather {
  Future<Either<Failure, WeatherForecast>> fetchWeatherForecast({String? cityName, bool? isCity});
}