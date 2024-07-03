import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  late String cityName;
  late DateTime date;
  late String day;
  List<weatherItem> DayData = []; // Changed to growable list
  final String inputValue;
  late double min;
  late double max;

  Weather(this.inputValue, this.date);

  Future<String?> fetchWeatherData(String inputValue) async {
    final String url =
        'https://api.openweathermap.org/data/2.5/forecast?q=${inputValue}&APPID=53462766eecddb633fb03f9f9809c92a&lang=en';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        //print('Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      //print('Exception thrown: $e');
      return null;
    }
  }

  double getMin(List<weatherItem> arr) {
    min = arr[0].temperature;
    for (int i = 1; i < arr.length; i++) {
      if (arr[i].temperature < min) {
        min = arr[i].temperature;
      }
    }
    return min;
  }

  double getMax(List<weatherItem> arr) {
    max = arr[0].temperature;
    for (int i = 1; i < arr.length; i++) {
      if (arr[i].temperature > max) {
        max = arr[i].temperature;
      }
    }
    return max;
  }

  Future<void> initWeather(input) async {
    String? json = await fetchWeatherData(input);
    if (json != null) {
      final result = jsonDecode(json);
      if (result['cod'] == '404') {
        cityName = 'City not found';
        return;
      } else {
        DateTime now = DateTime.now();
        now = now.add(const Duration(days: 1));
        now = now.copyWith(
            hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

        cityName = inputValue;
        print('test');
        print(DateTime.parse(result['list'][0]["dt_txt"]));

        for (var i = 0; i < 7; i++) {
          if (DateTime.parse(result['list'][i]["dt_txt"]).compareTo(now) < 0) {
            DayData.add(weatherItem(
                temperature: result['list'][i]['main']['temp'],
                icon: result['list'][i]['weather'][0]['icon'],
                description: result['list'][i]['weather'][0]['description']));
            
          }
        }

        day = DateFormat('EEEE').format(date);
      }
      ;
      min = getMin(DayData);
      max = getMax(DayData);
    }
  }
}

class weatherItem {
  double temperature;

  String description;
  String icon;
  weatherItem(
      {required this.temperature,
      required this.icon,
      required this.description});
}
