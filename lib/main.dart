import 'package:flutter/material.dart';
import 'package:weather_app/logics/routeGenerator.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/newPage.dart';
import 'package:weather_app/utils/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: <String, WidgetBuilder> {
      //   '/': (BuildContext context) => new HomePage(),
      //   '/newPage' : (BuildContext context) => new NewPage(),
      // },
        onGenerateRoute: RouteGenerator.genetateRoute,
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: basicTheme(),
        // home: const HomePage(),
    );
  }
}

