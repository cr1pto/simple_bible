// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/screens/bible_screen.dart';
import 'package:simple_bible/screens/home.dart';
import 'package:simple_bible/screens/settings.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
    required this.color,
    required this.fontSize,
  });

  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: color),
            child: const Text(
              'Simple Bible',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
          ),
          ListTile(
            title: Text("Home", style: TextStyle(fontSize: fontSize)),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            title: Text("Bible", style: TextStyle(fontSize: fontSize)),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => BibleScreen()),
              );
            },
          ),
          ListTile(
            title: Text(
              "Settings",
              style: TextStyle(fontSize: fontSize),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
