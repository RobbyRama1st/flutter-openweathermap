import 'package:intl/intl.dart';

class ForecastUtil {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d').format(dateTime); //Tue, May 5, 2022
  }

  static String findIcon(String name) {
    switch (name) {
        case "Clouds":
          return "assets/images/sunny.png";
        case "Rain":
          return "assets/images/rainy.png";
        case "Drizzle":
          return "assets/images/rainy.png";
        case "Thunderstorm":
          return "assets/images/thunder.png";
        case "Snow":
          return "assets/images/snow.png";
        default:
          return "assets/images/sunny.png";
      }
  }

  static String findMonth(int month){
    switch (month) {
      case 1:
       return "January";
      case 2:
        return "February";
      case 3: 
        return "March";
      case 4: 
        return "April";
      case 5:
        return "May";
      case 6: 
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9: 
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      default:
        return "December";
    }
  }
}