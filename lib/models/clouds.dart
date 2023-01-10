class Clouds {
    Clouds({
        this.all,
    });

    int? all;

    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"] == null ? null : json["all"],
    );

    Map<String, dynamic> toJson() => {
        "all": all == null ? null : all,
    };
}