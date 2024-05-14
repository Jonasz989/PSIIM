import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  final List<Achievement> achievements = [
    Achievement('Achievement 1', 'assets/images/win.jpg', 0.5, '5 out of 10'),
    Achievement('Achievement 2', 'assets/images/win.jpg', 0.7, '7 out of 10'),
    // Add more achievements here
  ];

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
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: ListView.builder(
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(achievements[index].imagePath,
                            width: 50, height: 50),
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(achievements[index].name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(achievements[index].progressText,
                                    style: TextStyle(fontSize: 10)),
                                LinearProgressIndicator(
                                    value: achievements[index].progress),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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

class Achievement {
  final String name;
  final String imagePath;
  final double progress;
  final String progressText;

  Achievement(this.name, this.imagePath, this.progress, this.progressText);
}
