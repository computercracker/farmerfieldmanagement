import 'package:flutter/material.dart';
import '../models/field_model.dart';

class FieldProvider extends ChangeNotifier {
  List<FieldModel> _fields = [];

  List<FieldModel> get fields => _fields;

  // Add a new field with validation
  void addField(FieldModel field) {
    if (field.isValid()) {
      _fields.add(field);
      notifyListeners();
    } else {
      throw Exception('Invalid field data');
    }
  }

  // Remove a field by index
  void removeField(int index) {
    if (index >= 0 && index < _fields.length) {
      _fields.removeAt(index);
      notifyListeners();
    } else {
      throw Exception('Invalid index');
    }
  }

  // Edit an existing field with validation
  void editField(int index, FieldModel field) {
    if (index >= 0 && index < _fields.length) {
      if (field.isValid()) {
        _fields[index] = field;
        notifyListeners();
      } else {
        throw Exception('Invalid field data');
      }
    } else {
      throw Exception('Invalid index');
    }
  }

  // Get a field by index
  FieldModel getField(int index) {
    if (index >= 0 && index < _fields.length) {
      return _fields[index];
    } else {
      throw Exception('Invalid index');
    }
  }

  // Search fields by title
  List<FieldModel> searchFields(String query) {
    if (query.isEmpty) {
      return _fields;
    }
    return _fields
        .where((field) => field.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Clear all fields
  void clearFields() {
    _fields.clear();
    notifyListeners();
  }

  // Optional: Save fields to local storage or a database
  Future<void> saveFields() async {
    // Implement your saving logic here (e.g., using SharedPreferences or a database)
  }

  // Optional: Load fields from local storage or a database
  Future<void> loadFields() async {
    // Implement your loading logic here (e.g., from SharedPreferences or a database)
  }
}
