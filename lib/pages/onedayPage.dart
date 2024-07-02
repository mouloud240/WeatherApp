import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/modals/weather.dart';

class Onedaypage extends StatelessWidget {
  const Onedaypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF003366),
              Color(0xFF663399),
              Color(0xFFFF00FF),
            ],
            stops: [0.1, 0.9, 1.0],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "City Name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Temperature",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Description",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Icon",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Weather weather = Weather('london');
          weather.initWeather();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
