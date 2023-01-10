class Sys {
    Sys({
        this.country,
        this.sunrise,
        this.sunset,
    });

    String? country;
    int? sunrise;
    int? sunset;

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"] == null ? null : json["country"],
        sunrise: json["sunrise"] == null ? null : json["sunrise"],
        sunset: json["sunset"] == null ? null : json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "sunrise": sunrise == null ? null : sunrise,
        "sunset": sunset == null ? null : sunset,
    };
}