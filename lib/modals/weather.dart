import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  late String cityName;
  late DateTime date;
  late String day;
  List<double> temperature = []; // Changed to growable list
  List<String> description = []; // Changed to growable list
  List<String> icons = []; // Changed to growable list
  final String inputValue;

  Weather(this.inputValue, this.date);

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

  Future<void> initWeather() async {
    String? json = await fetchWeatherData(inputValue);
    if (json != null) {
      final result = jsonDecode(json);
      if (result['cod'] == '404') {
        cityName = 'City not found';
        print('City not found');
        return;
      } else {
        print('City found------------------------------------------');
        DateTime now = DateTime.now();
        now = now.add(Duration(days: 1));
        now = now.copyWith(
            hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

        cityName = inputValue;

        for (var i = 0; i < 7; i++) {
          if (DateTime.parse(result['list'][i]["dt_txt"]).compareTo(now) < 0) {
            temperature.add((result['list'][i]['main']['temp']));
            icons.add(result['list'][i]['weather'][0]['icon']);
            description.add(result['list'][i]['weather'][0]['description']);
          }
        }

        day = DateFormat('EEEE').format(date);
      }
      ;
     
    }
  }
}
