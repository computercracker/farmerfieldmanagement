import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/field_provider.dart';
import '../models/field_model.dart';

class AddFieldScreen extends StatelessWidget {
  const AddFieldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _areaController = TextEditingController();
    final _formKey = GlobalKey<FormState>(); // Key for the form

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Field'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach form key
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Field Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null; // Valid input
                },
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Field Area'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an area';
                  }
                  return null; // Valid input
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed
                    final newField = FieldModel(
                      title: _titleController.text.trim(),
                      area: _areaController.text.trim(),
                    );
                    try {
                      Provider.of<FieldProvider>(context, listen: false)
                          .addField(newField);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Field added successfully!')),
                      );
                      // Clear the text fields
                      _titleController.clear();
                      _areaController.clear();
                    } catch (e) {
                      // Handle any error (e.g., invalid data)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
                child: const Text('Add Field'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
