import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'daf7f423b1ddd6cb832e8fc197e375d8'; // Replace with your API key
  final String baseWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String baseForecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  Map<String, dynamic>? _cachedWeatherData;

  // Method to fetch current weather data
  Future<Map<String, dynamic>> fetchWeather(String location) async {
    if (_cachedWeatherData != null && _cachedWeatherData!['name'].toLowerCase() == location.toLowerCase()) {
      return _cachedWeatherData!;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseWeatherUrl?q=$location&appid=$apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        _cachedWeatherData = jsonDecode(response.body); // Cache the weather data
        return _cachedWeatherData!;
      } else {
        _handleHttpError(response);
        return {};
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return {};
    }
  }

  // Method to fetch weather forecast data
  Future<Map<String, dynamic>> fetchWeatherForecast(String location) async {
    try {
      final response = await http.get(
        Uri.parse('$baseForecastUrl?q=$location&appid=$apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        _handleHttpError(response);
        return {};
      }
    } catch (e) {
      print('Error fetching weather forecast: $e');
      return {};
    }
  }

  // Method to handle HTTP errors
  void _handleHttpError(http.Response response) {
    switch (response.statusCode) {
      case 404:
        throw Exception('City not found. Please enter a valid city name.');
      case 401:
        throw Exception('Invalid API key. Please check your credentials.');
      case 500:
        throw Exception('Server error. Please try again later.');
      default:
        throw Exception('An error occurred: ${response.body}');
    }
  }

  // Method to clear cached weather data
  void clearCache() {
    _cachedWeatherData = null;
  }

  // Method to get cached weather data
  Map<String, dynamic>? get cachedWeatherData => _cachedWeatherData;
}
