import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _location = 'London'; // Default location
  String? _temperature;
  String? _humidity;
  String? _condition;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Clear previous error
    });

    final apiKey = 'YOUR_API_KEY'; // Replace with your API key
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$_location&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _temperature = '${data['main']['temp']}°C';
          _humidity = '${data['main']['humidity']}%';
          _condition = data['weather'][0]['description'].capitalize();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not fetch weather data. Please try again later.';
        _isLoading = false;
      });
    }
  }

  void _updateLocation() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController locationController = TextEditingController(text: _location);
        return AlertDialog(
          title: Text('Enter Location'),
          content: TextField(
            controller: locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _location = locationController.text;
                  _fetchWeatherData();
                });
                Navigator.of(context).pop();
              },
              child: Text('Fetch Weather'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: _updateLocation,
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _errorMessage != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _errorMessage!,
            style: TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        )
            : _buildWeatherInfo(),
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current Weather in $_location',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Temperature: ${_temperature ?? 'N/A'}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Humidity: ${_humidity ?? 'N/A'}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Condition: ${_condition ?? 'N/A'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchWeatherData,
                child: Text('Refresh Weather Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringCapitalization on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
