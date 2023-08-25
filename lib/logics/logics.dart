import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/api/api_key.dart';

class NetworkData {
  NetworkData(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'assets/images/Storm.png';
    } else if (condition < 600) {
      return 'assets/images/Rainy.png';
    } else if (condition < 700) {
      return 'assets/images/Snowy.png';
    } else if (condition < 800) {
      return 'assets/images/Fog.png';
    } else if (condition == 800) {
      return 'assets/images/Sunny.png';
    } else if (condition <= 804) {
      return 'assets/images/Cloudy.png';
    } else {
      return '🤷‍';
    }
  }
}


