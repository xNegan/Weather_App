import 'package:flutter/material.dart';

class Weather {
  final double tempreature;
  final double windSpeed;
  final double humidity;
  final String cityName;
  final String date;

  Weather({
    required this.tempreature,
    required this.windSpeed,
    required this.humidity,
    required this.cityName,
    required this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        tempreature: json['temp'],
        windSpeed: json['wind_spd'],
        cityName: json['city_name'],
        date: json['datetime'],
        humidity: json['rh'].toDouble());
  }
}
