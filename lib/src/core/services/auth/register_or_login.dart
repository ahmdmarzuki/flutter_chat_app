import 'package:chat_app/src/screen/auth/login_screen.dart';
import 'package:chat_app/src/screen/auth/register_screen.dart';
import 'package:flutter/material.dart';

class RegisterOrLogin extends StatefulWidget {
  const RegisterOrLogin({super.key});

  @override
  State<RegisterOrLogin> createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  bool showLoginScreen = true;

  void toggleNav() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(onTap: () {
        toggleNav();
      });
    } else {
      return RegisterScreen(onTap: () {
        toggleNav();
      });
    }
  }
}
