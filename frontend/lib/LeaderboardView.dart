import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaderboardUser {
  final String name;
  final int points;
  final int position;

  LeaderboardUser({
    required this.name,
    required this.points,
    required this.position,
  });

  factory LeaderboardUser.fromJson(Map<String, dynamic> json) {
    return LeaderboardUser(
      name: json['name'],
      points: json['points'],
      position: json['position'],
    );
  }
}

class LeaderboardView extends StatefulWidget {
  final String accessToken;
  LeaderboardView({required this.accessToken});

  @override
  _LeaderboardState createState() =>
      _LeaderboardState(accessToken: accessToken);
}

class _LeaderboardState extends State<LeaderboardView> {
  List<LeaderboardUser> users = [];
  final String accessToken;

  _LeaderboardState({required this.accessToken});

  @override
  void initState() {
    super.initState();
    _fetchPeople();
  }

  Future<void> _fetchPeople() async {
    final String apiUrl = 'http://192.168.1.2:8080/api/ranking';
    final String token = accessToken;
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Data received: $data');

        setState(() {
          users = data.map((json) => LeaderboardUser.fromJson(json)).toList();
          users.sort((a, b) => b.points.compareTo(a.points));
        });
      } else {
        throw Exception('Failed to fetch leaderboard: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching leaderboard: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(204, 255, 88, 252),
                  Color.fromARGB(247, 60, 0, 255),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Leaderboard',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/user_placeholder.jpg'),
                          ),
                          title: Text(
                            users[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Points: ${users[index].points}'),
                          trailing: Text('Position: ${users[index].position}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60.0,
            left: 40.0,
            child: FloatingActionButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
