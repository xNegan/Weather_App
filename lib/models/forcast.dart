import 'package:flutter/material.dart';

class Forcast {
  final double tempreature;
  final double windSpeed;
  final double humidity;
  final String date;

  Forcast({
    required this.tempreature,
    required this.windSpeed,
    required this.humidity,
    required this.date,
  });

  factory Forcast.fromJson(Map<String, dynamic> json) {
    return Forcast(
        tempreature: json['temp'].toDouble(),
        windSpeed: json['wind_spd'].toDouble(),
        date: json['datetime'],
        humidity: json['rh'].toDouble());
  }
}
