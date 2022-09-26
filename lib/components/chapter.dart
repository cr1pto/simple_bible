import 'package:flutter/material.dart';

import '../models/bible.dart';
import 'verse.dart';

class Chapter extends StatelessWidget {
  const Chapter({
    super.key,
    required this.bookName,
    required this.chapter,
  });

  final String bookName;
  final BibleChapter chapter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chapter.verses.length,
      itemBuilder: (context, i) {
        return Verse(verse: chapter.verses[i]);
      },
    );
  }
}
