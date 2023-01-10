class Wind {
    Wind({
        this.speed,
        this.deg,
        this.gust,
    });

    double? speed;
    int? deg;
    double? gust;

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"] == null ? null : json["speed"].toDouble(),
        deg: json["deg"] == null ? null : json["deg"],
        gust: json["gust"] == null ? null : json["gust"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "speed": speed == null ? null : speed,
        "deg": deg == null ? null : deg,
        "gust": gust == null ? null : gust,
    };
}