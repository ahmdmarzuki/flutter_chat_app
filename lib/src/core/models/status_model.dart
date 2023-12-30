import 'package:flutter/material.dart';

class StatusModel {
  final String statusId;
  final String text;
  final String uid;
  final String? username;
  final int colorCode;
  final DateTime postAt;

  StatusModel( {
    required this.statusId,
    required this.text,
    required this.uid,
    required this.username,
    required this.colorCode,
    required this.postAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusId':statusId,
      'text': text,
      'uid': uid,
      'username': username,
      'color_code': colorCode,
      'postAt': postAt,
    };
  }
}
