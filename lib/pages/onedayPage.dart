import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/modals/weather.dart';

class Onedaypage extends StatefulWidget {
  const Onedaypage({super.key});

  @override
  State<Onedaypage> createState() => _OnedaypageState();
}

class _OnedaypageState extends State<Onedaypage> {
  Weather now = Weather('London', DateTime.now().add(Duration(days: 1)));

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: IconButton(
          onPressed: () async {
            await now.initWeather();
            print(now.day);
          },
          icon: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
