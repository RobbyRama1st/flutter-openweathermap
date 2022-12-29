import 'package:flutter/material.dart';
import 'package:weather_app_test/routes/path.dart';
import 'package:weather_app_test/routes/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: splashPageRoute,
      onGenerateRoute: Routes().onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.deepOrangeAccent,
        error: Colors.red,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlueAccent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      ),
    );
  }
}