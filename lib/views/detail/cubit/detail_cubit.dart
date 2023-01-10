import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:weather_app_test/models/list_weather.dart';
import 'package:weather_app_test/services/failure.dart';
import 'package:weather_app_test/services/interface/i_weather.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({required this.service}) : super(DetailInitialState());

    final IWeather service;
    var logger = Logger();

    Future<void> getSevenDaysWeather() async {
      emit(DetailLoadingState());

      Either<Failure, ListWeather> result = await service.fetchDailyWeather();

       emit(
        result.fold(
          (failure) {
            print("Failed from service");
            emit(DetailDisposeLoadingState());
            return DetailLoadSevenDaysFailedState();
          },
          (data) {
            print("Success from service");
            emit(DetailDisposeLoadingState());
            return DetailLoadSevenDaysSuccessState(
              value: data
            );
          }
        )
       );
    }
}
