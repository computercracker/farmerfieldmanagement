import 'package:flutter/material.dart';
import '../screens/home_screen.dart'; // Import Home Screen

void main() {
  runApp(FarmerFieldManagementApp());
}

class FarmerFieldManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Field Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // Define other theme properties if needed
      ),
      home: HomeScreen(), // Set the home to HomeScreen
      debugShowCheckedModeBanner: false, // Hide debug banner in release mode
    );
  }
}
