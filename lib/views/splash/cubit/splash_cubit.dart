import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/models/current_weather.dart';
import 'package:weather_app_test/routes/path.dart';
import 'package:weather_app_test/services/failure.dart';
import 'package:weather_app_test/services/interface/i_weather.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.service}) : super(SplashInitial());

  final IWeather service;
  var logger = Logger();  

  Future<void> goToHomePage(BuildContext context) async {
    Future.delayed(Duration(seconds: 3), (){
      emit(SplashGoHome());
       Navigator.of(context).pushNamedAndRemoveUntil(homePageRoute, (Route<dynamic> route) => false);
    });
  }

  Future<void> getCurrentWeather() async {
      Either<Failure, CurrentWeather> result = await service.fetchCurrentWeather();
      emit(
        result.fold(
          (failure) {
            print("Failed from service");
            return SplashLoadFailed();
          },
          (data) {
            print("Success from service");
            return SplashLoadSuccess(
              value: data
            );
          }
        )
      );
    }
}
