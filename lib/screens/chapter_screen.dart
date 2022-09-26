// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/verses_screen.dart';

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
    return MainLayout(
      floatingBack: true,
      floatingBackHero: "chapter-back",
      child: VersesScreen(
        title: '$bookName - ${chapter.index}',
        verses: chapter.verses,
      ),
    );
  }
}
