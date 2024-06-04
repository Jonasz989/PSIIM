class GetPoints {
  final int id;
  final String name;
  final String description;
  final List<String> photo;
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
    List<String> photoList = [];
    var photo = json['photo'] as List?;
    if (photo != null) {
      photoList = List<String>.from(photo.map((item) => item.toString()));
    }

    return GetPoints(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photo: photoList,
      lon: double.parse(json['lon'].toString()),
      lat: double.parse(json['lat'].toString()),
    );
  }
}

class LocationList {
  final List<GetPoints> locations;

  LocationList({
    required this.locations,
  });

  factory LocationList.fromJson(List<dynamic> json) {
    List<GetPoints> locations =
        json.map((item) => GetPoints.fromJson(item)).toList();

    return LocationList(
      locations: locations,
    );
  }
}
