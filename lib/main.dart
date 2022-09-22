import 'package:flutter/material.dart';
import 'package:simple_bible/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Bible',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SettingsScreen(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
