// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/verse_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class VersesScreen extends StatelessWidget {
  const VersesScreen({super.key, required this.title, required this.verses});

  final String title;
  final List<BibleVerse> verses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // backgroundColor: Color(settingColor),
      ),
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      body: ListView.builder(
        itemCount: verses.length,
        itemBuilder: (context, i) {
          return VerseScreen(verse: verses[i]);
        },
      ),
    );
  }
}
