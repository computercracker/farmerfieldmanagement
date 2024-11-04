import 'package:flutter/material.dart';
import '../models/resource.dart';
import '../widgets/resource_card.dart';

class ResourceManagementScreen extends StatelessWidget {
  const ResourceManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample resources data
    List<Resource> resources = [
      Resource(id: '1', name: 'Seeds', quantity: 100),
      Resource(id: '2', name: 'Fertilizer', quantity: 50),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Resources'),
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return ResourceCard(resource: resources[index]);
        },
      ),
    );
  }
}
