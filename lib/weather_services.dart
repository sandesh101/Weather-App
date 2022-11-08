import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather.dart';

class WeatherServices {
  Future getWeather(String place) async {
    final queryParamater = {
      'key': '022f4c436a3d4327bfb145804220611',
      'q': place,
    };
    final uri =
        Uri.http('api.weatherapi.com', '/v1/current.json', queryParamater);
    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Weather.fromMap(data);
      }
    } catch (e) {
      print(e);
    }
  }
}
