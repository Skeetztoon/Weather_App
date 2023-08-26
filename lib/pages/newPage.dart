import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  double x = 0, y = 0, z = 0;

  String direction = "none";

  // void gyro() {
  //   gyroscopeEvents.listen((GyroscopeEvent event) {
  //     print(event);
  //     print("AAAAAAAAAAAAAAAAAAA");
  //   });
  // }
  bool isFlipped = false;
  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);
      x = event.x;
      y = event.y;
      z = event.z;
      if((y.abs() > 3) && (isFlipped==false)){
        print("FLIPPING TO MAIN PAGE");
        isFlipped = true;
        direction = 'redColor';
        Navigator.of(context).popAndPushNamed("/");
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
      body: Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed("/");
            },
            child: Icon(Icons.sunny, color: Colors.white,),
          ),
      ),
    );
  }
}
