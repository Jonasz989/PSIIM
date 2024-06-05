class GetPoints {
  final int id;
  final String name;
  final String description;
  final String photo;
  final double lon;
  final double lat;

  GetPoints({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.lon,
    required this.lat,
  });

  factory GetPoints.fromJson(Map<String, dynamic> json) {
    return GetPoints(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photo: json['photo'],
      lon: double.parse(json['lon'].toString()),
      lat: double.parse(json['lat'].toString()),
    );
  }
}
