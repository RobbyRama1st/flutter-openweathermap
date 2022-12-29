import 'package:intl/intl.dart';

class ForecastUtil {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d').format(dateTime); //Tue, May 5, 2022
  }

  static String findIcon(String name, bool type) {
    if (type) {
      switch (name) {
        case "Clouds":
          return "assets/icons/sunny.png";
        case "Rain":
          return "assets/icons/rainy.png";
        case "Drizzle":
          return "assets/icons/rainy.png";
        case "Thunderstorm":
          return "assets/icons/thunder.png";
        case "Snow":
          return "assets/icons/snow.png";
        default:
          return "assets/icons/sunny.png";
      }
    } else {
      switch (name) {
        case "Clouds":
          return "assets/icons/sunny_2d.png";
        case "Rain":
          return "assets/icons/rainy_2d.png";
        case "Drizzle":
          return "assets/icons/rainy_2d.png";
        case "Thunderstorm":
          return "assets/icons/thunder_2d.png";
        case "Snow":
          return "assets/icons/snow_2d.png";
        default:
          return "assets/icons/sunny_2d.png";
      }
    }
  }
}