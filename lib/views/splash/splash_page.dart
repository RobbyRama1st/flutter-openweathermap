import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_test/views/splash/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/location.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashCubit _splashCubit;

   _initSplashScreen() async {
    Location location = Location();
    await location.getCurrentLocation();
    var duration = Duration(seconds: 2);
    return Timer(duration, _navigateToHomePage);
  }

  void _navigateToHomePage() {
    _splashCubit.goToHomePage(context);
  }

    @override
  void initState() {
    _splashCubit = BlocProvider.of<SplashCubit>(context);
    _initSplashScreen();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _splashCubit,
      child: BlocListener<SplashCubit, SplashState>(
        bloc: _splashCubit,
        listener: (context, state) {
          if(state is SplashGoHome){
            
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xff030317),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: LottieBuilder.asset('assets/images/weather.json'),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Powered by Openweathermap",  
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Assessment by Robby Ramadhan",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                    )
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}