import 'dart:convert';

import 'package:http/http.dart' as http;

class Weather {
  late String cityName;
  late DateTime date;
  late String day;
  late List<double> temperature;
  late String description;
  late String icon;
  final String inputValue;

  Weather(this.inputValue);

  /* factory Weather.fromJson(Map<String, dynamic> json) {
    List<double> temp = [];
    for (var i in json['main']['temp']) {
      temp.add(i);
    }
    return Weather(
      cityName: json['name'],
      temperature: temp,
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  } */
  Future<String?> fetchWeatherData(String inputValue) async {
    final String url =
        'https://api.openweathermap.org/data/2.5/forecast?q=${inputValue}&APPID=53462766eecddb633fb03f9f9809c92a&lang=en';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      print('Exception thrown: $e');
      return null;
    }
  }

  void initWeather() async {
    String? json = await fetchWeatherData(inputValue);
    if (json != null) {
      final result = jsonDecode(json);
      if (result['cod'] == '404') {
        cityName = 'City not found';
        return;
      } else {
        print(result);
      }
    }
  }
}
