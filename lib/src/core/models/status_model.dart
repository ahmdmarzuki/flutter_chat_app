import 'package:flutter/material.dart';

class StatusModel {
  final String text;
  final String uid;
  final String? username;

  StatusModel({required this.text, required this.uid, required this.username});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'uid': uid,
      'username': username,
    };
  }
}
