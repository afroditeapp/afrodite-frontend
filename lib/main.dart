import 'package:flutter/material.dart';
import 'package:pihka_frontend/ui/home.dart';
import 'package:pihka_frontend/ui/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pihka frontend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder> {
        "/login": (context) => const LoginPage(title: "Test")
      },
      debugShowCheckedModeBanner: false,
    );
  }
}