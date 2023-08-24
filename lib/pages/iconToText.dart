import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/logics/cities.dart';
import 'package:weather_app/logics/cityProvider.dart';
import 'package:weather_app/pages/location.dart';
import '/logics/logics.dart';

class IconTextField extends StatefulWidget {
  @override
  _IconTextFieldState createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {

  late int temperature;
  late int condition;
  late String weatherIcon;
  late int humidity;
  late double wind;
  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic weather) {
    setState(() {
      if (weather == null) {
        temperature = 0;
        weatherIcon="";
        humidity = 0;
        wind = 0;
        return;
      }
      humidity = weather['main']['humidity'].toInt();
      wind = weather['wind']['speed'].toDouble();
      var condition = weather['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      temperature = weather['main']['temp'].toInt();
    });
  }

  bool _shouldShowTextField = false;

  int filtered =0;

  @override
  Widget build(BuildContext context) {
    final providerCity = Provider.of<CityProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _shouldShowTextField = true; // Always show text field when tapped
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedCrossFade(
              firstChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IgnorePointer(
                    child: Text(
                      DateFormat("dd MMM").format(DateTime.now()),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Icon(Icons.search_rounded),
                ],
              ),
              secondChild: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Row(
                    children: [

                      Expanded(
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            } else {
                              filtered = cities.where((String option) => option
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase())).length;

                              return cities.where((String option) => option
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase()));
                            }
                          },

                          onSelected: (value) async {
                            providerCity.cityName = value;
                            var weatherData = await weatherModel.getCityWeather(providerCity.cityName);
                            updateUI(weatherData);
                            providerCity.weatherIcon = weatherIcon;
                            providerCity.temperature = temperature;
                            providerCity.humidity = humidity;
                            providerCity.wind = wind;


                          },
                          // optionsMaxHeight: 1,
                          // optionsViewBuilder:
                          //     (context, Function(String) onSelected, options) {
                          //   return Material(
                          //     child: ListView.separated(
                          //         itemBuilder: (context, index) {
                          //           final option = options.elementAt(index);
                          //
                          //           return ListTile(
                          //             title: Text(option.toString()),
                          //           );
                          //         },
                          //         separatorBuilder: (context, index) => Divider(),
                          //         itemCount: filtered,
                          //     ),
                          //   );
                          // },
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Start typing...',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.normal)),
                            );
                          },
                        ),
                      ),
                      TextButton(
                        child: Icon(
                          Icons.close,
                          color: Colors.grey.shade500,
                        ),
                        onPressed: () {
                          _closeIconAction();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              crossFadeState: _shouldShowTextField
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 150),
            ),
          ),
        ],
      ),
    );
  }

  void _closeIconAction() {
    setState(() {
      _shouldShowTextField = false;
    });
  }
}
