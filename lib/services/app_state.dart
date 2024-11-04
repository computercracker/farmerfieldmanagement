import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppState extends ChangeNotifier {
  String _location = 'Unknown';
  bool _isLoggedIn = false;
  String? _userName;
  String? _userEmail;
  String? _userPassword; // Add user password for sign-up
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;

  // Constructor to load initial state
  AppState() {
    _loadFromPrefs();
    _monitorConnectivity();
  }

  // Getter for location
  String get location => _location;

  // Getter for authentication status
  bool get isLoggedIn => _isLoggedIn;

  // Getter for user information
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  // Getter for connectivity status
  ConnectivityResult get connectivityStatus => _connectivityStatus;

  // Setter for location
  void setLocation(String newLocation) {
    _location = newLocation;
    _saveToPrefs(); // Save the new location
    notifyListeners();
  }

  // Method to log in the user
  Future<void> logIn(String name, String email) async {
    _isLoggedIn = true;
    _userName = name;
    _userEmail = email;
    await _saveToPrefs(); // Save user info
    notifyListeners();
  }

  // Method to log out the user
  Future<void> logOut() async {
    _isLoggedIn = false;
    _userName = null;
    _userEmail = null;
    _userPassword = null; // Clear the password on logout
    await _clearPrefs(); // Clear saved user info
    notifyListeners();
  }

  // Method to sign up the user
  Future<void> signUp(String name, String email, String password) async {
    _isLoggedIn = true; // Assuming sign-up means the user is logged in
    _userName = name;
    _userEmail = email;
    _userPassword = password; // Store the password temporarily (consider secure storage)
    await _saveToPrefs(); // Save user info
    notifyListeners();
  }

  // Load state from shared preferences
  Future<void> _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _location = prefs.getString('location') ?? 'Unknown';
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userName = prefs.getString('userName');
    _userEmail = prefs.getString('userEmail');
    _userPassword = prefs.getString('userPassword'); // Optional: be cautious with storing passwords
    notifyListeners();
  }

  // Save state to shared preferences
  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', _location);
    await prefs.setBool('isLoggedIn', _isLoggedIn);
    if (_userName != null) {
      await prefs.setString('userName', _userName!);
    }
    if (_userEmail != null) {
      await prefs.setString('userEmail', _userEmail!);
    }
    if (_userPassword != null) {
      await prefs.setString('userPassword', _userPassword!); // Optional: be cautious
    }
  }

  // Clear saved preferences
  Future<void> _clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('location');
    await prefs.remove('isLoggedIn');
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    await prefs.remove('userPassword'); // Optional: be cautious
  }

  // Monitor network connectivity status
  void _monitorConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityStatus = result; // Update the connectivity status
      notifyListeners(); // Notify listeners of connectivity change
    });
  }

  // Method to check initial connectivity status
  Future<void> checkInitialConnectivity() async {
    _connectivityStatus = await Connectivity().checkConnectivity();
    notifyListeners(); // Notify listeners with the initial status
  }

  // Method to refresh the location
  Future<void> refreshLocation() async {
    // Simulate fetching a new location; replace this with actual location fetching logic
    String newLocation = await _fetchNewLocation();

    // Update the location
    setLocation(newLocation);
  }

  // Simulate fetching a new location; you can replace this with actual location fetching logic
  Future<String> _fetchNewLocation() async {
    // You would typically use a package like geolocator to get the actual location
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return 'New Location'; // Return a simulated new location
  }
}
