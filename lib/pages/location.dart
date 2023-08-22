import 'package:flutter/material.dart';
import '/logics/logics.dart';

class Locations extends StatefulWidget {
  Locations({this.locationWeather});
  final locationWeather;
  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  late int temperature;
  late String cityName;
  late int condition;
  late String weatherIcon;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weather) {
    setState(() {
      if (weather == null) {
        temperature = 0;
        cityName = '';
        weatherIcon="";
        return;
      }
      var condition = weather['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      temperature = weather['main']['temp'].toInt();
      cityName = weather['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                if (cityName != null) {
                  var weatherData = await weatherModel.getCityWeather(cityName);
                  updateUI(weatherData);
                }
              },
              child: Text(
                'Get Weather',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '$temperature°',
                  ),
                  Image.asset(weatherIcon)
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  'in $cityName',
                  //textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}