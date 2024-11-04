import 'dart:convert';

class FieldModel {
  final String title;
  final String area;
  final String? cropType; // Optional property to specify the type of crop
  final DateTime? plantingDate; // Optional property to track the planting date

  FieldModel({
    required this.title,
    required this.area,
    this.cropType,
    this.plantingDate,
  });

  // Method to validate the field properties
  bool isValid() {
    return title.isNotEmpty && area.isNotEmpty && double.tryParse(area) != null;
  }

  // Method to convert the FieldModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'area': area,
      'cropType': cropType,
      'plantingDate': plantingDate?.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }

  // Factory constructor to create a FieldModel from JSON
  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      title: json['title'],
      area: json['area'],
      cropType: json['cropType'],
      plantingDate: json['plantingDate'] != null
          ? DateTime.parse(json['plantingDate'])
          : null,
    );
  }

  @override
  String toString() {
    return 'FieldModel(title: $title, area: $area, cropType: $cropType, plantingDate: $plantingDate)';
  }
}
