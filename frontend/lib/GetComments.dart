import 'package:flutter/material.dart';

class GetComments {
  final int id;
  final int userId;
  final String text;
  final int monumentPoiId;
  final String date;

  GetComments({
    required this.id,
    required this.userId,
    required this.text,
    required this.monumentPoiId,
    required this.date,
  });

  factory GetComments.fromJson(Map<String, dynamic> json) {
    return GetComments(
      id: json['id'],
      userId: json['userId'],
      text: json['text'],
      monumentPoiId: json['monumentPoiId'],
      date: json['date'],
    );
  }
}
