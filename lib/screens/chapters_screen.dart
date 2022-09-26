// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/chapter_screen.dart';

import '../layouts/main_layout.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({
    super.key,
    required this.bookName,
    required this.chapters,
  });

  final String bookName;
  final List<BibleChapter> chapters;

  openSelectedChapter(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(
          bookName: bookName,
          chapter: chapters[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      floatingBack: true,
      floatingBackHero: "chapters-back",
      child: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(chapters[i].index.toString()),
            onTap: () => {
              openSelectedChapter(context, i),
            },
          );
        },
      ),
    );
  }
}
