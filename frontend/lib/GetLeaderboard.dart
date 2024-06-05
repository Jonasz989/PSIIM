class GetLeaderboard {
  final String name;
  final int points;
  final int position;

  GetLeaderboard({
    required this.name,
    required this.points,
    required this.position,
  });

  factory GetLeaderboard.fromJson(Map<String, dynamic> json) {
    return GetLeaderboard(
        name: json['name'], points: json['points'], position: json['position']);
  }
}
