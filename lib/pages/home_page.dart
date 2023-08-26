import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:weather_app/pages/newPage.dart';
import '../logics/cities.dart';
import '../logics/logics.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cityName = "";
  int temperature = 0;
  late int condition;
  String weatherIcon = "";
  double wind = 0;
  int humidity = 0;
  WeatherModel weatherModel = WeatherModel();

  bool _shouldShowContent = false;
  bool _showIcon = false;
  bool _shouldShowTextField = false;

  // @override
  // void initState() {
  //   super.initState();
  //   updateUI(widget.locationWeather);
  // }

  void updateUI(dynamic weather) {
    setState(() {
      if (weather == null) {
        temperature = 0;
        cityName = '';
        _showIcon = false;
        wind = 0;
        humidity = 0;
        return;
      }
      _showIcon = true;
      humidity = weather['main']['humidity'].toInt();
      wind = weather['wind']['speed'].toDouble();
      condition = weather['weather'][0]['id'];
      weatherIcon = '';
      weatherIcon = weatherModel.getWeatherIcon(condition);
      temperature = weather['main']['temp'].toInt();
    });
  }

  double x = 0, y = 0, z = 0;

  String direction = "none";

  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // print(event);

      x = event.x;
      y = event.y;
      z = event.z;
      if((y.abs() > 3) && (isFlipped==false)){
        bool isFlipped = true;
        print("FLIPPING TO SUNNY ICON");
        direction = 'redColor';
        Navigator.of(context).pushNamed("NewPage");
      }
    },
      onError: (error) {
        print(error);
      },
      cancelOnError: true,);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _shouldShowTextField =
                        true; // Always show text field when tapped
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
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Autocomplete<String>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text == '') {
                                        return const Iterable<String>.empty();
                                      } else {
                                        // filtered = cities.where((String option) => option
                                        //     .toLowerCase()
                                        //     .contains(textEditingValue.text.toLowerCase())).length;

                                        return cities.where((String option) =>
                                            option.toLowerCase().contains(
                                                textEditingValue.text
                                                    .toLowerCase()));
                                      }
                                    },
                                    onSelected: (value) async {
                                      cityName = value;
                                      var weatherData = await weatherModel
                                          .getCityWeather(cityName);
                                      updateUI(weatherData);
                                      _shouldShowContent = true;
                                    },
                                    fieldViewBuilder: (context, controller,
                                        focusNode, onEditingComplete) {
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
                                                    fontWeight:
                                                        FontWeight.normal)),
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
              ),

              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: _shouldShowContent==false ? const CircularProgressIndicator() : Column(
                  children: [
                    Container(
                        child: _showIcon
                            ? Image.asset(weatherIcon)
                            : CircularProgressIndicator()),
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
                    Text(direction),
                    Text(
                      "$temperature°",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(
                      child: Text(
                        cityName,
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
                                "${wind}m/s",
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
                                humidity.toString(),
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
            ],
          ),
        ),
      ),
    );
  }

  void _closeIconAction() {
    setState(() {
      _shouldShowTextField = false;
    });
  }
}
