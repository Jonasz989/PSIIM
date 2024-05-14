import 'package:flutter/material.dart';
import 'MapView.dart';
import 'AlbumView.dart';
import 'ProgressView.dart';
import 'LeaderboardView.dart';
import 'SubmitView.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Center(
          child: Wrap(
            spacing: 30, // space between the tiles
            runSpacing: 30, // space between the rows
            alignment: WrapAlignment.center, // center the tiles
            children: <Widget>[
              Container(
                width: 140,
                height: 89,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapView()),
                    );
                  },
                  child: Container(
                    color: Colors.blue,
                    child: Center(child: Text('Map')),
                  ),
                ),
              ),
              Container(
                width: 140,
                height: 89,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlbumView()),
                    );
                  },
                  child: Container(
                    color: Colors.green,
                    child: Center(child: Text('Album')),
                  ),
                ),
              ),
              Container(
                width: 140,
                height: 89,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProgressView()),
                    );
                  },
                  child: Container(
                    color: Colors.yellow,
                    child: Center(child: Text('Progress')),
                  ),
                ),
              ),
              Container(
                width: 140,
                height: 89,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderboardView()),
                    );
                  },
                  child: Container(
                    color: Colors.red,
                    child: Center(child: Text('Leaderboard')),
                  ),
                ),
              ),
              Container(
                width: 140 * 2 + 30, // width of two tiles and their spacing
                height: 89,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubmitView()),
                    );
                  },
                  child: Container(
                    color: Colors.purple,
                    child: Center(child: Text('Submit a F.A.M code')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
