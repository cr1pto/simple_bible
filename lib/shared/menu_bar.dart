// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/screens/bible_screen.dart';
import 'package:simple_bible/screens/home.dart';
import 'package:simple_bible/screens/settings.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

@Injectable()
class MenuDrawer extends StatelessWidget {
  final Color color;
  final double fontSize;

  const MenuDrawer({
    super.key,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: color,
      width: 250,
      child: ListView(
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Simple Bible',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    // color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Home",
                  style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              )),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Bible",
                  style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              )),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BibleScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
