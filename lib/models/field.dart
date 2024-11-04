class Field {
  final String id;
  final String size;
  final String location;
  final String cropType;
  final List<String> topCrops;

  Field({
    required this.id,
    required this.size,
    required this.location,
    required this.cropType,
    required this.topCrops,
  });
}
