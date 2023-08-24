import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/logics/cityProvider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/location.dart';
import 'package:weather_app/utils/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => CityProvider(),
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: basicTheme(),
        home: const HomePage(),
      ),
    );
  }
}

