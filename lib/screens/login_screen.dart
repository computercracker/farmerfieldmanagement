import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart'; // Import Dashboard Screen
import 'registration_screen.dart'; // Import Registration Screen

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green, // Updated AppBar color
      ),
      body: SingleChildScrollView( // Allow scrolling for smaller screens
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              SizedBox(height: 40), // Space at the top
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Heading color
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(_usernameController, 'Username'),
              SizedBox(height: 10), // Spacing between fields
              _buildTextField(_passwordController, 'Password', isObscure: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Padding for button
                  textStyle: TextStyle(fontSize: 18), // Button text style
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                },
                child: Text('Create an account', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isObscure = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(), // Rounded border for better appearance
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2), // Color when focused
        ),
      ),
      obscureText: isObscure,
      validator: (value) => value!.isEmpty ? 'Please enter your $label' : null,
    );
  }

  void _login(BuildContext context) async {
    String username = _usernameController.text.trim(); // Trim whitespace
    String password = _passwordController.text.trim(); // Trim whitespace

    // Retrieve the stored username and password
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    String? storedPassword = prefs.getString('password');

    // Validate inputs
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both username and password.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Simple validation logic
    if (username == storedUsername && password == storedPassword) {
      // If login is successful, navigate to DashboardScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      // Show an error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
