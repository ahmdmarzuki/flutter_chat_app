import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/src/core/services/auth/auth_service.dart';
import 'package:chat_app/src/core/services/auth/register_or_login.dart';
import 'package:chat_app/src/core/services/chat/chat_service.dart';
import 'package:chat_app/src/screen/auth/login_screen.dart';
import 'package:chat_app/src/screen/auth/splash_screen.dart';
import 'package:chat_app/src/screen/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
