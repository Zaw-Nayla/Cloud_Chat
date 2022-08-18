import 'package:chat_app/leadingpage.dart';
import 'package:chat_app/login.dart';
import 'package:chat_app/chatScreen.dart';
import 'package:chat_app/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const FrontScreen(),
        '/login': (context) => const MyLogInPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => const Mainpage(),
      },
    );
  }
}
