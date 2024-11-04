import 'package:flutter/material.dart';
import '../models/field.dart';
import '../widgets/field_card.dart';

class FieldManagementScreen extends StatelessWidget {
  const FieldManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample fields data
    List<Field> fields = [
      Field(id: '1', size: '2 acres', location: 'North Farm', cropType: 'Corn', topCrops: ['Corn', 'Wheat']),
      Field(id: '2', size: '3 acres', location: 'South Farm', cropType: 'Wheat', topCrops: ['Wheat', 'Rice']),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Fields'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: fields.length,
          itemBuilder: (context, index) {
            return FieldCard(field: fields[index]);
          },
        ),
      ),
    );
  }
}
