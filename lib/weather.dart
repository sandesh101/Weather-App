// import 'dart:convert';

class Weather {
  final double tempC;
  final String condition;
  final String image;
  final double windMph;
  final int humidity;
  Weather({
    this.tempC = 0,
    this.condition = "",
    this.image = "Image",
    this.windMph = 0.0,
    this.humidity = 0,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      tempC: map['current']['temp_c'],
      condition: map['current']['condition']['text'],
      image: map['current']['condition']['icon'],
      windMph: map['current']['wind_mph'],
      humidity: map['current']['humidity'],
    );
  }
}
