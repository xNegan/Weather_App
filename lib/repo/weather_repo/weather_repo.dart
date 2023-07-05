import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/app_constant.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/models/forcast.dart';

final weatherRepoProvider = Provider<WeatherRepo>((ref) {
  return WeatherRepo();
});

class WeatherRepo {
  Future<Weather> getCurrentWeather({required cityName}) async {
    try {
      final String link =
          'https://api.weatherbit.io/v2.0/current?city=$cityName&key=$apiKey';

      final url = Uri.parse(link);
      final responseData = await http.get(url);
      print(url);
      print(responseData.statusCode);
      final decodedResponse =
          jsonDecode(responseData.body)['data'] as List<dynamic>;
      print(decodedResponse);
      return decodedResponse.map((e) => Weather.fromJson(e)).toList().first;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Forcast>> getWeatherForcasts({required cityName}) async {
    try {
      final String link =
          'https://api.weatherbit.io/v2.0/forecast/daily?city=${cityName}&key=$apiKey';

      final url = Uri.parse(link);
      final responseData = await http.get(url);
      print('Aaaaalllllll');
      print(responseData.statusCode);
      final decodedResponse =
          jsonDecode(responseData.body)['data'] as List<dynamic>;
      print(decodedResponse);
      return decodedResponse.map((e) => Forcast.fromJson(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
