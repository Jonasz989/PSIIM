import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/AlbumView.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/GetAchievements.dart';

class ProgressView extends StatefulWidget {
  final String accessToken;
  ProgressView({required this.accessToken});
  @override
  _ProgressViewState createState() =>
      _ProgressViewState(accessToken: accessToken);
}

class _ProgressViewState extends State<ProgressView> {
  String accessToken;
  _ProgressViewState({required this.accessToken});
  Future<List<GetAchievements>>? achievements;
  List<Achievement> achievements2 = [
    Achievement('Find your first monument', 'assets/images/win.jpg', 1),
    Achievement('Find 10 monumments', 'assets/images/win.jpg', 10),
    Achievement('Find 20 monumments', 'assets/images/win.jpg', 20),
    Achievement('Chatch them all!', 'assets/images/win.jpg', 50),
  ];

  @override
  void initState() {
    super.initState();
    achievements = _fetchAchievements();
  }

  Future<List<GetAchievements>> _fetchAchievements() async {
    final String apiUrl =
        "https://psiim-82a14bc94a7d.herokuapp.com/api/achievements";
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> listOfAchievements = jsonDecode(response.body);
        return listOfAchievements
            .map((item) => GetAchievements.fromJson(item))
            .toList();
      } else {
        throw Exception("Something is no yes: ${response.statusCode}");
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(204, 255, 88, 252),
                  Color.fromARGB(247, 60, 0, 255),
                ],
              ),
            ),
            child: FutureBuilder<List<GetAchievements>>(
                future: achievements,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Something went wrong ${snapshot.error}"));
                  } else {
                    if (snapshot.hasData) {
                      final achv = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: achievements2.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Image.asset(achievements2[index].imagePath,
                                    width: 50, height: 50),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(achievements2[index].name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            achv.length.toString() +
                                                " out of " +
                                                achievements2[index]
                                                    .progress
                                                    .toString(),
                                            style: TextStyle(fontSize: 10)),
                                        LinearProgressIndicator(
                                            value: achv.length /
                                                achievements2[index].progress),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                  return Container();
                }),
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

class Achievement {
  final String name;
  final String imagePath;
  final double progress;

  Achievement(this.name, this.imagePath, this.progress);
}
