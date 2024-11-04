import 'package:flutter/material.dart';
import '../models/resource.dart';

class ResourceCard extends StatelessWidget {
  final Resource resource;

  const ResourceCard({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resource: ${resource.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Quantity: ${resource.quantity}'),
          ],
        ),
      ),
    );
  }
}
