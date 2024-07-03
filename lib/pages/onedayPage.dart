import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/modals/weather.dart';

class Onedaypage extends StatefulWidget {
  const Onedaypage({super.key});
  @override
  State<Onedaypage> createState() => _OnedaypageState();
}

class _OnedaypageState extends State<Onedaypage> {
  Weather now = Weather('Guelma', DateTime.now().add(Duration(days: 1)));
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    String? json = await now.fetchWeatherData(now.inputValue);
    now.initWeather(json, now.date);
    setState(() {
      isLoading = false;
    });
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
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Image.asset("assets/weatherLogo.png"),
                      height: 350,
                      width: 350,
                    ),
                    Text(
                      ((now.DayData[0].temperature - 272.15).round())
                              .toString() +
                          '°',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 40)),
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
