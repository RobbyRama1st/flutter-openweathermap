import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/routes/path.dart';
import 'package:weather_app_test/services/weather_service.dart';
import 'package:weather_app_test/utils/page_transition.dart';
import 'package:weather_app_test/views/home/cubit/home_cubit.dart';
import 'package:weather_app_test/views/home/home_page.dart';
import 'package:weather_app_test/views/maintenance_page.dart';
import 'package:weather_app_test/views/splash/cubit/splash_cubit.dart';
import 'package:weather_app_test/views/splash/splash_page.dart';

class Routes {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case splashPageRoute:
        return PageTransition(
          BlocProvider(
            create: (context) => SplashCubit(),
            child: SplashPage(),
          ),
        );
      
      case homePageRoute:
        return PageTransition(
          BlocProvider(
            create: (context) => HomeCubit(service: WeatherService()),
            child: HomePage(),
          )
        );

      default:
        return MaterialPageRoute(
          builder: (_) => SafeArea(
            child: MaintenancePage(),
          )
        );
    }
  }
}