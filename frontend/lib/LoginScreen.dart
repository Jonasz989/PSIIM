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
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String username = '';
  String password = '';
  Future<PostLogin?>? post;

  Future<PostLogin> authenticate() async {
    Map<String, dynamic> request = {
      'usernameOrEmail': username,
      'password': password
    };

    // Convert the request map to a JSON string
    String requestBody = jsonEncode(request);

    // Log the request body for debugging purposes
    print('Request body: $requestBody');

    // Update this line based on your environment (emulator, simulator, or real device)
    final uri =
        Uri.parse("http://10.0.2.2:8080/api/auth/login"); // Android Emulator
    // final uri = Uri.parse("http://192.168.x.x:8080/api/auth/login"); // iOS Simulator or Real Device

    try {
      // Include the headers for JSON content
      final response = await http.post(uri, body: requestBody, headers: {
        'Content-Type': 'application/json',
      });

      // Log response status code and body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return PostLogin.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 500) {
        throw Exception('Bad credentials');
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } catch (e) {
      // Log the exception for debugging purposes
      print('Exception caught: $e');
      throw e;
    }
  }

  void clickSubmitButton() {
    setState(() {
      username = _usernameController.text;
      password = _passwordController.text;
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
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
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
                            // Log the error for debugging purposes
                            print('Snapshot error: ${snapshot.error}');
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // Data is successfully received, navigate to MainView
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
                  child: Text('Go to Main View'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
