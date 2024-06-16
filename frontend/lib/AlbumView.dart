import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/GetPoints.dart';

class AlbumView extends StatefulWidget {
  final String accessToken;
  AlbumView({required this.accessToken});
  @override
  _AlbumState createState() => _AlbumState(accessToken: accessToken);
}

class _AlbumState extends State<AlbumView> {
  String accessToken;
  Future<List<GetPoints>>? monuments;
  _AlbumState({required this.accessToken});
  @override
  void initState() {
    super.initState();
    monuments = _fetchMonuments();
  }

  Future<List<GetPoints>> _fetchMonuments() async {
    final String apiUrl = 'http://10.0.2.2:8080/api/pois';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> listOfMonuments = jsonDecode(response.body);
        return listOfMonuments.map((item) => GetPoints.fromJson(item)).toList();
      } else {
        throw Exception("Something went wrong: ${response.statusCode}");
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
              child: FutureBuilder<List<GetPoints>>(
                  future: monuments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child:
                              Text('Something went wrong: ${snapshot.error}'));
                    } else {
                      if (snapshot.hasData) {
                        final places = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: places.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    child: Image.asset(
                                      'assets/images/wyspa.jpg',
                                      width: 171,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        places[index].name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(places[index].description),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                    return Container();
                  })),
        ],
      ),
    );
  }
}
