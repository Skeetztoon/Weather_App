import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logics/cityProvider.dart';
import '../logics/logics.dart';
import 'iconToText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.locationWeather});
  final locationWeather;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
    final providerCity = Provider.of<CityProvider>(context);
    cityName = providerCity.cityName;
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTextField(),

              const SizedBox(
                height: 50,
              ),
              Image.asset("${providerCity.weatherIcon}"),
              // Container(
              //   height: 200,
              //   width: 200,
              //   decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(20)
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${providerCity.temperature}°",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(
                child: Text(
                  providerCity.cityName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Wind now",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "${providerCity.wind}m/s",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Humidity",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          providerCity.humidity.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Precipitation",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "90",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
