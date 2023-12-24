import 'package:chat_app/src/core/services/auth/register_or_login.dart';
import 'package:chat_app/src/screen/auth/login_screen.dart';
import 'package:chat_app/src/screen/auth/splash_screen.dart';
import 'package:chat_app/src/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: RegisterOrLogin(),
    );
  }
}
