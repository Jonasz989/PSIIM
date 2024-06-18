import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/GetComments.dart';
import 'package:frontend/GetUser.dart';
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
  int? userId;
  String? name;
  Future<GetUser>? userdata;
  Future<List<GetComments>>? comments;
  final _commentController = TextEditingController();

  _ForumState({required this.accessToken, required this.monumentId});

  @override
  void initState() {
    super.initState();
    comments = _fetchComments();
    userdata = _fetchUserData();
  }

  Future<List<GetComments>> _fetchComments() async {
    final String apiUrl = 'https://psiim-82a14bc94a7d.herokuapp.com/api/pois/' +
        monumentId +
        '/comments';
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

  Future<GetUser> _fetchUserData() async {
    final String apiUrl = 'https://psiim-82a14bc94a7d.herokuapp.com/api/user';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        return GetUser.fromJson(jsonDecode(response.body));
      } else
        throw Exception('Something went wrong: ${response.statusCode}');
    } catch (e) {
      throw e;
    }
  }

  Future<void> _postComment(String comment) async {
    final String apiUrl =
        'https://psiim-82a14bc94a7d.herokuapp.com/api/comments';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(
            {'userId': userId, 'monumentPoiId': monumentId, 'text': comment}),
      );

      if (response.statusCode == 200) {
        setState(() {
          comments = _fetchComments();
        });
        _commentController.clear();
      } else {
        throw Exception("Failed to post comment: ${response.statusCode}");
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
            bottom: MediaQuery.of(context).size.height * 0.1,
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
              },
            ),
          ),
          Positioned(
            child: FutureBuilder<GetUser>(
              future: userdata,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        'Something went terribly wrong: ${snapshot.error}'),
                  );
                } else {
                  if (snapshot.hasData) {
                    final userdatas = snapshot.data;
                    userId = userdatas?.id;
                  }
                }
                return Container();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Enter your comment...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        _postComment(_commentController.text);
                      }
                    },
                    child: Text('Post'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
