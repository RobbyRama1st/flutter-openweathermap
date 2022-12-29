import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_test/routes/path.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> goToHomePage(BuildContext context) async {
    Future.delayed(Duration(seconds: 3), (){
      emit(SplashGoHomeState());
       Navigator.of(context).pushNamedAndRemoveUntil(homePageRoute, (Route<dynamic> route) => false);
    });
  }
}
