import 'package:flutter/material.dart';

class CityProvider extends ChangeNotifier {
  String _cityName = "Undefined city";
  String get cityName => _cityName;
  set cityName (String newCityName) {
    _cityName = newCityName;
    notifyListeners();
  }

  int _temperature = 0;
  int get temperature => _temperature;
  set temperature (int newTemperature) {
    _temperature= newTemperature;
    notifyListeners();
  }

  double _wind = 0;
  double get wind => _wind;
  set wind (double newWind) {
    _wind = newWind;
    notifyListeners();
  }

  int _humidity = 0;
  int get humidity => _humidity;
  set humidity (int newhumidity) {
    _humidity= newhumidity;
    notifyListeners();
  }

  int _condition = 0;
  int get condition => _condition;
  set condition (int newCondition) {
    _condition= newCondition;
    notifyListeners();
  }

  String _weatherIcon = "Undefined city";
  String get weatherIcon => _weatherIcon;
  set weatherIcon (String newWeatherIcon) {
    _weatherIcon = newWeatherIcon;
    notifyListeners();
  }

}