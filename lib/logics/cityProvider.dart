import 'package:flutter/material.dart';

class CityProvider extends ChangeNotifier {
 String _cityname = "Undefined city";

 String get cityName => _cityname;

 set cityName (String newCityName) {
   _cityname = newCityName;
   notifyListeners();
 }
}