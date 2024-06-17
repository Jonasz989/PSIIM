import 'dart:convert';

class GetAchievements {
  final int id;
  var user;
  var monument;
  final String name;
  final String description;
  final String photo;
  final int points;

  GetAchievements({
    required this.id,
    required this.user,
    required this.monument,
    required this.photo,
    required this.name,
    required this.description,
    required this.points,
  });

  factory GetAchievements.fromJson(Map<String, dynamic> json) {
    return GetAchievements(
      id: json['id'],
      user: json['user'],
      monument: json['monumentPoi'],
      photo: json['photo'],
      name: json['name'],
      description: json['description'],
      points: json['points'],
    );
  }
}
