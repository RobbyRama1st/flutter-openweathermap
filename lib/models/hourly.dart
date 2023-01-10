import 'package:weather_app_test/models/weather.dart';

class Hourly {
    Hourly({
        this.dt,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.uvi,
        this.clouds,
        this.visibility,
        this.windSpeed,
        this.windDeg,
        this.windGust,
        this.weather,
        this.pop,
    });

    int? dt;
    dynamic temp;
    double? feelsLike;
    int? pressure;
    int? humidity;
    dynamic dewPoint;
    dynamic uvi;
    int? clouds;
    int? visibility;
    dynamic windSpeed;
    int? windDeg;
    dynamic windGust;
    List<Weather?>? weather;
    dynamic pop;

    factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json["dt"],
        temp: json["temp"],
        feelsLike: json["feels_like"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"],
        uvi: json["uvi"],
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"],
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"],
        weather: json["weather"] == null ? [] : json["weather"] == null ? [] : List<Weather?>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
        pop: json["pop"],
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather == null ? [] : weather == null ? [] : List<dynamic>.from(weather!.map((x) => x!.toJson())),
        "pop": pop,
    };
}