import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/models/weather_forecast.dart';
import 'package:weather_app_test/services/failure.dart';
import 'package:weather_app_test/services/interface/i_weather.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
    HomeCubit({required this.service}) : super(HomePageInitial());

    final IWeather service;
    var logger = Logger();

    void pushToPage({required Widget pageBuilder, required BuildContext context}) {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => pageBuilder,
      ));
    }

    Future<void> getWeatherForecast({String? cityName, bool? isCity}) async { 
      Either<Failure, WeatherForecast> result = await service.fetchWeatherForecast(cityName: cityName!, isCity: isCity);
    
      emit(
        result.fold(
          (failure) {
            return HomePageLoadFailed();
          },
          (data) {
            return HomePageLoadSuccess(
              value: data
            );
          }
        )
      );
    }
}
