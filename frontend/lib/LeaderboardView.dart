import 'package:flutter/material.dart';

class User {
  final String imagePath;
  final String name;

  User(this.imagePath, this.name);
}

class LeaderboardView extends StatelessWidget {
  final List<User> users = [
    User('assets/images/user1.jpg', 'John Doe'),
    User('assets/images/user2.jpg', 'Jane Doe'),
    // Add more users here
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
                            backgroundImage: AssetImage(users[index].imagePath),
                          ),
                          title: Text(
                            users[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
