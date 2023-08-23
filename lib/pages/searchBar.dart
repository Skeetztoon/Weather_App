import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "SearchBar",
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 1,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Flexible(
              flex: 4,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type your city here...",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey.shade300, fontWeight: FontWeight.normal),
                  fillColor: Colors.red,
                  contentPadding: EdgeInsets.all(5.0),
                ),
              ),
            ),
            TextButton(
              child: Icon(
                Icons.search_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
