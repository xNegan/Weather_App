import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/models/forcast.dart';
import 'package:weather_app/repo/weather_repo/weather_repo.dart';

final homeProvider = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController(ref: ref);
});

class HomeController extends ChangeNotifier {
  Ref ref;
  HomeController({required this.ref});
  String _inputValue = 'Gaza';
  Weather? _currentWeather;
  List<Forcast> weatherForcasts = [];
  bool _isLoading = false;

  Weather? get getResult => _currentWeather;
  bool get getLoadingStatus => _isLoading;

  String get inputValue => _inputValue;
  void setInputValue(String value) {
    _inputValue = value;
    print(_inputValue);
    notifyListeners();
  }

  // Future<CurrentWeather> getCurrentWeather({required String city}) async {
  //   final current =
  //       await ref.read(weatherRepoProvider).getCurrentWeather(cityName: city);
  //   return current;
  // }

  Future<Weather?> getCurrentWeather() async {
    try {
      _isLoading = true;
      final current = await ref
          .read(weatherRepoProvider)
          .getCurrentWeather(cityName: _inputValue);
      _isLoading = false;
      _currentWeather = current;
      weatherForcasts.clear();
      notifyListeners();
      // if (_currentWeather != null) {
      //   weatherForcasts = await ref
      //       .read(weatherRepoProvider)
      //       .getWeatherForcasts(cityName: _inputValue);
      //   notifyListeners();
      // }

      return _currentWeather;
    } catch (e) {
      _isLoading = false;

      _currentWeather = null;
      notifyListeners();

      return null;
    }
  }

  Future<void> getForcast() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      _isLoading = true;
      final forcasts = await ref
          .read(weatherRepoProvider)
          .getWeatherForcasts(cityName: _inputValue);
      _isLoading = false;
      weatherForcasts = forcasts;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
