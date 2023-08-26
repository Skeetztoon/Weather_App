import 'package:flutter/material.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/newPage.dart';

PageRouteBuilder fadeTransitionBuilder({required Widget child}) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: const Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final _opacity = animation.drive(Tween<double>(begin: 0, end: 1));
        return FadeTransition(opacity: _opacity, child: child);
      });
}


class RouteGenerator {
  static Route<dynamic> genetateRoute(RouteSettings settings) {

    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return fadeTransitionBuilder(child: HomePage());
      case 'NewPage':
        return fadeTransitionBuilder(child: NewPage());
        return MaterialPageRoute(builder: (_) => NewPage(
          // data: args,
        ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text("Something is wrong with routes"),
        ),
      );
    });
  }

  
}