import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/PostLogin.dart';
import 'MainView.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  Future<PostLogin?>? post;

  Future<PostLogin> authenticate() async {
    Map<String, dynamic> request = {
      'usernameOrEmail': username,
      'password': password
    };

    String requestBody = jsonEncode(request);

    print('Request body: $requestBody');

    final uri = Uri.parse("http://192.168.1.2:8080/api/auth/login");

    try {
      final response = await http.post(uri, body: requestBody, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return PostLogin.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 500) {
        throw Exception('Bad credentials');
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  void clickSubmitButton() {
    setState(() {
      post = authenticate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    } else
                      username = value;
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else
                      password = value;
                    return null;
                  },
                ),
                SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FutureBuilder<PostLogin?>(
                        future: post,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainView(
                                          accessToken:
                                              snapshot.data!.accessToken,
                                        )),
                              );
                            });
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      clickSubmitButton();
                    }
                  },
                  child: Text('Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
