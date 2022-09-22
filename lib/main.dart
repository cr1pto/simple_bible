import 'package:flutter/material.dart';
import 'package:simple_bible/screens/home.dart';
import 'package:simple_bible/screens/settings.dart';
import 'package:simple_bible/shared/menu_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlobApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SettingsScreen(),
      home: HomeScreen(),
    );
  }
}
