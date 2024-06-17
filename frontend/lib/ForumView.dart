import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/GetComments.dart';
import 'package:http/http.dart' as http;

class ForumView extends StatefulWidget {
  final String accessToken;
  final String monumentId;
  ForumView({required this.accessToken, required this.monumentId});
  @override
  _ForumState createState() =>
      _ForumState(accessToken: accessToken, monumentId: monumentId);
}

class _ForumState extends State<ForumView> {
  String accessToken;
  String monumentId;
  Future<List<GetComments>>? comments;
  _ForumState({required this.accessToken, required this.monumentId});
  @override
  void initState() {
    super.initState();
    comments = _fetchComments();
  }

  Future<List<GetComments>> _fetchComments() async {
    final String apiUrl =
        'http://10.0.2.2:8080/api/pois/' + monumentId + '/comments';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> listOfComments = jsonDecode(response.body);
        return listOfComments
            .map((item) => GetComments.fromJson(item))
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
          )),
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
            child: FutureBuilder<List<GetComments>>(
                future: comments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Something is no yes: ${snapshot.error}'),
                    );
                  } else {
                    if (snapshot.hasData) {
                      final commentss = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: commentss.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      commentss[index].userId.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(commentss[index].text),
                                    SizedBox(height: 5)
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
                }))
      ],
    ));
  }
}
