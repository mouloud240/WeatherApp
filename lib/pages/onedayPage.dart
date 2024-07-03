import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/modals/weather.dart';

class Onedaypage extends StatefulWidget {
  const Onedaypage({super.key});
  @override
  State<Onedaypage> createState() => _OnedaypageState();
}

class _OnedaypageState extends State<Onedaypage> {
  String _inputValue = "London";

  bool isLoading = true;
  late Position _currentLocation;
  late Weather now;

  @override
  void initState() {
    super.initState();
    now = Weather(_inputValue, DateTime.now().add(Duration(days: 1)));
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      // Ensure you're fetching based on the latest logic or conditions
      String? json = await now.fetchWeatherData(_inputValue); // Assuming this is the latest logic
      now.initWeather(json, now.date);
      setState(() {
        isLoading = false;
      });
      print("fetched city: " + _inputValue);
    } catch (e) {
      print("Error fetching weather: $e");
      // Handle error fetching weather data
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          child: Image.asset("assets/weatherLogo.png"),
                          height: 200,
                          width: 200,
                        ),
                        Text(
                          ((now.DayData[0].temperature - 273.15).round())
                                  .toString() +
                              '°',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Max: ' +
                                  (now.max.round() - 273.15)
                                      .round()
                                      .toString() +
                                  '°',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400)),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Min: ' +
                                  (now.min.round() - 273.15)
                                      .round()
                                      .toString() +
                                  '°',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                            height: 220,
                            width: 300,
                            child: Image.asset('assets/house.png')),
                      ],
                    ),
                    Positioned(
                      top: 600,
                      child: Container(
                        height: 100,
                        width: 450,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  elevation:
                                      MaterialStateProperty.all<double>(0),
                                ),
                                onPressed: () async {
                                  _currentLocation = await _determinePosition();
                                  final placemarks = await placemarkFromCoordinates(
                                    _currentLocation.latitude,
                                    _currentLocation.longitude,
                                  );

                                  setState(() {
                                    _inputValue = placemarks.isNotEmpty
                                        ? placemarks[0].administrativeArea ??
                                            "Unknown"
                                        : "Unknown";
                                  });

                                  // Update weather for the new location
                                  fetchWeather();
                                },
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  elevation:
                                      MaterialStateProperty.all<double>(0),
                                ),
                                onPressed: () {},
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  elevation:
                                      MaterialStateProperty.all<double>(0),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('5dayforecast');
                                },
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 500,
                      child: SizedBox(
                        width: 410,
                        child: Container(
                          child: ListView.builder(
                            itemCount: now.DayData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Weather_icon(
                                temp: (now.DayData[index].temperature - 272.15)
                                    .round()
                                    .toString(),
                                time: "13:00",
                                icon: "assets/weatherLogo.png",
                              );
                            },
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class Weather_icon extends StatelessWidget {
  final String temp;
  final String icon;
  final String time;

  Weather_icon({
    Key? key,
    required this.temp,
    required this.icon,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          this.temp + "°" + "c",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Image.asset(
          icon,
          height: 50,
          width: 50,
        ),
        Text(
          time,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
