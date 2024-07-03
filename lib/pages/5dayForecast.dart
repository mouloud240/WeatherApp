import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/modals/weather.dart';

class daysForecast extends StatefulWidget {
  const daysForecast({super.key});

  @override
  State<daysForecast> createState() => _daysForecastState();
}

String? json;

class _daysForecastState extends State<daysForecast> {
  Weather now = Weather('london', DateTime.now());
  bool isLoading = true;
  Future<void> fetchWeather() async {
    json = await now.fetchWeatherData(now.inputValue);
    now.initWeather(json, now.date);
    setState(() {
      isLoading = false;
    });
  }

  List<Map<String, dynamic>> _widgetList = [{}, {}, {}];
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                isLoading = true;
                fetchWeather();
              },
              child: ListView.builder(
                  itemCount: _widgetList.length,
                  itemBuilder: (context, index) {
                    _widgetList = [
                      {
                        'widget': _title(now),
                        'Alignment': [0.0, 0]
                      },
                      {
                        'widget': _FiveDaysForcast(
                          json: json,
                        ),
                        'Alignment': [0.0, 0]
                      },
                      {
                        'widget': _airQuality(),
                        'Alignment': [0.0, 0]
                      }
                    ];

                    return Container(
                        alignment:
                            Alignment(_widgetList[index]['Alignment'][0], 0),
                        child: _widgetList[index]['widget']);
                  }),
            ),
    ));
  }
}

Widget _title(Weather now) {
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: Column(
      children: [
        Text(
          "${now.cityName}",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(
          "Max:${(now.DayData.reduce((a, b) => a.temperature > b.temperature ? a : b).temperature - 273).toInt()}°   Min:${(now.DayData.reduce((a, b) => a.temperature < b.temperature ? a : b).temperature - 273).toInt()}°",
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
      ],
    ),
  );
}

class _FiveDaysForcast extends StatefulWidget {
  final String? json;
  const _FiveDaysForcast({super.key, required this.json});

  @override
  State<_FiveDaysForcast> createState() => __FiveDaysForcastState();
}

class __FiveDaysForcastState extends State<_FiveDaysForcast> {
  @override
  Widget build(BuildContext context) {
    List<Widget> WeatherCards = [];
    for (var i = 0; i < 7; i++) {
      Weather date = Weather('london', DateTime.now().add(Duration(days: i)));
      date.initWeather(widget.json, date.date);
      if (date.DayData.length > 0) {
        int avg =
            (date.DayData.map((e) => e.temperature).reduce((a, b) => a + b) /
                    date.DayData.length)
                .toInt();
        WeatherCards.add(WeatherCard(
          day: date.day,
          temp: avg - 273,
          icon: date.DayData[0].icon,
          isfirst: i == 0,
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            alignment: Alignment(-0.6, 0),
            child: Text(
              "5-Days Forecasts",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: WeatherCards,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 25,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String day;
  final int temp;
  final String icon;
  final bool isfirst;

  WeatherCard(
      {required this.day,
      required this.temp,
      required this.icon,
      required this.isfirst});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 10, 2, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: 82,
          height: 172,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isfirst
                  ? ([Colors.purple, Colors.deepPurple])
                  : ([
                      Color.fromRGBO(64, 47, 145, 100),
                      Color.fromRGBO(127, 107, 187, 100)
                    ]),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$temp°',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 17),
              SvgPicture.asset(
                'assets/images(openweather)/${icon}.svg',
                color: Colors.white,
                width: 50,
                height: 50,
              ),
              SizedBox(height: 17),
              Text(
                day.substring(0, 3),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _airQuality() {
  return Container(
    margin: EdgeInsets.only(top: 30),
    width: 352,
    height: 174,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          offset: Offset(3, 4),
          blurRadius: 7,
        ),
      ],
      gradient: LinearGradient(
        colors: [
          Color(0xFF29225D),
          Color(0xFF9D5A9B),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'AIR QUALITY',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 17),
          Text(
            '3-Low Health Risk',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            height: 4, // Set the thickness of the divider
            width: 308, // Set the width of the divider
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(127, 107, 187, 100),
                  Color.fromRGBO(64, 47, 145, 100)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'See more',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
