import 'package:flutter/material.dart';

class ManageFieldsScreen extends StatefulWidget {
  @override
  _ManageFieldsScreenState createState() => _ManageFieldsScreenState();
}

class _ManageFieldsScreenState extends State<ManageFieldsScreen> {
  List<String> fields = ['Field A', 'Field B', 'Field C'];
  List<String> locations = ['Location 1', 'Location 2', 'Location 3'];

  // Track selected fields and locations
  List<bool> selectedFields = [];
  List<bool> selectedLocations = [];

  @override
  void initState() {
    super.initState();
    // Initialize selected fields and locations to false
    selectedFields = List.generate(fields.length, (index) => false);
    selectedLocations = List.generate(locations.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Fields'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select Fields and Locations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Field selection
            _buildFieldSelection(),
            SizedBox(height: 20),

            // Location selection
            _buildLocationSelection(),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Handle selection submission
                _submitSelection();
              },
              child: Text('Submit Selection'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fields:', style: TextStyle(fontSize: 18)),
        ...List.generate(fields.length, (index) {
          return CheckboxListTile(
            title: Text(fields[index]),
            value: selectedFields[index],
            onChanged: (bool? value) {
              setState(() {
                selectedFields[index] = value!;
              });
            },
          );
        }),
      ],
    );
  }

  Widget _buildLocationSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Locations:', style: TextStyle(fontSize: 18)),
        ...List.generate(locations.length, (index) {
          return CheckboxListTile(
            title: Text(locations[index]),
            value: selectedLocations[index],
            onChanged: (bool? value) {
              setState(() {
                selectedLocations[index] = value!;
              });
            },
          );
        }),
      ],
    );
  }

  void _submitSelection() {
    List<String> selectedFieldNames = [];
    List<String> selectedLocationNames = [];

    // Collect selected field names
    for (int i = 0; i < fields.length; i++) {
      if (selectedFields[i]) {
        selectedFieldNames.add(fields[i]);
      }
    }

    // Collect selected location names
    for (int i = 0; i < locations.length; i++) {
      if (selectedLocations[i]) {
        selectedLocationNames.add(locations[i]);
      }
    }

    // Show selected fields and locations
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected Fields: ${selectedFieldNames.join(', ')}\n'
              'Selected Locations: ${selectedLocationNames.join(', ')}',
        ),
      ),
    );
  }
}
