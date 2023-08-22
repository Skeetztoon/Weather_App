import 'package:flutter/material.dart';
import 'package:weather_app/pages/location.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateFormat("dd MMM").format(DateTime.now()),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    child: Icon(
                      Icons.search_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Image.asset("assets/images/PartlySunny.png"),
              // Container(
              //   height: 200,
              //   width: 200,
              //   decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(20)
              //   ),
              // ),
              SizedBox(height: 15,),
              Text(
                "22°",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(
                child: Text(
                  "Moscow",
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
                          "8m/s",
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
                          "70",
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