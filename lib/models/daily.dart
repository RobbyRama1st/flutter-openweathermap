import 'package:weather_app_test/models/feels_like.dart';
import 'package:weather_app_test/models/temp.dart';
import 'package:weather_app_test/models/weather.dart';

class Daily {
    Daily({
        this.dt,
        this.sunrise,
        this.sunset,
        this.moonrise,
        this.moonset,
        this.moonPhase,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.windSpeed,
        this.windDeg,
        this.windGust,
        this.weather,
        this.clouds,
        this.pop,
        this.rain,
        this.uvi,
    });

    int? dt;
    int? sunrise;
    int? sunset;
    int? moonrise;
    int? moonset;
    double? moonPhase;
    Temp? temp;
    FeelsLike? feelsLike;
    int? pressure;
    int? humidity;
    double? dewPoint;
    double? windSpeed;
    int? windDeg;
    double? windGust;
    List<Weather?>? weather;
    int? clouds;
    double? pop;
    double? rain;
    dynamic uvi;

    factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"],
        temp: json["temp"] != null ? Temp.fromJson(json['temp']) : null,
        feelsLike: json["feels_like"] != null
              ? FeelsLike.fromJson(json['feels_like'])
              : null,
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"],
        windSpeed: json["wind_speed"],
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"],
        weather: json["weather"] == null ? [] : json["weather"] == null ? [] : List<Weather?>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"],
        rain: json["rain"],
        uvi: json["uvi"],
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather == null ? [] : weather == null ? [] : List<dynamic>.from(weather!.map((x) => x!.toJson())),
        "clouds": clouds,
        "pop": pop,
        "rain": rain,
        "uvi": uvi,
    };
}