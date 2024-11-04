import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Import Login Screen

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _fieldSizeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _cropTypes = ['Maize', 'Beans', 'Rice', 'Wheat'];
  List<String> _selectedCrops = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Registration'),
        backgroundColor: Colors.green, // Change the color for a fresh look
      ),
      body: SingleChildScrollView( // Allow scrolling for small screens
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(_nameController, 'Full Name'),
                _buildTextField(_emailController, 'Email'),
                _buildTextField(_phoneController, 'Phone Number'),
                _buildTextField(_farmNameController, 'Farm Name'),
                _buildTextField(_locationController, 'Location'),
                _buildTextField(_fieldSizeController, 'Field Size (acres)'),
                _buildCropDropdown(),
                _buildTextField(_usernameController, 'Username'),
                _buildTextField(_passwordController, 'Password', isObscure: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Padding for the button
                    textStyle: TextStyle(fontSize: 18), // Button text style
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
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

  Widget _buildCropDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Crop Types',
        border: OutlineInputBorder(), // Rounded border for the dropdown
      ),
      items: _cropTypes.map((String crop) {
        return DropdownMenuItem<String>(
          value: crop,
          child: Text(crop),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null && !_selectedCrops.contains(value)) {
          setState(() {
            _selectedCrops.add(value); // Add selected crop to the list
          });
        }
      },
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Save the registered data to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setString('farmName', _farmNameController.text);
      await prefs.setString('location', _locationController.text);
      await prefs.setString('fieldSize', _fieldSizeController.text);
      await prefs.setStringList('crops', _selectedCrops); // Save selected crops

      // Navigate to login screen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
