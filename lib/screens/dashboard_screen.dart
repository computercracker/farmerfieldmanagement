import 'package:flutter/material.dart';
import 'manage_fields_screen.dart'; // Import Manage Fields Screen

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout logic
              Navigator.pop(context); // Return to login screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Welcome Message
            Text(
              'Welcome to the Farmer Field Management System!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Options for different functionalities
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildDashboardCard(
                    context,
                    'Manage Fields',
                    Icons.agriculture,
                        () {
                      // Navigate to field management
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageFieldsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Crop Planning',
                    Icons.calendar_today,
                        () {
                      // Navigate to crop planning
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Resource Management',
                    Icons.inventory,
                        () {
                      // Navigate to resource management
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Real-time Monitoring',
                    Icons.monitor,
                        () {
                      // Navigate to monitoring screen
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Analytics',
                    Icons.bar_chart,
                        () {
                      // Navigate to analytics screen
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Reports',
                    Icons.report,
                        () {
                      // Navigate to reports screen
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.green,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
