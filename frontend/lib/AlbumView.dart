import 'package:flutter/material.dart';

class AlbumView extends StatelessWidget {
  final List<Map<String, dynamic>> places = [
    {
      'image': 'assets/images/wyspa.jpg',
      'name': 'Wyspa Slodowa',
      'description': 'piwko mmmm',
    },
    {
      'image': 'assets/images/wyspa.jpg',
      'name': 'Wyspa Slodowa part 2',
      'description': 'chlopcy z miasta pija piasta',
    },
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
                  Color.fromARGB(204, 255, 88, 252),
                  Color.fromARGB(247, 60, 0, 255),
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Album',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50, // Adjust this value as needed
                        child: Image.asset(
                          places[index]['image'],
                          width: 171,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            places[index]['name'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(places[index]['description']),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
