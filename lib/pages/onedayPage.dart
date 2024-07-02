import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/modals/weather.dart';

class Onedaypage extends StatefulWidget {
  const Onedaypage({super.key});

  @override
  _OnedaypageState createState() => _OnedaypageState();
}

class _OnedaypageState extends State<Onedaypage> {
  late Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    // Initialize weather data
    weather = Weather('London').fetchWeather();
  }

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
        child: FutureBuilder<Weather>(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading weather data'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No weather data available'));
            } else {
              final weatherData = snapshot.data!;
              return Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    weatherData.cityName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${weatherData.temperature}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    weatherData.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(weatherData.iconUrl), // Assuming the icon URL is provided
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            weather = Weather('London').fetchWeather();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
