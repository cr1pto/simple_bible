// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/chapter_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({
    super.key,
    required this.bookName,
    required this.chapters,
  });

  final String bookName;
  final List<BibleChapter> chapters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        heroTag: bookName,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_circle_left),
      ),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(chapters[i].index.toString()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChapterScreen(bookName: bookName, chapter: chapters[i]),
              ));
            },
          );
        },
      ),
    );
  }
}
