import 'package:flutter/material.dart';
import 'package:weather_app/pages/5dayForecast.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/pages/onedayPage.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const homePage(),
      initialRoute: '/',
      routes: {
        "oneday": (context) => Onedaypage(),
        "5dayforecast": (context) => daysForecast()
      },
    );
  }
}
