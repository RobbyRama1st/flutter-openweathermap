import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/models/hourly.dart';
import 'package:weather_app_test/models/current_weather.dart';
import 'package:weather_app_test/models/list_weather.dart';
import 'package:weather_app_test/services/failure.dart';
import 'package:weather_app_test/services/interface/i_weather.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
    HomeCubit({required this.service}) : super(HomeInitialState());

    final IWeather service;
    var logger = Logger();

    void pushToPage({required Widget pageBuilder, required BuildContext context}) {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => pageBuilder,
      ));
    }

    Future<void> getCurrentWeather() async {
      emit(HomeLoadingState());

      Either<Failure, CurrentWeather> result = await service.fetchCurrentWeather();
      emit(
        result.fold(
          (failure) {
            print("Failed from service");
          
            return HomeLoadCurrentFailedState();
          },
          (data) {
            print("Success from service");
            return HomeLoadCurrentSuccessState(
              value: data
            );
          }
        )
      );
    }

    Future<void> getHourlyWeather() async {
       Either<Failure, ListWeather> result = await service.fetchHourlyWeather();
        emit(
        result.fold(
          (failure) {
            print("Failed from service");
            emit(HomeDisposeLoadingState());
            return HomeLoadHourlyFailedState();
          },
          (data) {
            print("Success from service");
            emit(HomeDisposeLoadingState());
            return HomeLoadHourlySuccessState(
              value: data
            );
          }
        )
      );
    }
}
