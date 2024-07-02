import 'package:http/http.dart';

class Weather {
  final String cityName;
  final DateTime date;
  final String day;
  final List<double> temperature;
  final String description;
  final String? icon;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.description,
      this.icon,
       required this.date,
       required this.day});
 
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

}
