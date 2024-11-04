import 'package:flutter/material.dart';
import '../models/field.dart';

class FieldCard extends StatelessWidget {
  final Field field;

  const FieldCard({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location: ${field.location}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Size: ${field.size}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text('Crop Type: ${field.cropType}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text('Top Crops: ${field.topCrops.join(', ')}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
