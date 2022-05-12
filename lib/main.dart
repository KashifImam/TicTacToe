import 'package:flutter/material.dart';
import 'package:tictactoerapidor/ui/home_page.dart';
import 'package:tictactoerapidor/ui/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tic Tac Toe",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SplashPage(),
    );
  }
}

