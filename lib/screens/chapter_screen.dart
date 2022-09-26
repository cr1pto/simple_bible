// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/verses_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class ChapterScreen extends StatelessWidget {
  const ChapterScreen({
    super.key,
    required this.bookName,
    required this.chapter,
  });

  final String bookName;
  final BibleChapter chapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_circle_left),
      ),
      body: VersesScreen(
          title: '$bookName - ${chapter.index}', verses: chapter.verses),
    );
  }
}
