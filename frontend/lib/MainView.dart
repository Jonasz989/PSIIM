import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'MapView.dart';
import 'AlbumView.dart';
import 'ProgressView.dart';
import 'LeaderboardView.dart';
import 'SubmitView.dart';

class MainView extends StatelessWidget {
  final String accessToken;

  MainView({required this.accessToken});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      MaterialPageRoute(
                          builder: (context) => MapView(
                                accessToken: accessToken,
                              )),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color.fromARGB(120, 78, 3, 198),
                          Color.fromARGB(179, 205, 46, 233),
                          Color.fromARGB(255, 191, 0, 209),
                        ])),
                    child: const Center(
                      child: Text(
                        'Map',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 30, 30, 30),
                        ),
                      ),
                    ),
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
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color.fromARGB(120, 78, 3, 198),
                          Color.fromARGB(179, 205, 46, 233),
                          Color.fromARGB(255, 191, 0, 209),
                        ])),
                    child: const Center(
                      child: Text(
                        'Album',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 30, 30, 30),
                        ),
                      ),
                    ),
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
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color.fromARGB(120, 78, 3, 198),
                          Color.fromARGB(179, 205, 46, 233),
                          Color.fromARGB(255, 191, 0, 209),
                        ])),
                    child: const Center(
                      child: Text(
                        'Progress',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 30, 30, 30),
                        ),
                      ),
                    ),
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
                          builder: (context) => LeaderboardView(
                                accessToken: accessToken,
                              )),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color.fromARGB(120, 78, 3, 198),
                          Color.fromARGB(179, 205, 46, 233),
                          Color.fromARGB(255, 191, 0, 209),
                        ])),
                    child: const Center(
                      child: Text(
                        'Ranking',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 30, 30, 30),
                        ),
                      ),
                    ),
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
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color.fromARGB(255, 2, 57, 255),
                          Color.fromARGB(255, 46, 124, 233),
                          Color.fromARGB(255, 0, 143, 209),
                        ])),
                    child: const Center(
                      child: Text(
                        'Submit F.A.M code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 30, 30, 30),
                        ),
                      ),
                    ),
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
